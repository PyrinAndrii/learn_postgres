WITH update_row AS
( UPDATE workers_tmp
    SET salary = salary * 1.2
    WHERE name ~ '^P'
    RETURNING *
)
INSERT INTO workers_log
  SELECT update_row.id, update_row.name, update_row.unit_id,
         update_row.working_place_id, update_row.second_working_place_id,
         update_row.skills, update_row.salary,
         current_timestamp, 'UPDATE'
    FROM update_row;

SELECT * FROM workers_log
  WHERE name ~ '^P' ORDER BY created_at;
