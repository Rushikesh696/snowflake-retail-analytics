CREATE OR REPLACE TABLE ETL_DB.MART.fact_orders AS
SELECT
    order_id,
    MIN(order_date)        AS order_date,
    SUM(quantity)          AS total_quantity,
    SUM(amount)            AS total_amount,
    MAX(order_status)      AS order_status,
    MAX(ship_city)         AS ship_city,
    MAX(ship_state)        AS ship_state,
    MAX(ship_country)      AS ship_country,
    MAX(fulfilled_by)      AS fulfilled_by,
    MAX(b2b)               AS b2b
FROM ETL_DB.TRANSFORMED.amazon_sales_clean
GROUP BY order_id;
