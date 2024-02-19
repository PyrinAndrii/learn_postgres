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
