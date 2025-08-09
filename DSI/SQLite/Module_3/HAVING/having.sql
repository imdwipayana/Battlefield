-- count
-- count the number of products

SELECT COUNT(product_id) AS num_of_product
FROM product;

-- how many products per product_qty_type
SELECT 
product_qty_type,
COUNT(product_id) AS num_of_products
FROM product
GROUP BY product_qty_type

-- how many products per product_qty_type and per their product_size

SELECT
product_size,
product_qty_type,
COUNT(product_id) AS num_of_products
FROM product
GROUP BY product_size, product_qty_type;


-- count DISTINCT
-- how many unique products were bought

SELECT COUNT(DISTINCT product_id) as bought_product
FROM customer_purchases










