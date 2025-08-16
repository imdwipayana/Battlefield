#=============================================================
# Insert table using "Table Data Import Wizard", then
# change the column name using the following syntax:
#=============================================================
ALTER TABLE restaurant.menu_items
CHANGE ï»¿menu_item_id menu_item_id VARCHAR(100) NOT NULL;

#=============================================================
# Call all the tables
#=============================================================
SELECT 
	menu_item_id,
	item_name,
	category,
	price
FROM restaurant.menu_items;
#=============================================================
SELECT 
order_details_id,
order_id,
order_date,
order_time,
item_id
FROM restaurant.order_details;
#==============================================================
SELECT
	table_details,
	field,
	description_column
FROM restaurant.restaurant_db_data_dictionary

USE restaurant

#=============================================================
# 1. View the menu_items table
#=============================================================
SELECT
	*
FROM menu_items
#=============================================================
# 2. Find the number of items on the menu
#=============================================================
SELECT
	COUNT(DISTINCT menu_item_id)
FROM menu_items
#=============================================================
# 3. What are the least and most expensive items on the menu?
#=============================================================
# The most expensive menu first method
SELECT
*
FROM menu_items
WHERE price = (SELECT
	                MAX(price) AS most_expensive
               FROM menu_items)
# Second method:
SELECT
	*
FROM menu_items
ORDER BY price DESC
LIMIT 1

# The least pricy menu
SELECT
	*
FROM menu_items
WHERE price = (SELECT
			        MIN(price) AS least_price
			   FROM menu_items)

# Second method:
SELECT
	*
FROM menu_items
ORDER BY price 
LIMIT 1
#=============================================================
# 4. How many Italian dishes are on the menu?
#=============================================================
SELECT
	COUNT(*) AS number_italian
FROM menu_items
WHERE category = 'Italian'
#=============================================================
# 5. What are the least and most expensive Italian dishes on the menu?
#=============================================================
SELECT
	MAX(price) as max_italian,
    MIN(price) as min_italian
FROM menu_items
WHERE category = 'Italian'

# The most expensive Italian menu first method:
SELECT
	*
FROM menu_items
WHERE category = 'Italian' AND price = (SELECT
										     MAX(price) as max_italian
									    FROM menu_items
										WHERE category = 'Italian')
# Second method:
SELECT
	*
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1

# The cheapest Italian menu
SELECT
	*
FROM menu_items
WHERE category = 'Italian' AND price = (SELECT
							                 MIN(price) as cheapest_italian
										FROM menu_items
										WHERE category = 'Italian')
# Second method:
SELECT
	*
FROM menu_items
WHERE category = 'Italian'
ORDER BY price 
LIMIT 2
#=============================================================
# 6. How many dishes are in each category?
#=============================================================
SELECT
	category,
	COUNT(category) AS number_category
FROM menu_items
GROUP BY category
#=============================================================
# 7. What is the average dish price within each category?
#=============================================================
SELECT
	category,
	ROUND(AVG(price),2) AS average_price
FROM menu_items
GROUP BY category

#=============================================================
# 8. View the order_details table
#=============================================================
SELECT
	*
FROM order_details
#=============================================================
# 9. What is the date range of the tables?
#=============================================================
SELECT 
	MAX(order_date) AS latest_order
FROM order_details;

SELECT 
	MIN(order_date) AS earliest_order
FROM order_details;
#=============================================================
# 10. How many orders were made within this date range?
#=============================================================
SELECT
	COUNT(*) as number_order
FROM order_details
WHERE order_date BETWEEN '1/1/23' AND '1/2/23'
#=============================================================
# 11. How many items were ordered within this date range?
#=============================================================
SELECT
	COUNT(item_id) AS number_ordered
FROM order_details
WHERE order_date BETWEEN '1/1/23' AND '1/1/23'
#=============================================================
# 12. Which orders had the most number of items?
#=============================================================
SELECT
	order_id,
    COUNT(order_id) as number_item
FROM order_details
GROUP BY order_id
ORDER BY COUNT(order_id) DESC
#=============================================================
# 13. How many orders had more than 12 items?
#=============================================================
WITH CTE_more_12 AS (
SELECT
	order_id,
    COUNT(order_id) as number_item
FROM order_details
GROUP BY order_id
HAVING  COUNT(order_id) > 12
ORDER BY COUNT(order_id) DESC
)
SELECT 
	COUNT(number_item) AS more_12
FROM CTE_more_12



