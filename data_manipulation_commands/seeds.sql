
-- UNITS
INSERT INTO units (title, language) VALUES ('ODA', 'uk');
INSERT INTO units (title, language) VALUES ('police', 'en');

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
INSERT INTO workers (id, name, unit_id, salary, working_place_id, second_working_place_id) VALUES (1, 'Petro', 1, 10000, 1, 2);
INSERT INTO workers (id, name, unit_id, salary, working_place_id, second_working_place_id) VALUES (2, 'Mykola', 1, 25000, 2, 3);
INSERT INTO workers (id, name, unit_id, salary, working_place_id, second_working_place_id) VALUES (5, 'Natali', 1, 15000, 4, 5);
INSERT INTO workers (id, name, unit_id, salary, working_place_id, second_working_place_id) VALUES (6, 'Suzanna', 1, 7500, 5, 6);

UPDATE workers
  SET skills =
  '{
    "languages": { "uk": "C1", "en": "A2" },
    "blind_typing": true
  }' -- ::jsonb
  WHERE name = 'Petro';

UPDATE workers
  SET skills =
  '{
    "languages": { "uk": "C1", "en": "C2" }
  }' -- ::jsonb
  WHERE name = 'Suzanna';

INSERT INTO tasks (id, title) VALUES (1, 'Make a coffee');
INSERT INTO tasks (id, title) VALUES (2, 'Clean');

INSERT INTO task_goals (id, title, task_id, cost) VALUES (1, 'Add sugar', 1, 5);
INSERT INTO task_goals (id, title, task_id, cost) VALUES (2, 'Add lemon', 1, 10);
INSERT INTO task_goals (id, title, task_id, cost) VALUES (3, 'Wash the floor', 2, 50);
INSERT INTO task_goals (id, title, task_id, cost) VALUES (4, 'Wipe a table', 2, 20);

INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (1, 2, 1,  '2024-01-05');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (1, 1, 11, '2024-02-05');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (5, 1, 19, '2024-01-05');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (6, 2, 7,  '2024-01-17');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (6, 3, 8,  '2024-01-01');
INSERT INTO time_spents (worker_id, task_goal_id, spent_hours, date) VALUES (6, 4, 2,  '2024-01-15');
