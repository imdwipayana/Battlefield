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
# The most expensive menu
SELECT
*
FROM menu_items
WHERE price = (SELECT
	                MAX(price) AS most_expensive
               FROM menu_items)

# The least pricy menu
SELECT
	*
FROM menu_items
WHERE price = (SELECT
			        MIN(price) AS least_price
			   FROM menu_items)
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

# The most expensive Italian menu
SELECT
	*
FROM menu_items
WHERE category = 'Italian' AND price = (SELECT
										     MAX(price) as max_italian
									    FROM menu_items
										WHERE category = 'Italian')

# The cheapest Italian menu
SELECT
	*
FROM menu_items
WHERE category = 'Italian' AND price = (SELECT
							                 MIN(price) as cheapest_italian
										FROM menu_items
										WHERE category = 'Italian')

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

