```
CREATE TABLE table_name (...);
DROP TABLE table_name;

INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...), (value1, value2, ...);

SELECT column2, column1 FROM table_name;
SELECT column2, column1 FROM table_name ORDER BY column2;
SELECT column2, column1 FROM table_name WHERE column2 >= 20 AND column2 <= 30;

UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
UPDATE table_name SET column1 = column1 * 2 WHERE condition;

DELETE FROM table_name WHERE condition;

SELECT task_id, count( * ) FROM task_goals GROUP BY task_id;
SELECT task_id, title, count( * ), SUM(cost) FROM task_goals GROUP BY task_id, title ORDER BY count DESC;

-- Date and time commands:
SELECT 'Jan 21, 2024'::date;
SELECT '2024-01-21'::date;
SELECT to_char( current_date, 'dd/mm/yyyy' );
SELECT '14:41'::time;
SELECT '2:41:14 pm'::time;
SELECT current_time;

SELECT '2 years 1 month 3 days ago'::interval;
SELECT 'P0002-01-03T29:08:07'::interval;
SELECT ('2023-02-02'::timestamp - '2024-01-21'::timestamp)::interval;
SELECT ( date_trunc( 'min', current_timestamp ) );
SELECT extract( 'mon' FROM timestamp '1996-11-27 13:20:30.53241' );
```
