
CREATE OR REPLACE TABLE ETL_DB.MART.dim_date AS
WITH date_range AS (
    SELECT
        MIN(order_date) AS start_date,
        MAX(order_date) AS end_date
    FROM ETL_DB.MART.fact_orders
),
dates AS (
    SELECT
        DATEADD(
            DAY,
            ROW_NUMBER() OVER (ORDER BY seq4()) - 1,
            start_date
        ) AS full_date
    FROM date_range,
         TABLE(GENERATOR(ROWCOUNT => 5000))
)
SELECT
    ROW_NUMBER() OVER (ORDER BY full_date)       AS date_key,
    full_date,
    YEAR(full_date)                              AS year,
    QUARTER(full_date)                           AS quarter,
    MONTH(full_date)                             AS month,
    TO_VARCHAR(full_date, 'MMMM')                AS month_name,
    DAY(full_date)                               AS day,
    DAYOFWEEK(full_date)                         AS day_of_week,
    TO_VARCHAR(full_date, 'DY')                  AS day_name,
    WEEKOFYEAR(full_date)                        AS week_of_year,
    CASE
        WHEN DAYOFWEEK(full_date) IN (1, 7)
        THEN TRUE
        ELSE FALSE
    END                                          AS is_weekend
FROM dates
WHERE full_date <= (SELECT end_date FROM date_range);


UPDATE ETL_DB.MART.dim_date
SET is_weekend = CASE 
                    WHEN DAYOFWEEKISO(full_date) IN (6,7) THEN TRUE
                    ELSE FALSE
                 END;
