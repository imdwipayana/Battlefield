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

DROP TABLE IF EXISTS final_sales;
CREATE TABLE final_sales (
sales_date DATE,
number_sales FLOAT
);

INSERT INTO final_sales
VALUES 
('2025-01-01',  61),
('2025-01-02',  72),
('2025-01-03',  78),
('2025-01-04',  84),
('2025-01-05',  95),
('2025-01-06',  86),
('2025-01-07',  77);

--=====================================================================
-- 1. Call the sales_data table and look at the gap on date.
--=====================================================================
SELECT 
	* 
FROM sales_data;

--=====================================================================
-- 2. The final table of sales_data table must be like this:
--=====================================================================
SELECT 
	* 
FROM final_sales;

--=====================================================================
-- 3. Generate the series of dates (UNION, UNION ALL)
--=====================================================================
SELECT
	CAST('2025-01-01' AS DATE) AS sales_date
UNION
SELECT
	CAST('2025-01-02' AS DATE) AS sales_date
UNION
SELECT
	CAST('2025-01-03' AS DATE) AS sales_date

ORDER BY sales_date;

--=====================================================================
-- 4. Join with our original table [subquery, left join, inner join]
--=====================================================================
SELECT * FROM (
SELECT CAST('2025-01-01' AS DATE) AS sales_date
UNION ALL
SELECT CAST('2025-01-02' AS DATE) 
UNION ALL
SELECT CAST('2025-01-03' AS DATE) 
UNION ALL
SELECT CAST('2025-01-04' AS DATE) 
UNION ALL
SELECT CAST('2025-01-05' AS DATE)
UNION ALL
SELECT CAST('2025-01-06' AS DATE) 
UNION ALL
SELECT CAST('2025-01-07' AS DATE)
) AS sq

LEFT JOIN sales_data 
ON sales_data.sales_date = sq.sales_date

ORDER BY sq.sales_date;

--=====================================================================
-- 5. Rewrite subquery as a CTE
--=====================================================================
WITH CTE_date AS (
SELECT CAST('2025-01-01' AS DATE) AS sales_date
UNION ALL
SELECT CAST('2025-01-02' AS DATE) 
UNION ALL
SELECT CAST('2025-01-03' AS DATE) 
UNION ALL
SELECT CAST('2025-01-04' AS DATE) 
UNION ALL
SELECT CAST('2025-01-05' AS DATE)
UNION ALL
SELECT CAST('2025-01-06' AS DATE) 
UNION ALL
SELECT CAST('2025-01-07' AS DATE)
)

SELECT
	* 
FROM CTE_date AS cd
LEFT JOIN sales_data as sd
ON sd.sales_date = cd.sales_date

ORDER BY cd.sales_date;

--=====================================================================
-- 6. Rewrite CTE as a recursive CTE
--=====================================================================
WITH RECURSIVE CTE_date AS (
SELECT CAST('2025-01-01' AS DATE) AS sales_date
UNION ALL
SELECT sales_date + 1
FROM CTE_date
WHERE sales_date < CAST('2025-01-07' AS DATE)
)

SELECT
	* 
FROM CTE_date AS cd
LEFT JOIN sales_data as sd
ON sd.sales_date = cd.sales_date

ORDER BY cd.sales_date;

--=====================================================================
-- 7. Fill in the NULL values
--=====================================================================
WITH RECURSIVE CTE_date AS (
SELECT CAST('2025-01-01' AS DATE) AS sales_date
UNION ALL
SELECT sales_date + 1
FROM CTE_date
WHERE sales_date < CAST('2025-01-07' AS DATE)
), CTE_average AS (
SELECT
AVG(number_sales) AS average_sales
FROM sales_data
)

SELECT
	*,
	COALESCE(sd.number_sales,0) AS null_sales_0,
	COALESCE(sd.number_sales, (SELECT average_sales FROM CTE_average)) AS null_sales_avg
FROM CTE_date AS cd
LEFT JOIN sales_data as sd
ON sd.sales_date = cd.sales_date

ORDER BY cd.sales_date;

--=====================================================================
-- 8. Use Window Function to impute the NULL values
--=====================================================================
WITH CTE_recursive AS (
WITH RECURSIVE CTE_date AS (
SELECT CAST('2025-01-01' AS DATE) AS sales_date
UNION ALL
SELECT sales_date + 1
FROM CTE_date
WHERE sales_date < CAST('2025-01-07' AS DATE)
), CTE_average AS (
SELECT
AVG(number_sales) AS average_sales
FROM sales_data
)

SELECT
	cd.sales_date,
	sd.number_sales
FROM CTE_date AS cd
LEFT JOIN sales_data as sd
ON sd.sales_date = cd.sales_date

ORDER BY cd.sales_date
)
SELECT
	*,
	COALESCE(number_sales,AVG(number_sales) OVER(ORDER BY sales_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) AS average_sales_null
FROM CTE_recursive;

