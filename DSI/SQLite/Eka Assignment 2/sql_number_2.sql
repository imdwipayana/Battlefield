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









