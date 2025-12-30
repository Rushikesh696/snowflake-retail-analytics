-- Which states contribute most to revenue?

-- State-wise sales contribution
SELECT
    f.SHIP_STATE,
    SUM(f.total_quantity) AS total_units_sold,
    SUM(f.total_amount)   AS total_revenue
FROM ETL_DB.MART.fact_orders f
GROUP BY f.SHIP_STATE
ORDER BY total_revenue DESC;
