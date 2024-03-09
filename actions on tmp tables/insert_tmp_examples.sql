CREATE TEMP TABLE workers_tmp AS
  SELECT * FROM workers WITH NO DATA; -- SELECT * FROM workers;
-- OR
CREATE TEMP TABLE workers_tmp
( LIKE workers INCLUDING CONSTRAINTS INCLUDING INDEXES );

CREATE TEMP TABLE workers_log AS
  SELECT * FROM workers WITH NO DATA;

ALTER TABLE workers_log ADD COLUMN created_at timestamp;
ALTER TABLE workers_log ADD COLUMN operation text;

WITH add_row AS
( INSERT INTO workers_tmp
    SELECT * FROM workers
    RETURNING *
)
INSERT INTO workers_log
  SELECT add_row.id,
         add_row.name,
         add_row.unit_id,
         add_row.working_place_id,
         add_row.second_working_place_id,
         add_row.skills,
         add_row.salary,
         current_timestamp,
         'INSERT'
    FROM add_row;

-- ON CONFLICT DO NOTHING
WITH add_row AS
( INSERT INTO workers_tmp
    (id, name, unit_id, working_place_id, second_working_place_id, skills, salary)
    VALUES ( 5, 'Natali', 1, 4, 5, null, 15000)
    ON CONFLICT DO NOTHING
    RETURNING *
)
INSERT INTO workers_log
  SELECT add_row.id, add_row.name, add_row.unit_id,
         add_row.working_place_id, add_row.second_working_place_id,
         add_row.skills, add_row.salary,
         current_timestamp, 'INSERT'
    FROM add_row;

INSERT INTO workers_tmp
  (id, name, unit_id, working_place_id, second_working_place_id, skills, salary)
  VALUES ( 5, 'Natali', 1, 4, 5, null, 15000)
  ON CONFLICT (unit_id) DO NOTHING
  RETURNING *;

-- ON CONFLICT DO UPDATE
INSERT INTO workers_tmp
  (id, name, unit_id, working_place_id, second_working_place_id, skills, salary)
  VALUES ( 5, 'Natali', 1, 4, 6, null, 18000)
  ON CONFLICT ON CONSTRAINT workers_tmp_pkey
  DO UPDATE SET salary = excluded.salary
  RETURNING *;

-- COPY
COPY workers_tmp FROM '/insert_file_example.txt' DELIMITER '|';
COPY workers_tmp TO '/workers_tmp.txt' WITH ( FORMAT csv );

COPY workers_tmp FROM STDIN WITH ( FORMAT csv );
12,Serhii,1,12,22,null,9999
13,Ivan,1,7,33,null,12500
\.
