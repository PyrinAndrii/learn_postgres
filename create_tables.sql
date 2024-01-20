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

CREATE TABLE units (
	id serial PRIMARY KEY,
	title VARCHAR ( 50 ) NOT NULL
);

CREATE TABLE working_places (
	id serial PRIMARY KEY,
  floor INT NOT NULL,
	room INT NOT NULL,
	place_number INT NOT NULL
);

CREATE TABLE working_places_equipments (
	id serial PRIMARY KEY,
	working_place_id INT NOT NULL,
	desk boolean DEFAULT FALSE NOT NULL,
	chair boolean DEFAULT FALSE NOT NULL,
	stationery_items boolean DEFAULT FALSE NOT NULL,
	FOREIGN KEY ( working_place_id )
		REFERENCES working_places (id )
		ON DELETE CASCADE
);

CREATE TABLE workers (
	id serial PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL,
	unit_id INT NOT NULL,
	working_place_id INT NOT NULL,
	second_working_place_id INT NOT NULL,
	FOREIGN KEY ( unit_id )
    REFERENCES units (id )
    ON DELETE CASCADE,
	FOREIGN KEY ( working_place_id )
    REFERENCES working_places (id ),
	FOREIGN KEY ( second_working_place_id )
    REFERENCES working_places (id )
);
