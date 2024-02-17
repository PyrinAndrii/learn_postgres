SELECT name, skills->'languages' AS languages FROM workers;
SELECT name, skills #>'{ languages, uk }' FROM workers;
