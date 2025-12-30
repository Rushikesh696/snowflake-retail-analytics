import pandas as pd
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Connect
conn = snowflake.connector.connect(
    user=os.getenv('SNOWFLAKE_USER'),
    password=os.getenv('SNOWFLAKE_PASSWORD'),
    account=os.getenv('SNOWFLAKE_ACCOUNT'),
    warehouse=os.getenv('SNOWFLAKE_WAREHOUSE'),
    database=os.getenv('SNOWFLAKE_DATABASE'),
    schema=os.getenv('SNOWFLAKE_SCHEMA', 'PUBLIC')
)

cursor = conn.cursor()
cursor.execute("USE DATABASE ETL_DB")
cursor.execute("USE SCHEMA PUBLIC")

# Load CSVs
df_amazon = pd.read_csv('../data_raw/Amazon Sale Report.csv', low_memory=False)
df_int = pd.read_csv('../data_raw/International sale Report.csv')
df_sale = pd.read_csv('../data_raw/Sale Report.csv')

# Upload
write_pandas(conn, df_amazon, 'AMAZON_SALE_REPORT')
write_pandas(conn, df_int, 'INTERNATIONAL_SALE_REPORT')
write_pandas(conn, df_sale, 'SALE_REPORT')

print("Uploaded successfully!")
conn.close()

