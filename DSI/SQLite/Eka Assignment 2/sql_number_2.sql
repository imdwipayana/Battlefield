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


