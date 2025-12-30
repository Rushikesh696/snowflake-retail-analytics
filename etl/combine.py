from transform import transform_amazon, transform_international
import pandas as pd
import os

OUTPUT_PATH = "../data_clean/"

def ensure_output_folder():
    if not os.path.exists(OUTPUT_PATH):
        os.makedirs(OUTPUT_PATH)

def create_unified_sales():
    amazon = transform_amazon()
    amazon["source"] = "amazon"

    international = transform_international()
    international["source"] = "international"

    # Columns we want to keep
    cols = ["order_id", "order_date", "quantity", "amount", "sku", "source"]

    # Add missing order_ids for international
    if "order_id" not in international.columns:
        international["order_id"] = None

    # Combine
    unified = pd.concat([
        amazon[cols],
        international[cols]
    ], ignore_index=True)

    return unified

if __name__ == "__main__":
    print("Combining datasets...")
    ensure_output_folder()

    df = create_unified_sales()
    df.to_csv(os.path.join(OUTPUT_PATH, "unified_sales.csv"), index=False)

    print("Saved cleaned file → data_clean/unified_sales.csv")
    print(df.head())
