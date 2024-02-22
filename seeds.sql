
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
INSERT INTO workers (name, unit_id, salary, working_place_id) VALUES ('Petro', 1, 10000, 1);
INSERT INTO workers (name, unit_id, salary, working_place_id, second_working_place_id) VALUES ('Mykola', 1, 25000, 2, 3);
INSERT INTO workers (name, unit_id, salary, working_place_id, second_working_place_id) VALUES ('Natali', 1, 15000, 4, 5);
INSERT INTO workers (name, unit_id, salary, working_place_id, second_working_place_id) VALUES ('Suzanna', 1, 7500, 5, 6);

UPDATE workers
  SET skills =
  '{
    "languages": { "uk": "C1", "en": "A2" },
    "blind_typing": true
  }' -- ::jsonb
  WHERE name = 'Petro';

INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (3, 2, 1,  '2024-01-05');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (3, 1, 11, '2024-02-05');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (5, 1, 19, '2024-01-05');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (6, 2, 7,  '2024-01-17');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (6, 5, 8,  '2024-01-01');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (6, 6, 2,  '2024-01-15');
