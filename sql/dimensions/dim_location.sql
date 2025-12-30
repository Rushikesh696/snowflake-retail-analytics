CREATE OR REPLACE TABLE ETL_DB.MART.dim_location AS
WITH distinct_locations AS (
    SELECT DISTINCT
        ship_city,
        ship_state,
        ship_country,
        ship_postal_code
    FROM ETL_DB.TRANSFORMED.amazon_sales_clean
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY ship_country, ship_state, ship_city, ship_postal_code
    ) AS location_key,
    ship_city,
    ship_state,
    ship_country,
    ship_postal_code
FROM distinct_locations;
