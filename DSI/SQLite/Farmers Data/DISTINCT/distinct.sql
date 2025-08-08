DROP TABLE IF EXISTS chess_player;

CREATE TABLE chess_player(
player_id VARCHAR(10) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
time_check_in TIMESTAMP,
time_check_out TIMESTAMP,
winner_prize FLOAT
);

INSERT INTO chess_player
VALUES
('F101', 'Zhu',     'Jinner',       '2025-08-01 07:15:25', '2025-08-01 17:30:21', 100000),
('M201', 'Magnus',   NULL,          '2025-08-01 07:40:15', '2025-08-01 15:51:51', 90000),
('F102', 'Hou',     'Yivan',        '2025-08-01 07:28:11', '2025-08-01 16:23:29', 80000),
('M202', 'Wei',     'Yi',           '2025-08-01 07:25:05', '2025-08-01 18:43:13', NULL),
('M203', 'Fabiano', 'Caruana',      '2025-08-01 07:26:02', '2025-08-01 17:32:07', 70000),
('M204', 'Hikaru',   NULL,          '2025-08-01 07:21:21', '2025-08-01 18:29:31', 70000),
('M205', 'Susanto', 'Megaranto',    '2025-08-01 07:22:35', '2025-08-01 18:15:41', 50000),
('M206', 'Anish',   'Giri',         '2025-08-01 07:29:01', '2025-08-01 19:19:59', NULL),
('M207', 'Garry',   'Kasparov',     '2025-08-01 07:30:15', '2025-08-01 19:03:25', 70000),
('M208', NULL,      'Neponimiachi', '2025-08-01 07:32:25', '2025-08-01 17:49:27', 80000),
('F103', NULL,       NULL,          '2025-08-01 07:24:59', '2025-08-01 17:41:31', 50000);

SELECT * FROM chess_player;
--========================================================================
-- 1. Ignoring the NULL value. SORT the table based on the winning prize (DESC).
--========================================================================
SELECT
   *
FROM chess_player
ORDER BY winner_prize DESC;
-- The NULL position at the bottom.

--========================================================================
-- 2. Ignoring the NULL value. SORT the table based on the winning prize (ASC).
--========================================================================
SELECT
	*
FROM chess_player
ORDER BY winner_prize;
-- The NULL position is in the top table (is it means the NULL value is the smallest in SQLite?)

--========================================================================
-- 3. Sort table based on winner prize (ASC) but the NULL value must be in the last.
--========================================================================
WITH CTE_sorting AS (
SELECT
	*,
	MIN(winner_prize) OVER(),
	COALESCE(winner_prize, MAX(winner_prize+100) OVER()) AS no_null_winner_prize
FROM chess_player
)
SELECT
	player_id,
	first_name,
	last_name,
	time_check_in,
	time_check_out,
	winner_prize
FROM CTE_sorting
ORDER BY no_null_winner_prize;

--========================================================================
-- 4. We can solve the previous problem with this technique.
--========================================================================
-- First method: creat sorter as the flag for sorting
SELECT
	*,
	CASE
	   WHEN winner_prize is NULL THEN 200
	   ELSE 100
	END AS sorter
FROM chess_player
ORDER BY sorter, winner_prize;

-- Second method: put sorter directly to ORDER BY, so that its value will not appear in the table
SELECT
	*
FROM chess_player
ORDER BY (CASE
		     WHEN winner_prize is NULL THEN 200
		     ELSE 100
	      END) 
		  , winner_prize;