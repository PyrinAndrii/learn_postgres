
-- UNITS
INSERT INTO units (title) VALUES ('ODA');

-- WORKING PLACES
INSERT INTO working_places (floor, room, place_number) VALUES (1, 1, 1);
INSERT INTO working_places (floor, room, place_number) VALUES (1, 1, 2);
INSERT INTO working_places (floor, room, place_number) VALUES (1, 1, 3);
INSERT INTO working_places (floor, room, place_number) VALUES (1, 1, 4);
INSERT INTO working_places (floor, room, place_number) VALUES (1, 2, 1);
INSERT INTO working_places (floor, room, place_number) VALUES (1, 2, 2);
INSERT INTO working_places (floor, room, place_number) VALUES (2, 1, 1);
INSERT INTO working_places (floor, room, place_number) VALUES (2, 2, 1);

-- WORKERS
INSERT INTO workers (name, unit_id, working_place_id) VALUES ('Petro', 1, 1);
INSERT INTO workers (name, unit_id, working_place_id, second_working_place_id) VALUES ('Mykola', 1, 2, 3);
INSERT INTO workers (name, unit_id, working_place_id, second_working_place_id) VALUES ('Natali', 1, 4, 5);
INSERT INTO workers (name, unit_id, working_place_id, second_working_place_id) VALUES ('Suzanna', 1, 5, 6);

UPDATE workers
  SET skills =
  '{
    "languages": { "uk": "C1", "en": "A2" },
    "blind_typing": true
  }' -- ::jsonb
  WHERE name = 'Petro';
