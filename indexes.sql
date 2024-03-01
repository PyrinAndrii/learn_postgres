CREATE INDEX
  ON workers ( salary );

DROP INDEX workers_salary_idx;

\timing on
\timing off
\di
\di+

CREATE INDEX
  ON workers ( salary NULLS FIRST, ... );

CREATE INDEX
  ON workers ( salary DESC NULLS LAST, ... );

CREATE UNIQUE INDEX
  ON workers ( name );

CREATE INDEX
  ON workers ( name )
  WHERE total_amount > 15000;
