SELECT
ï»¿menu_item_id
FROM restaurant.menu_items

ALTER TABLE restaurant.menu_items
CHANGE ï»¿menu_item_id menu_item_id VARCHAR(100) NOT NULL;

SELECT 
*
FROM restaurant.menu_items
