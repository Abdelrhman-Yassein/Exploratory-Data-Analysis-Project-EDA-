-- Calculate the total sales per month
-- AND the running total of sales OVER time
SELECT  DATETRUNC(MONTH,order_date)                                         AS order_month
       ,SUM(sales_amount)                                                   AS monthly_sales
       ,SUM(SUM(sales_amount)) OVER (ORDER BY  DATETRUNC(MONTH,order_date)) AS running_total_sales
       ,AVG(AVG(price)) OVER (ORDER BY DATETRUNC(MONTH,order_date))         AS moving_average_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY  DATETRUNC(MONTH,order_date)