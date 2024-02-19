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
	id serial,
  floor INT NOT NULL,
	room INT NOT NULL CHECK ( room > 0 ),
	place_number INT NOT NULL,
	PRIMARY KEY ( id ),
	-- CONSTRAINTS
	CONSTRAINT valid_floor CHECK ( floor >= 0 AND floor <= 501 ),
	CONSTRAINT unique_place UNIQUE ( floor, room, place_number )
);

CREATE TABLE working_places_equipments (
	id serial PRIMARY KEY,
	working_place_id INT NOT NULL,
	-- working_place_id INT NOT NULL REFERENCES working_places ( id ), -- alternative
	-- working_place_id INT NOT NULL REFERENCES working_places, -- alternative
	desk boolean DEFAULT FALSE NOT NULL,
	chair boolean DEFAULT FALSE NOT NULL,
	stationery_items boolean DEFAULT FALSE NOT NULL,
	FOREIGN KEY ( working_place_id )
		REFERENCES working_places ( id )
		-- ON DELETE NO ACTION -- default
		-- ON DELETE SET NULL -- alternative
		-- ON DELETE SET DEFAULT -- alternative, if default value is set
		-- ON UPDATE CASCADE -- alternative
		ON DELETE CASCADE
);

CREATE TABLE workers (
	id serial PRIMARY KEY,
	name VARCHAR ( 50 ) NOT NULL,
	unit_id INT NOT NULL,
	working_place_id INT,
	second_working_place_id INT NOT NULL,
	FOREIGN KEY ( unit_id )
    REFERENCES units (id )
    ON DELETE CASCADE,
	FOREIGN KEY ( working_place_id )
    REFERENCES working_places (id ),
	FOREIGN KEY ( second_working_place_id )
    REFERENCES working_places (id )
);

CREATE TABLE time_spents (
	id serial PRIMARY KEY,
	worker_id INT NOT NULL,
	task_goal_id INT NOT NULL,
	spent_hours INT NOT NULL,
	date DATE,
	FOREIGN KEY ( worker_id )
		REFERENCES workers (id )
		ON DELETE CASCADE,
	FOREIGN KEY ( task_goal_id )
		REFERENCES task_goals (id )
		ON DELETE CASCADE
);
