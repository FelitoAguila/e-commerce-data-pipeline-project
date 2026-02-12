-- This query will return a table with two columns; State, and 
-- Delivery_Difference. The first one will have the letters that identify the 
-- states, and the second one the average difference between the estimate 
-- delivery date and the date when the items were actually delivered to the 
-- customer.

SELECT  C.customer_state AS State,
	ROUND(AVG(JULIANDAY(O.order_estimated_delivery_date)- ROUND (JULIANDAY(O.order_delivered_customer_date)))) AS Delivery_Difference
FROM
    olist_orders AS O
INNER JOIN
    olist_customers AS C
        ON O.customer_id = C.customer_id 
WHERE order_status = 'delivered' AND order_delivered_customer_date IS NOT NULL
GROUP BY C.customer_state
ORDER BY Delivery_Difference;
