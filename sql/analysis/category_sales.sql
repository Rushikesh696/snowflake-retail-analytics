-- Which product categories generate the most revenue?

-- Category-wise sales performance
SELECT
    fol.CATEGORY,
    SUM(fol.total_quantity) AS total_units_sold,
    SUM(fol.total_amount)   AS total_revenue,
    ROUND(
        SUM(fol.total_amount) / NULLIF(SUM(fol.total_quantity), 0),
        2
    ) AS avg_price_per_unit
FROM ETL_DB.MART.fact_order_lines fol
GROUP BY fol.CATEGORY
ORDER BY total_revenue DESC;
