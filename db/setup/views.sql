/*
View complete information about bands and their artists
*/
SET SEARCH_PATH TO biasbinder_bst;

DROP VIEW IF EXISTS group_artist_details;
CREATE VIEW group_artist_details AS
SELECT
    g.groups_id,
    g.groups_name,
    g.gender,
    a.artists_id AS artist_id,
    a.stage_name,
    a.active
FROM
    groups g
        JOIN
    groups_artists ga ON g.groups_id = ga.groups_id
        JOIN
    artists a ON a.artists_id = ga.artists_id
WHERE
    a.proposed = false AND g.proposed = false;
/*
View of albums and their versions
*/
DROP VIEW IF EXISTS album_version_details;
CREATE VIEW album_version_details AS
SELECT
    os.official_sources_id AS album_id,
    os.title AS album_title,
    os.version_name,
    os.type AS album_type
FROM
    official_sources os
WHERE
    os.proposed = false AND os.type = 'Album';

/*
View photo cards from events
*/
DROP VIEW IF EXISTS event_photocard_details;
CREATE VIEW event_photocard_details AS
SELECT
    os.official_sources_id AS event_id,
    os.title AS event_title,
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.pc_type
FROM
    official_sources os
        JOIN
    photocards pc ON os.official_sources_id = pc.official_sources_id
WHERE
    os.type = 'Event' AND pc.pc_type = 'PCE';

/*
View of official merchandising by group
*/
DROP VIEW IF EXISTS official_merch_by_group;
CREATE VIEW official_merch_by_group AS
SELECT
    g.groups_id,
    g.groups_name,
    os.official_sources_id AS merch_id,
    os.title AS merch_title,
    os.type AS merch_type
FROM
    groups g
        JOIN
    groups_official_sources gos ON gos.groups_id = g.groups_id
        JOIN
    official_sources os ON os.official_sources_id = gos.official_sources_id;

/*
Full view of photo cards USEFULL ???
*/
DROP VIEW IF EXISTS all_photocards;
CREATE VIEW all_photocards AS
SELECT
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.url,
    pc.pc_type,
    a.stage_name
FROM
    photocards pc
        JOIN
    artists a ON a.artists_id = pc.artists_id
WHERE
    pc.proposed = false AND a.proposed = false;

/*
View of all photocards by album version
*/
DROP VIEW IF EXISTS photocards_for_album_version;
CREATE VIEW photocards_for_album_version AS
SELECT
    os.version_name AS album_version_name,
    os.title AS album_title,
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.pc_type
FROM
    official_sources os
        JOIN
    photocards pc ON pc.official_sources_id = os.official_sources_id
WHERE
    os.type = 'Album';

/*
View of all photocards for specific group
*/
DROP VIEW IF EXISTS photocards_for_group;
CREATE VIEW photocards_for_group AS
SELECT
    g.groups_id AS group_id,
    g.groups_name,
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.url,
    pc.proposed,
    pc.pc_type,
    pc.artists_id,
    os.title AS source_title,
    os.official_sources_id
FROM
    groups g
        JOIN
    groups_artists ga ON g.groups_id = ga.groups_id
        JOIN
    artists a ON a.artists_id = ga.artists_id
        JOIN
    photocards pc ON pc.artists_id = a.artists_id
        JOIN
    official_sources os ON os.official_sources_id = pc.official_sources_id
WHERE pc.proposed = false;


/*
View of all photocards for a specific artist
*/
DROP VIEW IF EXISTS photocards_for_artist;
CREATE VIEW photocards_for_artist AS
SELECT
    a.artists_id AS artist_id,
    a.stage_name,
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.pc_type,
    pc.url,
    os.official_sources_id,
    os.title AS source_title
FROM
    artists a
        JOIN
    photocards pc ON pc.artists_id = a.artists_id
        JOIN
    official_sources os ON os.official_sources_id = pc.official_sources_id
WHERE a.proposed = false AND pc.proposed = false;

/*
View of URL for all photocards from a specific album
*/
DROP VIEW IF EXISTS photocard_album_urls;
CREATE VIEW photocard_album_urls AS
SELECT
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.pc_type,
    g.groups_name,
    os.title AS album_title,
    artists_id,
    CONCAT(
            REPLACE(g.groups_name, ' ', '_'), '/',
            REPLACE(os.title, ' ', '_'), '/',
            REPLACE(pc.pc_name, ' ', '_'),'/',
            artists_id
    ) AS url
FROM
    photocards pc
        JOIN
    official_sources os ON os.official_sources_id = pc.official_sources_id
        JOIN
    groups_official_sources gos ON gos.official_sources_id = os.official_sources_id
        JOIN
    groups g ON g.groups_id = gos.groups_id;

/*
View of URL for all photocards from a specific event
*/
DROP VIEW IF EXISTS photocard_event_urls;
CREATE VIEW photocard_event_urls AS
SELECT
    pc.pc_id AS photocard_id,
    pc.pc_name,
    pc.pc_type,
    g.groups_name,
    os.title AS event_title,
    artists_id,
    CONCAT(
            REPLACE(g.groups_name, ' ', '_'), '/',
            REPLACE(os.title, ' ', '_'), '/',
            REPLACE(pc.pc_name, ' ', '_'),'/',
            artists_id
    ) AS url
FROM
    photocards pc
        JOIN
    official_sources os ON os.official_sources_id = pc.official_sources_id
        JOIN
    groups_official_sources gos ON gos.official_sources_id = os.official_sources_id
        JOIN
    groups g ON g.groups_id = gos.groups_id
WHERE
    os.type = 'Event';


/*
View of all names by photocards to use via research
*/
DROP VIEW IF EXISTS photocard_event_urls;
CREATE VIEW all_names_to_search AS
    SELECT p.pc_id,p.pc_name,p.url,p.pc_type,p.shop_name,os.title,a.stage_name AS artist_name,g.groups_id AS group_id,g.groups_name AS group_name
    FROM photocards p
    INNER JOIN biasbinder_bst.official_sources os on os.official_sources_id = p.official_sources_id
    INNER JOIN biasbinder_bst.artists a on a.artists_id = p.artists_id
    INNER JOIN biasbinder_bst.groups_artists ga on a.artists_id = ga.artists_id
    INNER JOIN biasbinder_bst.groups g on g.groups_id = ga.groups_id
    WHERE p.proposed = false AND os.proposed = false AND a.proposed = false AND g.proposed = false;
