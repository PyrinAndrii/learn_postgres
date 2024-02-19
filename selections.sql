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
