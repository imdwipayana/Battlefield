-- INNER JOIN

-- INNER JOIN without as alias

-- get product names alongside customer purchases --- only products that a customer has purchased
SELECT
	product_name, -- come from product TABLE
	vendor_id,
	market_date,
	customer_id,
	customer_purchases.product_id
FROM product
INNER JOIN customer_purchases
ON customer_purchases.product_id = product.product_id;


-- which vendor has sold products to a customer AND which product was it AND to whom was it sold.
SELECT DISTINCT 
cp.vendor_id,
c.customer_id,
c.customer_first_name,
c.customer_last_name,
cp.product_id
FROM customer_purchases AS cp
INNER JOIN customer AS c
ON c.customer_id = cp.customer_id


SELECT
*
FROM customer_purchases

SELECT
*
FROM customer
























