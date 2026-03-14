-- Find the Total Sales
SELECT SUM(sales_amount) as total_sales 
FROM gold.fact_sales;
GO
--Find how many items are sold
SELECT SUM(quantity) items_sold
FROM gold.fact_sales;
GO
--Find the average selling price
SELECT AVG(price) AS avg_sel_price
FROM gold.fact_sales;
GO
--Find the Total number of Orders
SELECT COUNT(order_number)  AS total_orders
FROM gold.fact_sales;
GO

SELECT COUNT(DISTINCT order_number)  AS non_repated_orders
FROM gold.fact_sales;
GO
--Find the total number of products
SELECT COUNT(product_key) AS total_product
FROM gold.dim_products;
GO

SELECT COUNT(DISTINCT product_key) AS non_repated_product
FROM gold.dim_products;
GO
--Find the total number of customers
SELECT COUNT(customer_key) AS total_customer
FROM gold.dim_customer
--Find the total number of customers that has placed an order
SELECT COUNT(customer_key) AS total_customer
FROM gold.dim_customer

-- generate a report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' , sum(quantity)  FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' , AVG(price)  FROM gold.fact_sales
UNION ALL 
SELECT  'Total Nr. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products',COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customer',COUNT(customer_key) FROM gold.dim_customer