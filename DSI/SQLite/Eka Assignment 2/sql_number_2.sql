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

WITH CTE_purchase AS (
	SELECT
		*,
		quantity * cost_to_customer_per_qty as purchase_each
	FROM customer_purchases
), CTE_daily_sales AS (
	SELECT DISTINCT
		market_date,
		SUM(purchase_each) OVER(PARTITION BY market_date) as daily_sales
	FROM CTE_purchase
), CTE_sales_minimum AS (
	SELECT
		*
	FROM CTE_daily_sales
	ORDER BY daily_sales 
	LIMIT 1
), CTE_sales_maximum AS (
	SELECT
		*
	FROM CTE_daily_sales
	ORDER BY daily_sales DESC
	LIMIT 1
)

SELECT
	*
FROM CTE_sales_minimum

UNION

SELECT
	*
FROM CTE_sales_maximum

--=======================================================================================================
-- COALESCE
/* 1. Our favourite manager wants a detailed long list of products, but is afraid of tables! 
We tell them, no problem! We can produce a list with all of the appropriate details. 

Using the following syntax you create our super cool and not at all needy manager a list:

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product

But wait! The product table has some bad data (a few NULL values). 
Find the NULLs and then using COALESCE, replace the NULL with a 
blank for the first problem, and 'unit' for the second problem. 

HINT: keep the syntax the same, but edited the correct components with the string. 
The `||` values concatenate the columns into strings. 
Edit the appropriate columns -- you're making two edits -- and the NULL rows will be fixed. 
All the other rows will remain the same.) */

SELECT 
product_name || ', ' || product_size|| ' (' || product_qty_type || ')'
FROM product

WITH CTE_no_null AS (
SELECT
*,
COALESCE(product_size,'') as product_size_nonull,
COALESCE(product_qty_type,'unit') as product_qty_type_nonull
FROM product
)
SELECT 
product_name || ', ' || product_size_nonull|| ' (' || product_qty_type_nonull || ')'
FROM CTE_no_null


--=========================================================================================================\
/* SECTION 3 */

-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to 
**every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */
SELECT DISTINCT
COUNT(vendor_id)
FROM vendor

SELECT DISTINCT
COUNT(product_id)
FROM product

SELECT DISTINCT
COUNT(customer_id)
FROM customer

SELECT
*
FROM vendor_inventory

SELECT
*
FROM vendor_inventory as vi
LEFT JOIN vendor as v
ON v.vendor_id = vi.vendor_id
LEFT JOIN product as p
ON p.product_id = vi.product_id

--=============================
SELECT
vendor_name,
product_name
FROM vendor_inventory as vi
LEFT JOIN vendor as v
ON v.vendor_id = vi.vendor_id
LEFT JOIN product as p
ON p.product_id = vi.product_id















