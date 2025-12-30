-- How are sales performing month-over-month?

-- Monthly sales trend
SELECT
    d.YEAR,
    d.MONTH,
    d.MONTH_NAME,
    SUM(f.total_quantity) AS total_units_sold,
    SUM(f.total_amount)   AS total_revenue,
    ROUND(
        SUM(f.total_amount) / NULLIF(SUM(f.total_quantity), 0),
        2
    ) AS avg_price_per_unit
FROM ETL_DB.MART.fact_orders f
JOIN ETL_DB.MART.dim_date d
  ON f.ORDER_DATE = d.FULL_DATE
GROUP BY d.YEAR, d.MONTH, d.MONTH_NAME
ORDER BY d.YEAR, d.MONTH;
