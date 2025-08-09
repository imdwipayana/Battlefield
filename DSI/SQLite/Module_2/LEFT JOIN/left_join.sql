--- LEFT JOIN

-- there are product that have been bought, but are there products that have not been bought?

SELECT DISTINCT
p.product_id,
cp.product_id AS [cp.product_id],
product_name
FROM product AS p
LEFT JOIN customer_purchases AS cp
ON p.product_id = cp.product_id
WHERE cp.product_id IS NULL -- only show product ids that have not been sold

-- direction matter
-- this shows ONLY products that have been sold...because there are no products id in cp that AREN'T in product
SELECT DISTINCT
p.product_id,
cp.product_id,
product_name

FROM customer_purchases AS cp
LEFT JOIN product as p
ON p.product_id = cp.product_id





















































