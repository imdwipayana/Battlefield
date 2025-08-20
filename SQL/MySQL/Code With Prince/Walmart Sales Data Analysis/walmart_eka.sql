CREATE DATABASE IF NOT EXISTS salesDataWalmart;

CREATE TABLE IF NOT EXISTS sales (
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
)
/*
Then import data from csv file.
*/

SELECT
*
FROM sales

#==================================================================================================
# Create category for when the sales happened. Divide into morning, afternoon and evening. 
# Then create column to represent the day and month the sales happened.
#==================================================================================================
SELECT
	*,
	CASE
		WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'morning'
		WHEN time BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
		ELSE 'evening' 
	END as day_category,
	DAYNAME(date) as day_sales,
	MONTHNAME(date) as month_sales
FROM sales

#==================================================================================================
# How many unique city the sales has?
#==================================================================================================
SELECT
	COUNT(DISTINCT city)
FROM sales

#==================================================================================================
# What city is every brach located?
#==================================================================================================
SELECT DISTINCT
    branch,
    city
FROM sales

#==================================================================================================
# What is the most commont payment method?
#==================================================================================================
SELECT 
	payment,
	COUNT(payment) as number_payment_method
FROM sales
GROUP BY payment
ORDER BY number_payment_method DESC
LIMIT 1

#==================================================================================================
# What is the most product line sold?
#==================================================================================================
SELECT
	product_line,
    SUM(quantity) as number_sold
FROM sales
GROUP BY product_line
ORDER BY number_sold
LIMIT 1

#==================================================================================================
# What is the total revenue by month?
#==================================================================================================
WITH CTE_month_sales AS (
SELECT
	*,
	MONTHNAME(date) as month_sales
FROM sales
)
SELECT
	month_sales,
    SUM(total) as total_revenue
FROM CTE_month_sales
GROUP BY month_sales

#==================================================================================================
# What month had the highest COGS?
#==================================================================================================
WITH CTE_monthly_sales AS (
SELECT
*,
MONTHNAME(date) as monthly_sales
FROM sales
)
SELECT
	monthly_sales,
	SUM(cogs) as monthly_cogs
FROM CTE_monthly_sales
GROUP BY monthly_sales
ORDER BY monthly_cogs DESC
LIMIT 1

#==================================================================================================
# What product line had the largest revenue?
#==================================================================================================
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 1

#==================================================================================================
# What city has the largest revenue?
#==================================================================================================
SELECT
	city,
    SUM(total) as total_revenue
FROM sales
GROUP by city
ORDER BY total_revenue DESC
LIMIT 1

#==================================================================================================
# What product line had the highest VAT?
#==================================================================================================
SELECT
	product_line,
    SUM(tax_pct) as total_vat
FROM sales
GROUP BY product_line
ORDER BY total_vat DESC
LIMIT 1

#==========================================================================================================================
# Categorize product line into good and bad sales. Good sales where its average sales is greater than the average of sales.
#==========================================================================================================================
WITH CTE_average_compare AS (
SELECT DISTINCT
	product_line,
	AVG(total) OVER(PARTITION BY product_line) as average_sales_product,
    AVG(total) OVER() as average_total
FROM sales
)
SELECT
	*,
    CASE
		WHEN average_sales_product > average_total THEN 'good'
        ELSE 'bad'
	END AS sales_category
FROM CTE_average_compare

#==========================================================================================================================
# Which branch sold product more than the average product sold?
#==========================================================================================================================
WITH CTE_branch_category As (
SELECT DISTINCT
	branch,
	AVG(total) OVER() AS total_average,
	AVG(total) OVER(PARTITION BY branch) as branch_average
FROM sales
)
SELECT
	*
FROM CTE_branch_category
WHERE branch_average > total_average

#==========================================================================================================================
# What is the most common product line by gender?
#==========================================================================================================================











