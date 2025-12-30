import pandas as pd
import os

RAW_PATH = "../data_raw/"

def load_amazon():
    return pd.read_csv(os.path.join(RAW_PATH, "Amazon Sale Report.csv"))

def load_international():
    return pd.read_csv(os.path.join(RAW_PATH, "International sale Report.csv"))

def load_products():
    return pd.read_csv(os.path.join(RAW_PATH, "Sale Report.csv"))

if __name__ == "__main__":
    print("Amazon:", load_amazon().shape)
    print("International:", load_international().shape)
    print("Products:", load_products().shape)
