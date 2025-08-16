DROP TABLE IF EXISTS menu_items;
CREATE TABLE menu_items (
menu_item_id VARCHAR(25),
item_name VARCHAR(100),
category VARCHAR(50),
price FLOAT
);

DROP TABLE IF EXISTS restaurant_db_data_dictionary;
CREATE TABLE restaurant_db_data_dictionary (
Table VARCHAR(50),
Field VARCHAR(100),
Description VARCHAR(250)
);

DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
order_details_id VARCHAR(10),
order_id VARCHAR(10),
order_date DATE,
order_time TIME,
item_id VARCHAR(10)
)
