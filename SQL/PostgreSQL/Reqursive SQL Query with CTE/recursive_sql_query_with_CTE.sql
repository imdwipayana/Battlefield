DROP TABLE IF EXISTS employee_hierarchy;
CREATE TABLE employee_hierarchy (
employee_id VARCHAR(10),
full_name VARCHAR(50),
manager_id VARCHAR(10)
);

INSERT INTO employee_hierarchy
VALUES 
('E001',  'Nadine Amizah',  NULL),
('E002',  'Blake Lively',  'E001'),
('E003',  'May June',      'E001'),
('E004',  'May Be',        'E001'),
('E005',  'Sun Love',      'E002'),
('E006',  'Moon Shine',    'E002'),
('E007',  'White Lake',    'E002'),
('E008',   NULL,            NULL),
('E009',  'Benny John',    'E003'),
('E0010',  'Dedy McDonald', 'E003'),
('E0011', 'Bob Marshall',  'E003'),
('E0012', 'Alize Well',    'E004'),
('E0013', 'Anny Angela',   'E004');

SELECT * FROM employee_hierarchy;
--===================================================================
-- List all managers with all of their subordinates. 
--===================================================================
-- First method:
SELECT
	*
FROM employee_hierarchy
WHERE employee_id = 'E001' OR manager_id = 'E001';

SELECT
	*
FROM employee_hierarchy
WHERE employee_id = 'E002' OR manager_id = 'E002';

SELECT
	*
FROM employee_hierarchy
WHERE employee_id = 'E003' OR manager_id = 'E003';

SELECT
	*
FROM employee_hierarchy
WHERE employee_id = 'E004' OR manager_id = 'E004';

-- Second method: using recursive CTE
WITH RECURSIVE REC_CTE_employee AS (
SELECT
	employee_id,
	full_name,
	manager_id
FROM employee_hierarchy
WHERE employee_id = 'E001'
UNION
SELECT
	eh.employee_id,
	eh.full_name,
	eh.manager_id
FROM employee_hierarchy AS eh
INNER JOIN REC_CTE_employee AS rce
ON eh.manager_id = rce.employee_id
)
SELECT *
FROM REC_CTE_employee;

-- For the employee with employee_id = E1002
WITH RECURSIVE REC_CTE_employee AS (
SELECT
	employee_id,
	full_name,
	manager_id
FROM employee_hierarchy
WHERE employee_id = 'E002'
UNION
SELECT
	eh.employee_id,
	eh.full_name,
	eh.manager_id
FROM employee_hierarchy AS eh
INNER JOIN REC_CTE_employee AS rce
ON eh.manager_id = rce.employee_id
)
SELECT *
FROM REC_CTE_employee;

--NOTE: with a lot of repetition, it is interesting to use SQL function here.

--===========================================================================
-- 2. 
--===========================================================================
WITH RECURSIVE REC_CTE_detect_null AS (
SELECT
	'E1001' AS order_id,
	1 AS n
UNION ALL
SELECT 
	concat('E100', n+1),
	n+1
FROM REC_CTE_detect_null
WHERE n < 13
)

SELECT 
	* 
FROM REC_CTE_detect_null as rcdn
LEFT JOIN employee_hierarchy as eh
ON rcdn.order_id = eh.employee_id
WHERE eh.full_name IS NULL;

SELECT
	*
FROM employee_hierarchy
WHERE full_name IS NULL


