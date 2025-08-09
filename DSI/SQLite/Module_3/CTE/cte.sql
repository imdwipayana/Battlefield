-- CTE

-- Calculate sales per vendor per day
WITH vendor_daily_sales AS (
SELECT
md.market_day,
md.market_day,
md.market_week,
md.market_year,
vendor_name,
SUM(quantity*cost_to_customer_per_qty) as sales
FROM customer_purchases AS cp
INNER JOIN market_date_info AS md -- get the market data
ON cp.market_date = md.market_date
INNER JOIN vendor AS v
ON v.vendor_id = cp.vendor_id

GROUP BY md.market_date, v.vendor_id
), -- if we want another CTE, add a comma, without WITH 
new_customer AS
(
SELECT * FROM customer
)

-- re-aggregate the daily sales
SELECT
market_year,
market_week,
vendor_name,
SUM(sales) as weekly_sales
FROM vendor_daily_sales
GROUP BY market_year, market_week, vendor_name