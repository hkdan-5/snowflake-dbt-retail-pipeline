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

## How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/snowflake-dbt-retail-pipeline.git
cd snowflake-dbt-retail-pipeline
```

### 2. Create virtual environment

```bash
python -m venv .venv
source .venv/bin/activate  # Mac/Linux
# or
.\.venv\Scripts\Activate.ps1  # Windows
```

### 3. Install dependencies

```bash
pip install dbt-core dbt-snowflake pandas faker
```

### 4. Generate synthetic data

```bash
python generate_data.py
```

### 5. Configure dbt profile

Update your `profiles.yml` with your Snowflake credentials.

### 6. Run dbt pipeline

```bash
dbt debug
dbt seed
dbt run
dbt test
```

### 7. Generate documentation

```bash
dbt docs generate
dbt docs serve
```

---

## Architecture

The project follows a layered dbt architecture:

1. **Seeds (Raw Layer)**
   Synthetic CSV datasets representing customers, products, and orders.

2. **Staging Layer**
   Data cleaning, type casting, and standardization.

3. **Mart Layer (Star Schema)**
   The project uses a star schema with `fct_orders` as the central fact table and `dim_customers`, `dim_products`, and `dim_dates` as surrounding dimensions.
   The fact table stores foreign keys and additive business measures, while descriptive attributes are modeled separately in dimensions to support scalable analytics and BI reporting.

4. **Analytics Layer (KPI Models)**
   Aggregated metrics for business reporting.

---

## Data Flow

The pipeline follows a clear transformation flow:

1. **Seed Layer**
   Raw CSV files are loaded into Snowflake using `dbt seed`.

2. **Staging Layer**
   Data is cleaned, standardized, and enriched with reusable macros.

3. **Mart Layer**
   A star schema is implemented with a central fact table (`fct_orders`) and surrounding dimensions.

4. **Analytics Layer**
   KPI models aggregate business metrics for reporting and analysis.

All transformations are modular and connected through dbt's `ref()` function.

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

## dbt Features Used

* `ref()` for dependency management and model lineage
* `dbt seed` for raw data ingestion
* `dbt run` for transformations
* `dbt test` for data quality validation
* `dbt docs` for automatic documentation generation
* Custom macros for reusable business logic

---

## Key Features

### Modular dbt Models

All transformations are structured into staging, mart, and analytics layers using dbt best practices.

### Reusable Macros (Core Feature)

Custom dbt macros are used to:

* Standardize calculations (e.g. revenue logic)
* Reduce SQL duplication
* Enforce consistent transformations across models

This demonstrates abstraction and maintainability beyond basic SQL.

### Data Quality Testing

Built-in dbt tests ensure:

* Primary key uniqueness
* Non-null constraints
* Referential integrity

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

## Documentation & Lineage

dbt automatically generates documentation and lineage graphs.

Example outputs are stored in:

* `docs_exports/screenshot_dbt_docs.png`
* `docs_exports/sample_query_results.csv`

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
