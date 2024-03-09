WITH delete_row AS
( DELETE FROM workers_tmp
    WHERE name ~ '^P'
    RETURNING *
)
INSERT INTO workers_log
  SELECT delete_row.id, delete_row.name, delete_row.unit_id,
         delete_row.working_place_id, delete_row.second_working_place_id,
         delete_row.skills, delete_row.salary,
         current_timestamp, 'DELETE'
    FROM delete_row;

DELETE FROM workers_tmp;
TRUNCATE workers_tmp;
