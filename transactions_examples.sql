-- 1. Read Uncommitted
-- 2. Read Committed
-- 3. Repeatable Read
-- 4. Serializable

SHOW default_transaction_isolation; -- default: read committed


-- Read Uncommitted (eql Read Committed)
CREATE TABLE workers_tmp AS SELECT * FROM workers;

-- first terminal
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SHOW transaction_isolation;

UPDATE workers_tmp SET salary = salary + 100 WHERE name = 'Petro';
SELECT * FROM workers_tmp WHERE name = 'Petro';
--

-- second terminal
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT * FROM workers_tmp WHERE name = 'Petro';
ROLLBACK;
--

-- first terminal
ROLLBACK;
--

-----------------------------------------------------------------------------------------

-- Read Committed
-- first terminal
BEGIN ISOLATION LEVEL READ COMMITTED;
SHOW transaction_isolation;
UPDATE workers SET salary = salary + 111 WHERE name = 'Petro';
SELECT * FROM workers WHERE name = 'Petro';
--

-- second terminal
BEGIN; -- (default: read committed)
UPDATE workers SET salary = salary + 222 WHERE name = 'Petro';
SELECT * FROM workers WHERE name = 'Petro';
--

-- first terminal
COMMIT;
--

-- second terminal
END;
--
--------------------------------------------
-- first terminal
BEGIN;
SELECT * FROM workers;
--
-- second terminal
BEGIN;
DELETE FROM workers WHERE name ~ '^Myk';
SELECT * FROM workers;
END;
--
-- first terminal
SELECT * FROM workers;
--
-----------------------------------------------------------------------------------------
-- Repeatable Read
-- first terminal
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM workers;
--
-- second terminal
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
INSERT INTO workers (name, unit_id, working_place_id, second_working_place_id, skills, salary) values ('Ihor', 1, 3, 3, null, 27500);
UPDATE workers SET salary = salary + 222 WHERE name = 'Mykola';
SELECT * FROM workers WHERE;
END;
--
-- first terminal
SELECT * FROM workers WHERE; -- nothing has changed
END;
SELECT * FROM workers WHERE;
--
--------------------------------------------
-- first terminal
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
UPDATE workers SET salary = salary + 777 WHERE name = 'Ihor';
--
-- second terminal
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
UPDATE workers SET salary = salary + 778 WHERE name = 'Ihor';
--
-- first terminal
END;
--
-- second terminal
-- error!
END;
-- rollback!
--
-----------------------------------------------------------------------------------------

-- first terminal
BEGIN;
LOCK TABLE workers IN ACCESS EXCLUSIVE MODE;
--
-- second terminal
BEGIN;
SELECT * FROM workers WHERE salary > 11000;
--
-- first terminal
ROLLBACK
--
-- second terminal ...
-----------------------------------------------------------------------------------------

-- first terminal
BEGIN;
SELECT * FROM workers WHERE salary > 11000 FOR UPDATE;
--
-- second terminal
BEGIN;
SELECT * FROM workers WHERE salary > 11000 FOR UPDATE;
-- hang
--
-- first terminal
UPDATE workers SET salary = salary + 111 WHERE name = 'Ihor';
COMMIT;
--
-- second terminal
-- salary was updated!
