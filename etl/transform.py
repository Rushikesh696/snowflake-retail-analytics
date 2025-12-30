import pandas as pd
from extract import load_amazon, load_international, load_products

def clean_columns(df):
    """Standardize column names."""
    df.columns = (
        df.columns.str.strip()
                  .str.lower()
                  .str.replace(" ", "_")
                  .str.replace("-", "_")
    )
    return df

def transform_amazon():
    df = load_amazon()
    df = clean_columns(df)

    # Standard columns for unification
    df = df.rename(columns={
        "order_id": "order_id",
        "date": "order_date",
        "qty": "quantity",
        "amount": "amount",
        "sku": "sku"
    })

    return df

def transform_international():
    df = load_international()
    df = clean_columns(df)

    df = df.rename(columns={
        "date": "order_date",
        "pcs": "quantity",
        "gross_amt": "amount",
        "sku": "sku"
    })

    return df

def transform_products():
    df = load_products()
    df = clean_columns(df)

    df = df.rename(columns={
        "sku_code": "sku",
        "design_no.": "design_no"
    })

    return df

if __name__ == "__main__":
    print("Amazon:", transform_amazon().head())
    print("International:", transform_international().head())
    print("Products:", transform_products().head())
