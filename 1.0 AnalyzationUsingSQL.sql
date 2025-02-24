/*
1. ANALYSIS
*/


SELECT *
FROM RetailCustomerData;

SELECT Date
FROM RetailCustomerData;

-- Date format change

UPDATE RetailCustomerData
SET Date = CONVERT(Date, Date, 103)

-- Checking Duplicated Data

SELECT
    Customer_ID, 
    COUNT(*) AS Purchase_Count, 
    STRING_AGG(Products, ', ') AS Purchased_Products
FROM RetailCustomerData
GROUP BY Customer_ID
HAVING COUNT(*) > 1
ORDER BY Purchase_Count DESC;

--- Calculating Total Sales (201,885,841)

SELECT SUM(FLOOR(Total_Amount)) TotalSales
FROM RetailCustomerData;

-- Average spend per Customer

SELECT  
COUNT(Customer_ID) No_Of_Times_Shopped, 
Total_Amount,
Total_Amount/COUNT(Customer_ID) AS AvgSpend_Customer
FROM RetailCustomerData
GROUP BY Total_Amount;

-- Purchase Frequency by Product_Category

SELECT Product_Category ,
COUNT(Product_Category) TotalSalesPeProductrCategory, 
SUM(Total_Purchases) TotalSalesPeProductrCategory
FROM RetailCustomerData
GROUP BY Product_Category;

-- proofing using clothing
select COUNT(Total_Purchases), SUM(Total_Purchases)
from RetailCustomerData
where Product_Category LIKE 'Clothing';

--SELECT Product_Category, 
--       COUNT(Product_Category) AS Total_Purchases,
--       SUM(CASE 
--              WHEN Product_Category IN ('Clothing', 'Home Decor', 'Electronics', 'Grocery', 'Books') 
--              THEN Total_Purchases 
--              ELSE 0 
--           END) AS TotalSalesPeProductrCategory
--FROM RetailCustomerData
--GROUP BY Product_Category;



