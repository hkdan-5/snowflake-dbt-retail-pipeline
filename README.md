# Modern Data Stack Pipeline (Snowflake & dbt)

## Overview

This project demonstrates an end-to-end modern data stack pipeline built with Snowflake and dbt. It covers the full analytics engineering workflow, from raw data ingestion to transformation, dimensional modeling, and KPI generation.

The goal of this project is to simulate a real-world analytics use case while keeping the dataset lightweight and fully reproducible. All data, transformation logic, and documentation are version-controlled in GitHub to ensure long-term accessibility, even after cloud trial accounts expire.

---

## Tech Stack

* **Snowflake** – Cloud data warehouse
* **dbt (Core)** – Data transformation, testing, and documentation
* **SQL** – Data modeling and analytics logic
* **Python (Faker)** – Synthetic data generation
* **GitHub** – Version control and project transparency

---

## Architecture

The project follows a layered dbt architecture:

1. **Seeds (Raw Layer)**
   Synthetic CSV datasets representing customers, products, and orders.

2. **Staging Layer**
   Data cleaning, type casting, and standardization.

3. **Mart Layer (Star Schema)**

   * Dimension tables: customers, products, dates
   * Fact table: orders

4. **Analytics Layer (KPI Models)**
   Aggregated metrics for business reporting.

---

## Data Model

The dimensional model is based on a classic star schema:

* `dim_customers`
* `dim_products`
* `dim_dates`
* `fct_orders`

This structure supports key business questions such as:

* Revenue trends over time
* Customer lifetime value
* Product performance
* Order volume and average order value

---

## Key Features

### Modular dbt Models

All transformations are structured into staging, mart, and analytics layers using dbt best practices.

### Reusable Macros (Core Feature)

Custom dbt macros are used to:

* standardize calculations (e.g. revenue logic)
* reduce SQL duplication
* enforce consistent transformations across models

This demonstrates abstraction and maintainability beyond basic SQL.

### Data Quality Testing

Built-in dbt tests ensure:

* primary key uniqueness
* non-null constraints
* referential integrity

### Synthetic Data Generation

Data is generated using Python (Faker) to simulate realistic retail scenarios while keeping the dataset lightweight and flexible.

### Fully Reproducible

All components of the pipeline (data, SQL, configuration) are stored in the repository, making the project easy to review and reproduce.

---

## Example KPIs

* Total revenue by day
* Average order value
* Customer lifetime value
* Product revenue ranking
* Units sold per category

---

## Why This Project Matters

This project demonstrates core analytics engineering skills:

* Designing a scalable data model
* Building modular transformation pipelines
* Applying data quality checks
* Abstracting logic using macros
* Delivering business-ready analytics outputs

---

## Outcome

The result is a compact but realistic modern data stack implementation that reflects industry practices while remaining lightweight, transparent, and portfolio-ready.
