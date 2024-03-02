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

