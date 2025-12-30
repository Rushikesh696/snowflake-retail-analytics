CREATE OR REPLACE TABLE ETL_DB.MART.fact_order_lines AS
SELECT
    order_id,
    order_date,
    sku,
    category,
    size,
    style,
    SUM(quantity)      AS total_quantity,
    SUM(amount)        AS total_amount,
    MAX(order_status)  AS order_status,
    MAX(ship_city)     AS ship_city,
    MAX(ship_state)    AS ship_state,
    MAX(ship_country)  AS ship_country
FROM ETL_DB.TRANSFORMED.amazon_sales_clean
GROUP BY
    order_id,
    order_date,
    sku,
    category,
    size,
    style;
