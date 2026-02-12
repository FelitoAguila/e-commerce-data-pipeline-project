-- TODO: This query will return a table with the differences between the real 
-- and estimated delivery times by month and year. It will have different 
-- columns: month_no, with the month numbers going from 01 to 12; month, with 
-- the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with 
-- the average delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_real_time, with the average delivery time per month of 2017 (NaN if 
-- it doesn't exist); Year2018_real_time, with the average delivery time per 
-- month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the 
-- average estimated delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_estimated_time, with the average estimated delivery time per month 
-- of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the 
-- average estimated delivery time per month of 2018 (NaN if it doesn't exist).
-- HINTS
-- 1. You can use the julianday function to convert a date to a number.
-- 2. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
-- 3. Take distinct order_id.

SELECT 
    month_col AS month_no,
    CASE
        WHEN A.month_col = '01' THEN 'Jan'
        WHEN A.month_col = '02' THEN 'Feb'
        WHEN A.month_col = '03' THEN 'Mar'
        WHEN A.month_col = '04' THEN 'Apr'
        WHEN A.month_col = '05' THEN 'May'
        WHEN A.month_col = '06' THEN 'Jun'
        WHEN A.month_col = '07' THEN 'Jul'
        WHEN A.month_col = '08' THEN 'Aug'
        WHEN A.month_col = '09' THEN 'Sep'
        WHEN A.month_col = '10' THEN 'Oct'
        WHEN A.month_col = '11' THEN 'Nov'
        WHEN A.month_col = '12' THEN 'Dec'
        ELSE 0
    END 
        AS month,
    AVG(CASE WHEN A.year = '2016' THEN real_time END) AS Year2016_real_time,
    AVG(CASE WHEN A.year = '2017' THEN real_time END) AS Year2017_real_time,
    AVG(CASE WHEN A.year = '2018' THEN real_time END) AS Year2018_real_time,
    AVG(CASE WHEN A.year = '2016' THEN est_time END) AS Year2016_estimated_time,
    AVG(CASE WHEN A.year = '2017' THEN est_time END) AS Year2017_estimated_time,
    AVG(CASE WHEN A.year = '2018' THEN est_time END) AS Year2018_estimated_time
FROM (
    SELECT 
        DISTINCT order_id, 
        strftime('%Y', order_purchase_timestamp) AS year,
        strftime('%m', order_purchase_timestamp) AS month_col,
        JULIANDAY (order_delivered_customer_date) - JULIANDAY (order_purchase_timestamp) AS real_time,
        JULIANDAY (order_estimated_delivery_date) - JULIANDAY (order_purchase_timestamp) AS est_time,
        order_status
    FROM olist_orders
    WHERE order_status = "delivered" AND order_delivered_customer_date IS NOT NULL
    ) AS A
GROUP BY month
ORDER BY month_no ASC;