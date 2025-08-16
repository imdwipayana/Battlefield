DROP TABLE IF EXISTS menu_items;
CREATE TABLE menu_items (
menu_item_id INTEGER,
item_name VARCHAR(100),
category VARCHAR(50),
price FLOAT
);

DROP TABLE IF EXISTS restaurant_db_data_dictionary;
CREATE TABLE restaurant_db_data_dictionary (
table_detail VARCHAR(50),
field VARCHAR(100),
description VARCHAR(250)
);

DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
order_details_id INTEGER,
order_id INTEGER,
order_date DATE,
order_time TIME,
item_id INTEGER 
)
--================================================================================================
-- Calling the restaurant_db_data_dictionary table
--================================================================================================
SELECT 
	*
FROM restaurant_db_data_dictionary
--================================================================================================
-- Calling the menu_items table
--================================================================================================
SELECT 
	*
FROM menu_items
--================================================================================================
-- Calling the order_details table
--================================================================================================
SELECT 
	*
FROM order_details

--================================================================================================
-- Calling the order_details table
--================================================================================================


