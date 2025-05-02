SET SEARCH_PATH TO biasbinder_bst;
--
-- Triggers for unit artist
--
CREATE OR REPLACE FUNCTION create_artist_for_group()
RETURNS TRIGGER AS $$
DECLARE
new_artist_id INT;
BEGIN
INSERT INTO artists(stage_name, active, proposed)
SELECT groups_name || ': Unit', TRUE, FALSE
FROM groups
WHERE groups_id = NEW.groups_id
    RETURNING artists_id INTO new_artist_id;

-- Créer l'association dans la table de jonction
INSERT INTO groups_artists(groups_id, artists_id)
VALUES (NEW.groups_id, new_artist_id);

-- Retourner la ligne insérée dans la table groups
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_create_artist
    AFTER INSERT ON groups
    FOR EACH ROW
    EXECUTE FUNCTION create_artist_for_group();

CREATE OR REPLACE FUNCTION add_null_version_name()
RETURNS TRIGGER AS $$
DECLARE
v_count INT;
BEGIN
    -- Vérifie s'il existe déjà une version avec version_name = NULL pour ce title
SELECT COUNT(*)
INTO v_count
FROM official_sources
WHERE title = NEW.title AND version_name IS NULL;

-- Si aucune version NULL n'existe, insère un enregistrement avec NULL
IF v_count = 0 THEN
        INSERT INTO official_sources (title, version_name, type, proposed)
        VALUES (NEW.title, NULL, NEW.type, FALSE);
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création du trigger
CREATE TRIGGER add_null_version_name_trigger
    AFTER INSERT OR UPDATE ON official_sources
                        FOR EACH ROW
                        EXECUTE FUNCTION add_null_version_name();

CREATE OR REPLACE FUNCTION manage_user_photocard_list()
RETURNS TRIGGER AS $$
BEGIN

    IF EXISTS (SELECT 1 FROM users_photocard_list WHERE user_id = NEW.user_id AND pc_id = NEW.pc_id) THEN

UPDATE users_photocard_list
SET have = NEW.have
WHERE user_id = NEW.user_id AND pc_id = NEW.pc_id;

RETURN NULL;
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_manage_user_photocard_list
    BEFORE INSERT ON users_photocard_list
    FOR EACH ROW
    EXECUTE FUNCTION manage_user_photocard_list();
