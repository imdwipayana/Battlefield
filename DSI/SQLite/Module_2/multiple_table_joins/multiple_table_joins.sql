-- multiple table joins

/* Which vendor has sold products to a customer
... and which product was it?
.. and to whom was it sold*/

SELECT DISTINCT
c.customer_first_name,
c.customer_last_name,
v.vendor_name,
p.product_name
FROM customer_purchases as cp
INNER JOIN customer as c
ON cp.customer_id = c.customer_id
INNER JOIN vendor as v
ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
ON p.product_id = cp.product_id;

/* what if we add the dates they were purchased? */
SELECT DISTINCT
cp.market_date,
c.customer_first_name,
c.customer_last_name,
v.vendor_name,
p.product_name

FROM customer_purchases as cp
INNER JOIN customer as c
ON cp.customer_id = c.customer_id
INNER JOIN vendor as v
ON v.vendor_id = cp.vendor_id
INNER JOIN product as p
ON p.product_id = cp.product_id;

