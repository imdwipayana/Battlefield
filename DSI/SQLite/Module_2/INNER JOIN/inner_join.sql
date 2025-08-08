-- INNER JOIN

-- INNER JOIN without as alias

- get product names alongside customer purchases --- only products that a customer has purchased
SELECT
	product_name, -- come from product TABLE
	vendor_id,
	market_date,
	customer_id,
	customer_purchases.product_id
FROM product
INNER JOIN customer_purchases
ON customer_purchases.product_id = product.product_id;