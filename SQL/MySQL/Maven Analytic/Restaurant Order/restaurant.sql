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




