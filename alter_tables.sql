ALTER TABLE working_places
  ADD COLUMN chairs integer NOT NULL CHECK( chairs <= 2 );

ALTER TABLE working_places ADD COLUMN chairs integer;
ALTER TABLE working_places ALTER COLUMN chairs SET NOT NULL;
ALTER TABLE working_places ADD CHECK( chairs <= 2 );

ALTER TABLE working_places ALTER COLUMN chairs DROP NOT NULL;
ALTER TABLE working_places DROP CONSTRAINT working_places_chairs_check;
ALTER TABLE working_places DROP COLUMN chairs;


ALTER TABLE task_goals
  ADD COLUMN cost float NOT NULL DEFAULT 0;

ALTER TABLE task_goals
  ALTER COLUMN cost SET DATA TYPE numeric( 5,2 );

ALTER TABLE working_places DROP CONSTRAINT "unique_place";
ALTER TABLE working_places ADD CONSTRAINT unique_place UNIQUE (floor, room, place_number);
ALTER TABLE working_places ADD UNIQUE (floor, room, place_number); -- generates working_places_floor_room_place_number_key

ALTER TABLE workers
  RENAME CONSTRAINT workers_second_working_place_id_fkey
  TO second_working_place_id_for_workers_fkey;

ALTER TABLE workers ADD CHECK ( trim(name) <> '' );

ALTER TABLE working_places ADD COLUMN serial_num integer;
ALTER TABLE working_places ADD COLUMN serial_num text USING serial_num::text;

ALTER TABLE working_places_equipments RENAME TO equipments_of_working_places;

ALTER TABLE workers ADD COLUMN skills jsonb;
ALTER TABLE workers ADD COLUMN salary integer;

ALTER TABLE units ADD COLUMN language VARCHAR ( 50 );
