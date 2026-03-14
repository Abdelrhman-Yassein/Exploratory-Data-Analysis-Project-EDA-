-- Exploare  All Objects in the databases

SELECT *
FROM INFORMATION_SCHEMA.TABLES


--Exploare All Columns in the database

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customer'