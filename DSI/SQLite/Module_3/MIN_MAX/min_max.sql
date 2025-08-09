-- MIN & max

-- what is the most expensive product 

SELECT
p.product_name,
MAX(original_price) AS most_expensive
FROM product AS p
INNER JOIN vendor_inventory AS vi
ON p.product_id = vi.product_id;

-- prove it
SELECT DISTINCT
product_name,
original_price
FROM product AS p
INNER JOIN vendor_inventory as vi
ON p.product_id = vi.product_id
ORDER BY original_price DESC;

-- minimum price per each product_qty_type
SELECT
product_name,
product_qty_type,
MIN(original_price) AS least_expensive

FROM product AS p
INNER JOIN vendor_inventory as vi
ON p.product_id = vi.product_id
GROUP BY product_qty_type
ORDER BY product_qty_type ASC, original_price ASC;

--prove it
SELECT DISTINCT
product_name,
product_qty_type,
original_price

FROM product AS p
INNER JOIN vendor_inventory AS vi
ON p.product_id = vi.product_id
ORDER BY product_qty_type, original_price
















































