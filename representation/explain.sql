EXPLAIN SELECT * FROM workers;
EXPLAIN ( COSTS OFF ) SELECT * FROM workers;
EXPLAIN SELECT * FROM workers WHERE name ~ 'Petr';
EXPLAIN SELECT * FROM workers ORDER BY name;
EXPLAIN ANALYZE SELECT * FROM workers ORDER BY name;