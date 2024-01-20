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
SELECT task_id, title, count( * ) FROM task_goals GROUP BY task_id, title ORDER BY count DES;
```
