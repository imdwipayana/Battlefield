-- SELECT


-- select everything from the customer TABLE
SELECT 
*
FROM customer;

-- use sql as a calculator
SELECT 1+1, 10*4, pi(), 13/3


-- add a static value 
SELECT 2025 AS this_year, 'AUGUST' AS this_month, customer_id
FROM customer;

-- add an order by and LIMIT
SELECT *
FROM customer
ORDER BY customer_first_name
LIMIT 10;

-- select multiple columns
SELECT customer_id, customer_first_name
FROM customer;












