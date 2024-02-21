SELECT name, skills->'languages' AS languages FROM workers;
SELECT name, skills #>'{ languages, uk }' FROM workers;

SELECT * FROM workers WHERE name LIKE '%Adnrii%';
SELECT * FROM workers WHERE name NOT LIKE 'Andrii%' AND name NOT LIKE 'Petro%';
SELECT * FROM workers WHERE name LIKE '_____'; -- returns 5 characters long names
SELECT * FROM workers WHERE name ~ '^(And|Pet)'; -- returns names that start with 'And' or 'Pet'
SELECT * FROM workers WHERE name !~ 'rii$'; -- returns names that do not end with 'rii'
SELECT * FROM working_places WHERE floor BETWEEN 4 AND 8;
SELECT name, salary, round( salary / 37.5, 2 ) AS dollars FROM workers ORDER BY salary DESC LIMIT 3; -- OFFSET 3;

SELECT DISTINCT task_id FROM task_goals;
SELECT DISTINCT title FROM task_goals;
SELECT DISTINCT task_id, title FROM task_goals;

SELECT name, salary,
  CASE WHEN salary < 10000 THEN 'Low'
       WHEN salary < 20000 THEN 'Middle'
       ELSE 'High'
  END AS salary_level
  FROM workers
  ORDER BY salary_level;

-- JOINS

SELECT w.name, wp.room, wp.place_number
  FROM workers AS w
  JOIN working_places AS wp
    ON w.working_place_id = wp.id
  WHERE wp.floor = 1
  ORDER BY w.name;

SELECT w.name, wp.room, wp.place_number
  FROM workers w, working_places wp
  WHERE w.working_place_id = wp.id AND wp.floor = 1
  ORDER BY w.name;

-- 3 JOINs variants
SELECT w1.id, w1.name, w2.id, w2.name -- SELECT count( * )
  FROM workers w1, workers w2
  WHERE w1.name <> w2.name;

SELECT w1.id, w1.name, w2.id, w2.name -- SELECT count( * )
  FROM workers w1
  JOIN workers w2 ON w1.name <> w2.name;

SELECT w1.id, w1.name, w2.id, w2.name -- SELECT count( * )
  FROM workers w1 CROSS JOIN workers w2
  WHERE w1.name <> w2.name;

------------------------------------------------------------------------------------------------------------------
-- GROUP JOINs
SELECT w.id, w.name, tg.title, SUM ( tm.spent_hours ) total_spent_hours, count ( tm.spent_hours ) num_of_approaches
  FROM workers w
  JOIN time_spents tm ON w.id = tm.worker_id
  JOIN task_goals tg ON tm.task_goal_id = tg.id
  GROUP BY 1, 3
  ORDER BY w.name, tg.title;

--  id |  name   |    title     | total_spent_hours | num_of_approaches
-- ----+---------+--------------+-------------------+-------------------
--   5 | Natali  | Take notes 2 |                19 |                 1
--   3 | Petro   | Take notes 2 |                11 |                 1
--   3 | Petro   | Take notes 3 |                 1 |                 1
--   6 | Suzanna | Make coffee  |                10 |                 2
--   6 | Suzanna | Take notes 3 |                 7 |                 1

------------------------------------------------------------------------------------------------------------------
SELECT w.id, w.name, SUM ( tm.spent_hours ) total_spent_hours, count ( tm.spent_hours ) num_of_approaches
  FROM workers w
  LEFT OUTER JOIN time_spents tm ON w.id = tm.worker_id
  LEFT OUTER JOIN task_goals tg ON tm.task_goal_id = tg.id
  GROUP BY 1
  ORDER BY w.id;

--  id |  name   | total_spent_hours | num_of_approaches
-- ----+---------+-------------------+-------------------
--   3 | Petro   |                12 |                 2
--   5 | Natali  |                19 |                 1
--   6 | Suzanna |                17 |                 3
--   8 | Mykola  |                   |                 0


-- SELECT FROM VALUES
SELECT range.min_salary, range.max_salary, count( w.* )
  FROM workers w
  RIGHT OUTER JOIN
    (
      VALUES (0, 9999), (10000, 19999), (20000, 29999)
    ) AS range (min_salary, max_salary)
    ON w.salary >= range.min_salary AND w.salary < range.max_salary
  GROUP BY range.min_salary, range.max_salary
  ORDER BY range.min_salary;

--  min_salary | max_salary | count
-- ------------+------------+-------
--           0 |       9999 |     1
--       10000 |      19999 |     2
--       20000 |      29999 |     1


------------------------------------------------------------------------------------------------------------------
-- UNION, INTERSECT, EXCEPT
SELECT * FROM task_goals WHERE task_id IN (1, 2);
--  id |    title     | task_id |  cost
-- ----+--------------+---------+--------
--  15 | Take notes   |       2 |   0.00
--   3 | Take notes 3 |       1 |   0.00
--   5 | Make coffee  |       2 |   0.00
--  13 | Make coffee  |       1 |   0.00
--   1 | Take notes 2 |       2 | 331.45
--   4 | Take notes 3 |       2 |  23.00
--   2 | Take notes 3 |       2 |  22.00
--  16 | Final task   |       1 |  25.50

-- UNION (OR)
SELECT title FROM task_goals WHERE task_id = 1
UNION -- UNION ALL
SELECT title FROM task_goals WHERE task_id = 2
ORDER BY title;
--     title
-- --------------
--  Final task
--  Make coffee
--  Take notes
--  Take notes 2
--  Take notes 3
-- (4 rows)

-- INTERSECT (AND)
SELECT title FROM task_goals WHERE task_id = 1
INTERSECT -- INTERSECT ALL
SELECT title FROM task_goals WHERE task_id = 2
ORDER BY title;
--     title
-- --------------
--  Make coffee
--  Take notes 3
-- (2 rows)

-- EXCEPT
SELECT title FROM task_goals WHERE task_id = 1
EXCEPT -- EXCEPT ALL
SELECT title FROM task_goals WHERE task_id = 2
ORDER BY title;
--    title
-- ------------
--  Final task
-- (1 row)


SELECT avg( salary ) FROM workers;
SELECT min( salary ) FROM workers;
SELECT max( salary ) FROM workers;

SELECT w.name, count( * ), SUM( tm.spent_hours )
  FROM time_spents tm
  JOIN workers w ON w.id = tm.worker_id
  GROUP BY w.name
  ORDER BY count DESC;

-- HAVING (is using only after GROUP BY)
SELECT w.name, count( * ), SUM( tm.spent_hours )
  FROM time_spents tm
  JOIN workers w ON w.id = tm.worker_id
  GROUP BY w.name
  HAVING count( * ) >= 2 -- HAVING SUM( tm.spent_hours ) >= 15
  ORDER BY count DESC;
