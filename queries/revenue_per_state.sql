-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 

SELECT  C.customer_state,
        ROUND(SUM(P.payment_value), 2) AS Revenue 	
FROM
    olist_customers AS C
    INNER JOIN olist_orders AS O
    	ON C.customer_id = O.customer_id
	INNER JOIN olist_order_payments AS P
        ON O.order_id = P.order_id 
WHERE O.order_status = 'delivered' AND O.order_delivered_customer_date IS NOT NULL
GROUP BY C.customer_state
ORDER BY Revenue DESC
LIMIT 10;