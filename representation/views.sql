SELECT task_id, title, count( * ), SUM(cost) AS total_cost FROM task_goals GROUP BY task_id, title ORDER BY count DESC, total_cost DESC;

CREATE OR REPLACE VIEW similar_task_goals
  AS
    SELECT task_id,
          title,
          count( * ) AS task_goals_count,
          SUM(cost) AS total_cost
      FROM task_goals
      GROUP BY task_id, title
      ORDER BY task_goals_count DESC, total_cost DESC;


SELECT * FROM similar_task_goals;
DROP VIEW IF EXISTS similar_task_goals;


CREATE MATERIALIZED VIEW materialized_similar_task_goals
  AS
    SELECT task_id,
          title,
          count( * ) AS task_goals_count,
          SUM(cost) AS total_cost
      FROM task_goals
      GROUP BY task_id, title
      ORDER BY task_goals_count DESC, total_cost DESC; -- WITH NO DATA;

REFRESH MATERIALIZED VIEW materialized_similar_task_goals;
DROP MATERIALIZED VIEW materialized_similar_task_goals;


CREATE VIEW oda_workers AS
  SELECT workers.id, name
  FROM workers
  INNER JOIN units
    ON workers.unit_id = units.id
    WHERE units.title = 'ODA';

SELECT * from oda_workers;
