SET SEARCH_PATH TO biasbinder_bst;

-- Create the table users

INSERT INTO users (username, password, is_admin) VALUES
                                                     ('jungkook97', 'hashed_password_1', FALSE),
                                                     ('blackpinkfan', 'hashed_password_2', FALSE),
                                                     ('exo-l', 'hashed_password_3', FALSE),
                                                     ('straykidsfan', 'hashed_password_4', FALSE),
                                                     ('ateezlover', 'hashed_password_5', FALSE);

-- Jungkook97
INSERT INTO users_photocard_list (user_id, pc_id, have) VALUES
                                                            (1, 1, TRUE),   -- Possède "THE WORLD EP.2 : OUTLAW (Z ver.)"
                                                            (1, 5, TRUE),   -- Possède "Limitless (Type B)"
                                                            (1, 10, FALSE), -- Veut "GOLDEN HOUR : Part.2 DIGIPACK ver."
                                                            (1, 15, FALSE); -- Veut "THE WORLD EP.FIN : WILL (A ver.)"

-- BlackPinkFan
INSERT INTO users_photocard_list (user_id, pc_id, have) VALUES
                                                            (2, 2, TRUE),   -- Possède "Season Songs"
                                                            (2, 6, TRUE),   -- Possède "THE WORLD EP.PARADIGM STANDARD ver."
                                                            (2, 20, FALSE); -- Veut "GOLDEN HOUR : Part.2 (FOR ver.)"

--  Exo-L
INSERT INTO users_photocard_list (user_id, pc_id, have) VALUES
                                                            (3, 3, TRUE),   -- Possède "TREASURE EP.3 : One To All WAVE ver."
                                                            (3, 25, FALSE); -- Veut "SPIN OFF : FROM THE WITNESS (POCAALBUM A ver.)"

--  StrayKidsFan
INSERT INTO users_photocard_list (user_id, pc_id, have) VALUES
                                                            (4, 4, TRUE),   -- Possède "Limitless (Type B)"
                                                            (4, 30, FALSE); -- Veut "THE WORLD EP.PARADIGM LIMITED ver."

--  AteezLover
INSERT INTO users_photocard_list (user_id, pc_id, have) VALUES
                                                            (5, 21, TRUE),  -- Possède "SPIN OFF : FROM THE WITNESS [WITNESS ver.] (LIMITED EDITION)"
                                                            (5, 50, FALSE); -- Veut "THE WORLD EP.PARADIGM STANDARD ver."