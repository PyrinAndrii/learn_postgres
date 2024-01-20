CREATE TABLE tasks (
	id serial PRIMARY KEY,
	title VARCHAR ( 50 ) NOT NULL
);

CREATE TABLE task_goals (
	id serial PRIMARY KEY,
	title VARCHAR ( 50 ) NOT NULL,
  task_id INT NOT NULL,
	FOREIGN KEY ( task_id )
    REFERENCES tasks (id )
    ON DELETE CASCADE
);
