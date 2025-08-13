SELECT 
*
FROM customer_purchases
WHERE customer_id =1
ORDER BY market_date

SELECT 
market_date,
customer_id,
COUNT(*) OVER(PARTITION BY customer_id ORDER BY market_date) as [customer_id]
FROM customer_purchases
----===========================================
-- THis is the answer
--=============================================
WITH CTE_visit_number AS(
	SELECT 
		customer_id,
		market_date,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY market_date) as visit_number
	FROM customer_purchases
)

SELECT 
	DISTINCT visit_number,
	customer_id,
	market_date
FROM CTE_visit_number
---===================================================
WITH CTE_visit_number AS(
	SELECT 
		customer_id,
		market_date,
		DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY market_date DESC) as visit_number
	FROM customer_purchases
), CTE_distinct_visit AS(

SELECT 
	DISTINCT visit_number,
	customer_id,
	market_date 
FROM CTE_visit_number
)

SELECT
customer_id,
market_date AS recent_visit
FROM CTE_distinct_visit
WHERE visit_number = 1

---===============================================

SELECT 
*
FROM customer_purchases
WHERE customer_id =1
ORDER BY market_date

SELECT
COUNT(product_id)
FROM customer_purchases
WHERE customer_id = 1 AND product_id = 5

--=======================================
WITH  CTE_product AS (
	SELECT
		customer_id,
		product_id,
		COUNT() OVER(PARTITION BY customer_id, product_id) as product_bought_number
	FROM customer_purchases
), CTE_distinct AS (
   SELECT DISTINCT product_bought_number,
        customer_id,
        product_id
   FROM CTE_product
)
SELECT
	customer_id,
	product_id,
	product_bought_number
FROM CTE_distinct
--===========================================

-- UNION
/* 1. Using a UNION, write a query that displays the market dates with the highest and lowest total sales.

HINT: There are a possibly a few ways to do this query, but if you're struggling, try the following: 
1) Create a CTE/Temp Table to find sales values grouped dates; 
2) Create another CTE/Temp table with a rank windowed function on the previous query to create 
"best day" and "worst day"; 
3) Query the second temp table twice, once for the best day, once for the worst day, 
with a UNION binding them. */











