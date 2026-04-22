from pathlib import Path
import random
from datetime import datetime, timedelta

import pandas as pd
from faker import Faker


fake = Faker("de_DE")
random.seed(42)
Faker.seed(42)

# ---------------------------------------------------
# Paths
# ---------------------------------------------------
PROJECT_ROOT = Path(__file__).resolve().parent
SEEDS_DIR = PROJECT_ROOT / "seeds"
SEEDS_DIR.mkdir(exist_ok=True)

# ---------------------------------------------------
# Config
# ---------------------------------------------------
N_CUSTOMERS = 1000
N_PRODUCTS = 100
N_ORDERS = 5000

CATEGORIES = [
    "Electronics",
    "Accessories",
    "Home",
    "Office",
    "Stationery"
]

PRODUCT_PREFIXES = [
    "Smart", "Ultra", "Eco", "Pro", "Essential",
    "Advanced", "Compact", "Premium", "Flex", "Prime"
]

PRODUCT_TYPES = [
    "Mouse", "Keyboard", "Monitor", "Dock", "Headset",
    "Lamp", "Chair", "Notebook", "Webcam", "Stand",
    "Adapter", "Tablet", "Speaker", "Router", "Microphone"
]


# ---------------------------------------------------
# Helper functions
# ---------------------------------------------------
def random_signup_date():
    start_date = datetime(2023, 1, 1)
    end_date = datetime(2025, 3, 31)
    delta_days = (end_date - start_date).days
    return (start_date + timedelta(days=random.randint(0, delta_days))).date()


def random_order_date():
    start_date = datetime(2024, 1, 1)
    end_date = datetime(2025, 12, 31)
    delta_days = (end_date - start_date).days
    return (start_date + timedelta(days=random.randint(0, delta_days))).date()


def generate_product_name():
    return f"{random.choice(PRODUCT_PREFIXES)} {random.choice(PRODUCT_TYPES)}"


# ---------------------------------------------------
# Customers
# ---------------------------------------------------
customers = []
for customer_id in range(1, N_CUSTOMERS + 1):
    customers.append(
        {
            "customer_id": customer_id,
            "customer_name": fake.name(),
            "city": fake.city(),
            "country": "Germany",
            "signup_date": random_signup_date()
        }
    )

df_customers = pd.DataFrame(customers)

# ---------------------------------------------------
# Products
# ---------------------------------------------------
products = []
for product_id in range(101, 101 + N_PRODUCTS):
    base_price = round(random.uniform(9.99, 499.99), 2)
    products.append(
        {
            "product_id": product_id,
            "product_name": generate_product_name(),
            "category": random.choice(CATEGORIES),
            "price": base_price
        }
    )

df_products = pd.DataFrame(products)

# Ensure product_id uniqueness and a little cleanup
df_products = (
    df_products
    .drop_duplicates(subset=["product_id"])
    .reset_index(drop=True)
)

# ---------------------------------------------------
# Orders
# ---------------------------------------------------
product_price_lookup = dict(zip(df_products["product_id"], df_products["price"]))

orders = []
for order_id in range(100001, 100001 + N_ORDERS):
    product_id = random.choice(df_products["product_id"].tolist())
    quantity = random.randint(1, 5)

    orders.append(
        {
            "order_id": order_id,
            "order_date": random_order_date(),
            "customer_id": random.randint(1, N_CUSTOMERS),
            "product_id": product_id,
            "quantity": quantity,
            "unit_price": product_price_lookup[product_id]
        }
    )

df_orders = pd.DataFrame(orders)

# ---------------------------------------------------
# Save CSVs
# ---------------------------------------------------
customers_path = SEEDS_DIR / "raw_customers.csv"
products_path = SEEDS_DIR / "raw_products.csv"
orders_path = SEEDS_DIR / "raw_orders.csv"

df_customers.to_csv(customers_path, index=False)
df_products.to_csv(products_path, index=False)
df_orders.to_csv(orders_path, index=False)

print("Seed files created successfully:")
print(f"- {customers_path}")
print(f"- {products_path}")
print(f"- {orders_path}")
print()
print(f"Customers: {len(df_customers)}")
print(f"Products: {len(df_products)}")
print(f"Orders: {len(df_orders)}")