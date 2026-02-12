-- TODO: This query will return a table with the top 10 revenue categories in 
-- English, the number of orders and their total revenue. The first column will 
-- be Category, that will contain the top 10 revenue categories; the second one 
-- will be Num_order, with the total amount of orders of each category; and the 
-- last one will be Revenue, with the total revenue of each catgory.
-- HINT: All orders should have a delivered status and the Category and actual 
-- delivery date should be not null.

SELECT T.product_category_name_english as Category, 
		COUNT(DISTINCT P.order_id) AS Num_order,
		SUM(P.payment_value) AS Revenue
FROM product_category_name_translation AS T
	INNER JOIN olist_products AS OP
		ON T.product_category_name = OP.product_category_name
	INNER JOIN olist_order_items AS OI
		ON OP.product_id = OI.product_id
	INNER JOIN olist_order_payments AS P
		ON OI.order_id = P.order_id
	INNER JOIN olist_orders AS O
        ON P.order_id = O.order_id 
WHERE O.order_status = 'delivered' AND O.order_delivered_customer_date IS NOT NULL        
GROUP BY Category
ORDER BY Revenue DESC	
LIMIT 10;