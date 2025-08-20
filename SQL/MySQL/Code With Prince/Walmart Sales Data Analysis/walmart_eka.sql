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
# Create category for when the sales happened. Divide into morning, afternoon and evening. 
# Then create column to represent the day and month the sales happened.
#==================================================================================================




