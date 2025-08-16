DROP TABLE IF EXISTS sales_data;
CREATE TABLE sales_data (
sales_date DATE,
number_sales FLOAT
);

INSERT INTO sales_data
VALUES 
('2025-01-01',  61),
('2025-01-02',  72),
('2025-01-04',  84),
('2025-01-05',  95),
('2025-01-07',  77);


SELECT * FROM sales_data;
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
--------------------------------------------------------
SELECT
*
FROM employee_hierarchy
ORDER BY full_name
LIMIT 10

SELECT
*
FROM(
SELECT
*
FROM employee_hierarchy
LIMIT 10
)
ORDER BY full_name


