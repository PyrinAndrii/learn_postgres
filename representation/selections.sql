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
      VALUES (0, 9999), (10000, 19999), (20000, 29999) -- virtual table
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

-- WINDOW FUNCTIONS ( rant/count( * ) OVER (...) )
SELECT tasks.title,
			 task_goals.title,
			 w.name,
			 tm.date,
			 extract( 'month' from tm.date ) AS month,
       extract( 'day'   from tm.date ) AS day,
			 count( * ) OVER (
         PARTITION BY date_trunc( 'month', tm.date )
         ORDER BY tm.date
       ) AS count
	FROM time_spents tm
	JOIN workers w ON tm.worker_id = w.id
	JOIN task_goals ON tm.task_goal_id = task_goals.id
	JOIN tasks ON task_goals.task_id = tasks.id
	WHERE tasks.id = 2
	ORDER BY tm.date;

--     title    |    title     |  name   |    date    | month | day | count
-- -------------+--------------+---------+------------+-------+-----+-------
--  Create task | Make coffee  | Suzanna | 2024-01-01 |     1 |   1 |     1
--  Create task | Take notes 3 | Petro   | 2024-01-05 |     1 |   5 |     3
--  Create task | Take notes 2 | Natali  | 2024-01-05 |     1 |   5 |     3
--  Create task | Make coffee  | Suzanna | 2024-01-15 |     1 |  15 |     4
--  Create task | Take notes 3 | Suzanna | 2024-01-17 |     1 |  17 |     5
--  Create task | Take notes 2 | Petro   | 2024-02-05 |     2 |   5 |     1

-- RANK
SELECT w.name,
			 tm.spent_hours,
			 tm.date,
			rank() OVER (
				PARTITION BY w.name
				ORDER BY tm.spent_hours DESC
			)
  FROM time_spents tm
  JOIN workers w ON w.id = tm.worker_id
	ORDER BY w.name;

--   name   | spent_hours |    date    | rank
-- ---------+-------------+------------+------
--  Natali  |          19 | 2024-01-05 |    1
--  Petro   |          11 | 2024-02-05 |    1
--  Petro   |           1 | 2024-01-05 |    2
--  Suzanna |           8 | 2024-01-15 |    1
--  Suzanna |           7 | 2024-01-17 |    2
--  Suzanna |           2 | 2024-01-01 |    3


------------------------------------------------------------------------------------------------------------------
-- SUBQUERIES
SELECT count( * ) FROM workers
  WHERE salary >
    ( SELECT avg( salary ) FROM workers );

SELECT *
  FROM workers
  WHERE skills->'languages'->>'en' = 'C2';

SELECT *
  FROM workers
  WHERE skills->'languages' ? (
      SELECT language
        FROM units
        WHERE title ~ 'police'
);

SELECT *
  FROM workers
  WHERE skills->'languages' ?| array[(
      SELECT language
        FROM units
        WHERE title ~ 'police'
)];


SELECT *
  FROM workers
  WHERE salary IN ( -- WHERE salary NOT IN (
   ( SELECT max( salary ) FROM workers ),
   ( SELECT min( salary ) FROM workers )
  )
  ORDER BY salary;


SELECT u.title,
	( SELECT count( * )
			FROM workers w
			WHERE w.unit_id = u.id
  			AND skills->'languages' ? 'en'
	) AS uk_speaking,
	( SELECT count( * )
			FROM workers w
			WHERE w.unit_id = u.id
  			AND skills->'languages' ? 'uk'
	) AS uk_speaking,
	( SELECT count( * )
			FROM workers w
			WHERE w.unit_id = u.id
  			AND skills->'languages' ? 'es'
	) AS es_speaking
  FROM units u
	ORDER BY u.title;
--  title  | uk_speaking | uk_speaking | es_speaking
-- --------+-------------+-------------+-------------
--  ODA    |           2 |           2 |           0
--  police |           0 |           0 |           0


SELECT s2.title,
  string_agg(
     s2.eng_level || ': (' || s2.count || ')',
', ' ) AS eng_levels
  FROM (
    SELECT u.title,
          w.skills->'languages'->>'en' AS eng_level,
          count (*)
      FROM workers w
      RIGHT OUTER JOIN units u ON w.unit_id = u.id
      GROUP BY 1, 2
      ORDER BY 1, 2
  ) AS s2
  GROUP BY s2.title
  ORDER BY s2.title;
--  title  |    eng_levels
-- --------+------------------
--  ODA    | A2: (1), C2: (1)
--  police |
-- (2 rows)


------------------------------------------------------------------------------------------------------------------
SELECT w.name,
       count(*)
  FROM time_spents
  JOIN workers w
    ON w.id = time_spents.worker_id
  GROUP BY w.name
  HAVING count(*) > 1;

SELECT worker_id,
       count(*)
  FROM time_spents
  GROUP BY worker_id
  HAVING count(*) > 1;

SELECT w.name, tm.task_goal_id, tm.spent_hours
  FROM (
    SELECT worker_id
    FROM time_spents
    GROUP BY worker_id
    HAVING count(*) > 1
  ) AS grouped_tm
  JOIN workers w
    ON w.id = grouped_tm.worker_id
  JOIN time_spents tm
    ON w.id = tm.worker_id;
-- CTE (Common Table Expressions) - THE SAME AS ABOVE
WITH grouped_tm AS (
  SELECT worker_id
    FROM time_spents
    GROUP BY worker_id
    HAVING count(*) > 1
)
SELECT w.name, tm.task_goal_id, tm.spent_hours
  FROM grouped_tm
  JOIN workers w
    ON w.id = grouped_tm.worker_id
  JOIN time_spents tm
    ON w.id = tm.worker_id;


SELECT tm.worker_id, tm.task_goal_id, tm.spent_hours
  FROM time_spents tm
  WHERE tm.worker_id IN (
    SELECT worker_id
      FROM time_spents
      GROUP BY worker_id
      HAVING count(*) > 1
  );
------------------------------------------------------------------------------------------------------------------

-- WITH...AS(...).
WITH RECURSIVE ranges ( min_salary, max_salary ) AS
  ( VALUES ( 0, 9999 )
    UNION ALL
    SELECT min_salary + 10000, max_salary + 10000
      FROM ranges
      WHERE max_salary <
       ( SELECT max( salary ) FROM workers )
  )
SELECT * FROM ranges;

WITH RECURSIVE ranges ( min_salary, max_salary ) AS
  ( VALUES ( 0, 9999 )
    UNION ALL
    SELECT min_salary + 10000, max_salary + 10000
      FROM ranges
      WHERE max_salary <
       ( SELECT max( salary ) FROM workers )
  )
SELECT ranges.min_salary, ranges.max_salary, count( w.* )
  FROM workers w
  RIGHT OUTER JOIN ranges
    ON w.salary >= ranges.min_salary AND w.salary < ranges.max_salary
  GROUP BY ranges.min_salary, ranges.max_salary
  ORDER BY ranges.min_salary;
