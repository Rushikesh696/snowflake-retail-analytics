# Snowflake Retail Analytics

A comprehensive ETL pipeline and data warehouse solution for analyzing retail sales data from multiple sources (Amazon and International sales) using Snowflake, Python, and DBT.

## Project Overview

This project implements a complete data analytics solution that:
- Extracts sales data from multiple CSV sources
- Transforms and cleanses the data using Python
- Loads data into Snowflake data warehouse
- Creates a star schema for analytics
- Provides analytical SQL queries for business insights

## Architecture

### Data Pipeline
```
Raw Data (CSV) → Python ETL → Snowflake (Raw) → DBT Transformations → Star Schema → Analytics
```

### Star Schema Design
- **Fact Tables**
  - `fact_orders` - Aggregated order-level sales data
  - `fact_order_lines` - Granular order line items

- **Dimension Tables**
  - `dim_date` - Date dimension with calendar attributes
  - `dim_product` - Product information (SKU, style, category, size)
  - `dim_location` - Shipping location details

## Project Structure

```
snowflake-retail-analytics/
├── data_raw/                    # Raw CSV files (not committed to Git)
│   ├── Amazon Sale Report.csv
│   ├── International sale Report.csv
│   └── Sale Report.csv
├── data_clean/                  # Cleaned/transformed data (not committed to Git)
│   └── unified_sales.csv
├── etl/                        # Python ETL scripts
│   ├── extract.py              # Data extraction functions
│   ├── transform.py            # Data transformation logic
│   ├── combine.py              # Data unification
│   ├── load_csv_to_snowflake.py # Snowflake data loader
│   └── etl_project/            # DBT project
│       ├── models/
│       ├── analyses/
│       └── dbt_project.yml
├── sql/                        # Snowflake SQL scripts
│   ├── dimensions/             # Dimension table creation
│   │   ├── dim_date.sql
│   │   ├── dim_product.sql
│   │   └── dim_location.sql
│   ├── mart/                   # Fact table creation
│   │   ├── fact_orders.sql
│   │   └── fact_order_lines.sql
│   └── analysis/               # Analytical queries
│       ├── monthly_sales.sql
│       ├── category_sales.sql
│       └── state_sales.sql
├── diagram/                    # Architecture diagrams
│   └── star_schema.png
├── .gitignore
├── .env.example
├── requirements.txt            # Python dependencies
└── README.md
```

## Prerequisites

- Python 3.8+
- Snowflake account
- Required Python packages:
  - pandas
  - snowflake-connector-python
  - python-dotenv

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd snowflake-retail-analytics
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Configure Snowflake Credentials
Create a `.env` file from the example:
```bash
cp .env.example .env
```

Edit `.env` and add your Snowflake credentials:
```env
SNOWFLAKE_USER=your_username
SNOWFLAKE_PASSWORD=your_password
SNOWFLAKE_ACCOUNT=your_account_identifier
SNOWFLAKE_WAREHOUSE=your_warehouse
SNOWFLAKE_DATABASE=ETL_DB
SNOWFLAKE_SCHEMA=PUBLIC
```

### 4. Prepare Data
Place your raw CSV files in the `data_raw/` directory:
- Amazon Sale Report.csv
- International sale Report.csv
- Sale Report.csv

## Usage

### Step 1: Extract and Transform Data
Run the Python ETL scripts to clean and unify the data:

```bash
# Extract data
cd etl
python extract.py

# Transform data
python transform.py

# Combine datasets
python combine.py
```

This will create `unified_sales.csv` in the `data_clean/` directory.

### Step 2: Load Data to Snowflake
Load the raw CSV files into Snowflake:

```bash
python load_csv_to_snowflake.py
```

This creates the following tables in Snowflake:
- `AMAZON_SALE_REPORT`
- `INTERNATIONAL_SALE_REPORT`
- `SALE_REPORT`

### Step 3: Create Star Schema
Execute the SQL scripts in Snowflake to build the data warehouse:

```sql
-- Create dimension tables
@sql/dimensions/dim_date.sql
@sql/dimensions/dim_product.sql
@sql/dimensions/dim_location.sql

-- Create fact tables
@sql/mart/fact_orders.sql
@sql/mart/fact_order_lines.sql
```

### Step 4: Run Analytics
Execute analytical queries to derive insights:

```sql
-- Monthly sales trends
@sql/analysis/monthly_sales.sql

-- Category performance
@sql/analysis/category_sales.sql

-- State-wise sales
@sql/analysis/state_sales.sql
```

## Key Features

- **Data Unification**: Combines multiple sales sources into a unified format
- **Data Quality**: Standardizes column names, handles missing values
- **Scalable Architecture**: Star schema design for efficient querying
- **Security**: Environment variable-based credential management
- **Modular Design**: Separate extraction, transformation, and loading logic

## Analytics Capabilities

The data warehouse enables analysis across multiple dimensions:
- **Temporal**: Daily, weekly, monthly, quarterly trends
- **Geographic**: City, state, country-level analysis
- **Product**: Category, style, size performance
- **Channel**: Fulfillment method, B2B vs B2C

## DBT Integration

The project includes a DBT project structure for:
- Data transformations
- Testing and validation
- Documentation
- Dependency management

## Security Notes

- **NEVER** commit the `.env` file to version control
- **NEVER** hardcode credentials in Python or SQL files
- Use environment variables for all sensitive configuration
- The `.gitignore` file excludes sensitive files by default

## Contributing

1. Ensure all credentials are stored in `.env`
2. Run data quality checks before committing
3. Document any new transformations or analytics
4. Update this README with any architectural changes

## License

This project is for educational and analytical purposes.

## Contact

For questions or issues, please open an issue in the repository.
