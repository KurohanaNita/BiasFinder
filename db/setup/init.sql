DROP SCHEMA IF EXISTS BiasBinder_BST CASCADE;
CREATE SCHEMA biasbinder_bst AUTHORIZATION biasbinder_dev;
GRANT ALL ON SCHEMA biasbinder_bst TO biasbinder_dev;
COMMENT ON SCHEMA biasbinder_bst IS 'BiasFinderV1';
SET SEARCH_PATH TO biasbinder_bst;

CREATE TABLE groups
(
    groups_id SERIAL,
    groups_name VARCHAR(50) UNIQUE,
    gender CHAR(1),
    proposed BOOLEAN default true,
    PRIMARY KEY(groups_id)
);

CREATE TABLE artists
(
    artists_id SERIAL,
    stage_name VARCHAR(50) UNIQUE,
    active BOOLEAN default true,
    proposed BOOLEAN default true,
    PRIMARY KEY(artists_id)
);

-- Define the enumeration type for album medium
CREATE TYPE SOURCE_TYPE_ENUM AS ENUM ('ALBUM', 'OTHER', 'EVENT');

CREATE TABLE official_sources
(
    official_sources_id SERIAL,
    title VARCHAR(255),
    version_name VARCHAR(255) default null,
    type SOURCE_TYPE_ENUM,
    proposed BOOLEAN default true,
    PRIMARY KEY (official_sources_id)
);


-- CI
CREATE UNIQUE INDEX unique_official_sources_title_version_name_release_date_type
    ON official_sources (title, COALESCE(version_name, ''),type);


-- Define the enumeration type for photocards type
CREATE TYPE PC_TYPE_ENUM AS ENUM ('PCA', 'POB', 'PCO', 'PCE');

CREATE TABLE photocards
(
    pc_id SERIAL,
    pc_name VARCHAR(255),
    shop_name VARCHAR(255) default null,
    url VARCHAR(255),
    pc_type PC_TYPE_ENUM,
    proposed BOOLEAN default true,
    artists_id INT NOT NULL,
    official_sources_id INT NOT NULL,
    PRIMARY KEY (pc_id)
);

-- CI
CREATE UNIQUE INDEX unique_pc_name_type_artist_official_sources
ON photocards(pc_name,pc_type,artists_id,official_sources_id,url);

CREATE TABLE users
(
   user_id SERIAL,
   username VARCHAR(50) UNIQUE,
   email VARCHAR(255) NOT NULL UNIQUE,
   password VARCHAR(255),
   is_admin BOOLEAN default false,
   is_2fa_enabled BOOLEAN default false,
   code_2fa VARCHAR(10) default null,
   oauth_provider VARCHAR(30) default null,
   oauth_id VARCHAR(255) default null,
   PRIMARY KEY (user_id)
);


--
-- Table structure for relationships
--

CREATE TABLE groups_artists
(
    groups_id INT,
    artists_id INT,
    PRIMARY KEY (groups_id,artists_id)
);


CREATE TABLE groups_official_sources
(
    groups_id INT,
    official_sources_id INT,
    PRIMARY KEY (groups_id,official_sources_id)
);


CREATE TABLE users_photocard_list
(
  user_id INT not null,
  pc_id INT not null,
  have BOOLEAN default false,
  PRIMARY KEY (user_id,pc_id)
);

--
-- Constraints for tables
--

--photocards constraints
-- Foreign key constraints for artists : not null and unique photocards name
ALTER TABLE photocards ADD CONSTRAINT fk_artists FOREIGN KEY (artists_id) REFERENCES artists(artists_id) ON DELETE CASCADE;
ALTER TABLE photocards ADD CONSTRAINT fk_official_sources FOREIGN KEY (official_sources_id) REFERENCES official_sources(official_sources_id) ON DELETE CASCADE;

--groups_artistss constraints
-- Foreign key constraints for groups and artists
ALTER TABLE groups_artists ADD CONSTRAINT fk_groups FOREIGN KEY (groups_id) REFERENCES groups(groups_id) ON DELETE CASCADE;
ALTER TABLE groups_artists ADD CONSTRAINT fk_artists FOREIGN KEY (artists_id) REFERENCES artists(artists_id) ON DELETE CASCADE;

--groups_official_source constraints
-- Foreign keyy constraints for groups and official_sources
ALTER TABLE groups_official_sources ADD CONSTRAINT fk_groups FOREIGN KEY (groups_id) REFERENCES groups(groups_id) ON DELETE CASCADE;
ALTER TABLE groups_official_sources ADD CONSTRAINT fk_official_sources FOREIGN KEY (official_sources_id) REFERENCES official_sources(official_sources_id) ON DELETE CASCADE;

--users_photocards_List constraints
-- Foreign key constraints for users and photocards
ALTER TABLE users_photocard_list ADD CONSTRAINT fk_users FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;
ALTER TABLE users_photocard_list ADD CONSTRAINT fk_photocards FOREIGN KEY (pc_id) REFERENCES photocards(pc_id) ON DELETE CASCADE;