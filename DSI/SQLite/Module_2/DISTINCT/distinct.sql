-- DISTINCT

-- without DISTINCT 4221 rows of various cust_ids
SELECT COUNT(customer_id) FROM customer_purchases;

SELECT COUNT(*) FROM customer_purchases;

-- with DISTINCT 26 rows of various cust_ids
SELECT DISTINCT customer_id FROM customer_purchases;

SELECT COUNT(DISTINCT customer_id) FROM customer_purchases;

-- 150 days the market was open
SELECT
	market_day
FROM market_date_info;

SELECT
	COUNT(market_day)
FROM market_date_info;

-- market is only open wed and sat
SELECT 
	DISTINCT market_day
FROM market_date_info;

-- which vendor has sold products to a customer (3 rows)
SELECT 
	DISTINCT vendor_id
FROM customer_purchases

-- which vendor has sold product to a customer ... and which product was it? -- 8 ROWS
SELECT
	DISTINCT vendor_id,
	product_id
FROM customer_purchases;

/* which vendor has sold products to a customer
... and which product was it?
... AND to whom was it sold */ -- 200 ROWS */

SELECT
	DISTINCT vendor_id,
	customer_id,
	product_id
FROM customer_purchases
ORDER BY customer_id ASC, product_id DESC;

SELECT
	COUNT(*)
FROM(
SELECT
	DISTINCT vendor_id,
	customer_id,
	product_id
FROM customer_purchases
ORDER BY customer_id ASC, product_id DESC
);































































