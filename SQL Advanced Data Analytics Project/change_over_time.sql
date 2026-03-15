---------------------- Sales Perfomance OVER Time-----------------------
--------------------Year------------------------
SELECT  YEAR(order_date)  AS order_year
       ,SUM(sales_amount) AS total_revenue
       ,COUNT(DISTINCT customer_key) total_customer
       ,SUM(quantity)     AS total_quantity
FROM gold.fact_sales f
WHERE order_date IS NOT NULL
GROUP BY  YEAR(order_date)
ORDER BY  YEAR(order_date) DESC; GO
-------------------Month----------------------------- 
SELECT  MONTH(order_date) AS order_month
       ,SUM(sales_amount) AS total_revenue
       ,COUNT(DISTINCT customer_key) total_customer
       ,SUM(quantity)     AS total_quantity
FROM gold.fact_sales f
WHERE order_date IS NOT NULL
GROUP BY  MONTH(order_date)
ORDER BY  MONTH(order_date) DESC; GO
-------------------Month For Specific Year----------------------------- 
SELECT  YEAR(order_date)  AS order_year
       ,MONTH(order_date) AS order_month
       ,SUM(sales_amount) AS total_revenue
       ,COUNT(DISTINCT customer_key) total_customer
       ,SUM(quantity)     AS total_quantity
FROM gold.fact_sales f
WHERE order_date IS NOT NULL
GROUP BY  YEAR(order_date)
         ,MONTH(order_date)
ORDER BY  YEAR(order_date)
         ,MONTH(order_date); GO