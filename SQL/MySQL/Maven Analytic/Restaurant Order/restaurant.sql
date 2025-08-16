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
	COUNT(DISTINCT order_id) as number_order
FROM order_details

#=============================================================
# 11. How many items were ordered within this date range?
#=============================================================
SELECT
	COUNT(DISTINCT item_id) AS number_item_ordered
FROM order_details

#=============================================================
# 12. Which orders had the most number of items?
#=============================================================
SELECT
	order_id,
    COUNT(item_id) as number_item
FROM order_details
GROUP BY order_id
ORDER BY COUNT(item_id) DESC
#=============================================================
# 13. How many orders had more than 12 items?
#=============================================================
WITH CTE_more_12 AS (
SELECT
	order_id,
    COUNT(item_id) as number_item
FROM order_details
GROUP BY order_id
HAVING  COUNT(item_id) > 12
ORDER BY COUNT(item_id) DESC
)
SELECT 
	COUNT(number_item) AS more_12
FROM CTE_more_12

#=============================================================
# 14. Combine the menu_items and order_details tables into a single table.
#=============================================================
SELECT
	*
FROM order_details AS od
LEFT JOIN menu_items as mi
ON od.item_id = mi.menu_item_id

#==============================================================================
# 15. What were the least and most ordered items? What categories were they in?
#==============================================================================
# The least ordered item:
WITH CTE_join_table AS (
SELECT
	*
FROM order_details AS od
LEFT JOIN menu_items as mi
ON od.item_id = mi.menu_item_id
)
SELECT
item_name,
category,
COUNT(order_id) AS number_ordered
FROM CTE_join_table
GROUP BY item_name, category
ORDER BY COUNT(order_id) DESC

#=============================================================
# 16. What were the top 5 orders that spent the most money?
#=============================================================
WITH CTE_join_table AS (
SELECT
	*
FROM order_details AS od
LEFT JOIN menu_items as mi
ON od.item_id = mi.menu_item_id
), CTE_spending AS (
SELECT DISTINCT
	order_id,
	ROUND(SUM(price) OVER(PARTITION BY order_id),2) as spending_each_order
FROM CTE_join_table
)
SELECT
*
FROM CTE_spending
ORDER BY spending_each_order DESC
LIMIT 5


#=============================================================
# 17. View the details of the highest spend order. What insights can you gather from the results?
#=============================================================
WITH CTE_join_table AS (
SELECT
	*
FROM order_details AS od
LEFT JOIN menu_items as mi
ON od.item_id = mi.menu_item_id
), CTE_spending AS (
SELECT DISTINCT
	order_id,
	ROUND(SUM(price) OVER(PARTITION BY order_id),2) as spending_each_order
FROM CTE_join_table
), CTE_highest_spending AS (
SELECT
	*
FROM CTE_spending 
ORDER BY spending_each_order DESC
LIMIT 5
)
SELECT
*
FROM CTE_highest_spending AS chs
LEFT JOIN CTE_join_table AS cjt
ON chs.order_id = cjt.order_id

#========================================================================================================
# 18. View the details of the top 5 highest spend orders. What inshights can you gather from the results?
#========================================================================================================
