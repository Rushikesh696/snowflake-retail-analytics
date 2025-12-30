CREATE OR REPLACE TABLE ETL_DB.MART.dim_product AS
WITH distinct_products AS (
    SELECT DISTINCT
        SKU,
        STYLE,
        CATEGORY,
        SIZE,
        ASIN
    FROM ETL_DB.TRANSFORMED.amazon_sales_clean
)
SELECT
    ROW_NUMBER() OVER (ORDER BY SKU, STYLE, SIZE, ASIN) AS product_key,
    SKU,
    STYLE,
    CATEGORY,
    SIZE,
    ASIN
FROM distinct_products;
