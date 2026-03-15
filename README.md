# 📊 Exploratory Data Analysis (EDA) Project

A structured SQL-based Exploratory Data Analysis project built on top of a **Data Warehouse** (`DataWarehouseAnalytics`). The project explores customer behavior, product performance, and sales trends using a medallion architecture (Bronze → Silver → Gold layers).

---

## 🗂️ Project Structure

```
├── datasets/
│   └── csv-files/
│       ├── bronze.crm_cust_info.csv         # Raw CRM customer data
│       ├── bronze.crm_prd_info.csv          # Raw CRM product data
│       ├── bronze.crm_sales_details.csv     # Raw CRM sales transactions
│       ├── bronze.erp_cust_az12.csv         # Raw ERP customer demographics
│       ├── bronze.erp_loc_a101.csv          # Raw ERP customer locations
│       ├── bronze.erp_px_cat_g1v2.csv       # Raw ERP product categories
│       ├── silver.crm_cust_info.csv         # Cleaned & standardized customer data
│       ├── silver.crm_prd_info.csv          # Cleaned product data
│       ├── silver.crm_sales_details.csv     # Cleaned sales data
│       ├── gold.dim_customers.csv           # Customer dimension table
│       ├── gold.dim_products.csv            # Product dimension table
│       ├── gold.fact_sales.csv              # Sales fact table
│       ├── gold.report_customers.csv        # Customer analytics report
│       └── gold.report_products.csv         # Product analytics report
│
├── scripts/
│   ├── 00_init_database.sql                 # Database & schema setup
│   ├── database_exploration.sql             # Schema & metadata exploration
│   ├── date_exploration.sql                 # Date range & temporal analysis
│   ├── dimensions_exploration.sql           # Dimension analysis (customers, products)
│   ├── measures_exploration.sql             # Key business metrics
│   ├── Magnitude_analysis.sql               # Aggregated counts & revenue by segments
│   ├── ranking_analysis.sql                 # Top/bottom performers (products & customers)
│   ├── change_over_time.sql                 # Sales trends by year and month
│   ├── cumulative_analysis.sql              # Running totals & moving averages
│   ├── performancr_analysis.sql             # Year-over-year product performance
│   ├── data_segmentation.sql                # Product cost ranges & customer segments
│   ├── part_to_whol.sql                     # Category contribution to overall sales
│   ├── customer_report.sql                  # Customer metrics view (gold.report_customers)
│   └── product_report.sql                   # Product metrics view (gold.report_products)
│
└── docs/
    ├── Project Roadmap.pdf                  # Project planning document
    ├── Project Roadmap.png                  # Visual roadmap
    └── Project_Notes_Sketches.pdf           # Analysis sketches & notes
```

---

## 🏗️ Data Architecture

This project follows the **Medallion Architecture**:

| Layer | Description |
|-------|-------------|
| **Bronze** | Raw, unprocessed data ingested from CRM and ERP source systems |
| **Silver** | Cleaned, standardized, and enriched data ready for transformation |
| **Gold** | Business-ready dimension and fact tables modeled as a star schema |

### Gold Layer Schema (Star Schema)

```
gold.dim_customers     gold.dim_products
        \                   /
         \                 /
          gold.fact_sales
```

**`gold.dim_customers`** — customer_key, customer_id, customer_number, first_name, last_name, country, marital_status, gender, birthdate, create_date

**`gold.dim_products`** — product_key, product_id, product_number, product_name, category_id, category, subcategory, maintenance, cost, product_line, start_date

**`gold.fact_sales`** — order_number, product_key, customer_key, order_date, shipping_date, due_date, sales_amount, quantity, price

---

## 🔍 EDA Scripts Overview

### `00_init_database.sql`
Sets up the `DataWarehouseAnalytics` database and `gold` schema, creates all tables, and bulk-loads data from CSV files.

> ⚠️ **Warning:** Running this script drops and recreates the database. Ensure you have backups before executing.

### `database_exploration.sql`
Explores database metadata — lists all tables and inspects column definitions using `INFORMATION_SCHEMA`.

### `date_exploration.sql`
Analyzes temporal coverage of the data:
- First and last order dates
- Total sales timespan (in years)
- Youngest and oldest customers by birthdate

### `dimensions_exploration.sql`
Explores categorical dimensions:
- Unique countries where customers are located
- Full product hierarchy: category → subcategory → product name

### `measures_exploration.sql`
Computes core business KPIs in a unified summary report:
- Total Sales Revenue
- Total Quantity Sold
- Average Selling Price
- Total Number of Orders (distinct)
- Total Number of Products
- Total Number of Customers

