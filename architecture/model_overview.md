# Model Overview

## Layers

### Seeds
Raw input data is generated with Python and stored as CSV files in the `seeds/` folder:
- `raw_customers.csv`
- `raw_products.csv`
- `raw_orders.csv`

### Staging
The staging layer standardizes raw data types, applies light transformations, and introduces reusable business logic through dbt macros.

Models:
- `stg_customers`
- `stg_products`
- `stg_orders`

### Marts
The marts layer implements a star schema:
- `fct_orders` as the central fact table
- `dim_customers`
- `dim_products`
- `dim_dates`

### Analytics
The analytics layer provides KPI-ready models for reporting:
- `kpi_daily_sales`
- `kpi_customer_overview`
- `kpi_product_performance`

## Design Principles
- modular dbt layering
- reusable macros for common business logic
- data quality testing with dbt
- GitHub-first project structure for long-term visibility