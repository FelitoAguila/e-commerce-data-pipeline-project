-- This query will return a table with two columns; order_status, and
-- Ammount. The first one will have the different order status classes and the
-- second one the total ammount of each.

SELECT O.order_status,  COUNT (O.order_status) AS Ammount
FROM olist_orders AS O
GROUP BY O.order_status