### `Magnitude_analysis.sql`
Segment-level aggregations to understand distribution and scale:
- Customer counts by country and gender
- Product counts by category
- Average product cost per category
- Revenue by product category
- Revenue per customer
- Quantity sold by country

### `ranking_analysis.sql`
Identifies top and bottom performers:
- Top 5 revenue-generating products
- Bottom 5 worst-performing products
- Top 10 highest-value customers
- Bottom 3 customers by number of orders placed

### `change_over_time.sql`
Tracks sales trends across time dimensions:
- Yearly revenue, unique customer count, and total quantity sold
- Monthly aggregations across all years
- Combined year + month breakdown for granular trend analysis

### `cumulative_analysis.sql`
Computes progressive metrics using window functions:
- Monthly sales totals
- Running total of sales over time
- Moving average of product price month-over-month

### `performancr_analysis.sql`
Year-over-year product performance comparison using window functions:
- Current year sales vs. product's historical average
- Deviation from average (Above Avg / Below Avg / Avg)
- Prior year sales (via `LAG`) and year-over-year change

### `data_segmentation.sql`
Groups data into meaningful buckets for distribution analysis:
- Products segmented into cost ranges: Below 100, 100–500, 500–1000, Above 1000
- Customers classified into VIP, Regular, and New segments based on lifespan and total spending

### `part_to_whol.sql`
Analyzes each category's share of total revenue:
- Total sales per product category
- Overall sales (window function)
- Percentage contribution of each category to overall revenue

### `customer_report.sql`
Creates the `gold.report_customers` view — a consolidated customer analytics layer:
- Core fields: name, age, transaction details
- Age group segmentation (Under 20, 20–29, 30–39, 40–49, 50+)
- Customer segments: VIP, Regular, New
- KPIs: recency, average order value, average monthly spend

### `product_report.sql`
Creates the `gold.report_products` view — a consolidated product analytics layer:
- Core fields: name, category, subcategory, cost
- Product segments: High-Performer, Mid-Range, Low-Performer
- KPIs: recency in months, average order revenue, average monthly revenue

---

## 🚀 Getting Started

### Prerequisites
- **Microsoft SQL Server** (any recent edition)
- **SQL Server Management Studio (SSMS)** or compatible SQL client
- CSV datasets placed at the correct local path (update the `BULK INSERT` paths in `00_init_database.sql` to match your environment)

### Setup Instructions

1. **Clone or extract** the project to your local machine.

2. **Update file paths** in `00_init_database.sql`:
   ```sql
   -- Replace this path with your actual CSV location
   FROM 'C:\your\path\to\datasets\csv-files\gold.dim_customers.csv'
   ```

3. **Run the initialization script** to create the database, schema, and load data:
   ```sql
   -- Execute in SSMS
   00_init_database.sql
   ```

4. **Run EDA scripts** in any order to explore the data:
   ```
   database_exploration.sql
   date_exploration.sql
   dimensions_exploration.sql
   measures_exploration.sql
   Magnitude_analysis.sql
   ranking_analysis.sql
   ```

---

## 📈 Key Insights Enabled

| Analysis Type | Questions Answered |
|---|---|
| **Date Analysis** | How many years of sales data do we have? Who are the oldest/youngest customers? |
| **Dimension Analysis** | Which countries do customers come from? What is the full product catalog? |
| **Measures / KPIs** | What are total sales, orders, and average price? |
| **Magnitude Analysis** | Which categories and countries drive the most volume and revenue? |
| **Ranking Analysis** | Which products and customers are top/bottom performers? |
| **Change Over Time** | How do sales, customers, and quantity trend by year and month? |
| **Cumulative Analysis** | What is the running total of sales and the moving average price over time? |
| **Performance Analysis** | How does each product perform vs. its historical average and the prior year? |
| **Data Segmentation** | How are products distributed by cost? How are customers split across VIP/Regular/New? |
| **Part-to-Whole** | Which product categories contribute the most to overall revenue? |
| **Customer Report** | What are each customer's lifetime value, recency, and spending behavior? |
| **Product Report** | What are each product's revenue performance, recency, and monthly trends? |

---

## 🛠️ Tech Stack

- **Database:** Microsoft SQL Server
- **Query Language:** T-SQL
- **Data Format:** CSV (for bulk loading)
- **Architecture:** Medallion (Bronze / Silver / Gold)
- **Modeling:** Star Schema (Fact + Dimensions)
