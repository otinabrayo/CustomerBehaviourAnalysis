/*
2. SEGMENTATION
*/

-- Grouping Customers by spending habits

SELECT *
FROM RetailCustomerData;

-- Top 10 Customers in Spending

SELECT TOP 10
    Customer_ID,
    COUNT(*) AS Purchase_Count, 
    STRING_AGG(Products, ', ') AS Purchased_Products,
	SUM(Total_Amount) TotalSpent
FROM RetailCustomerData
GROUP BY Customer_ID
ORDER BY Purchase_Count DESC;

SELECT *
FROM RetailCustomerData
WHERE Customer_ID = '21673';

-- Temporary Table showing Customer category according to their Total spend

DROP TABLE IF EXISTS #Temp_Customers
CREATE TABLE #Temp_Customers(
Customer_ID int, 
Total_Spend_in_$ int, 
Members_Category varchar(50));

INSERT INTO  #Temp_Customers
	SELECT Customer_ID, SUM(Total_Amount) as Total_Spend_in_$,
	CASE 
		WHEN SUM(Total_Amount) > 15000 THEN 'Premium Member' 
		WHEN SUM(Total_Amount) > 12000 THEN 'VVIP Member'
		WHEN SUM(Total_Amount) > 1000 THEN 'VIP Member' 
		ELSE 'Regular Member'
	END Members_Category
	FROM RetailCustomerData
	GROUP BY Customer_ID;

-- Customer Categories

SELECT *
FROM  #Temp_Customers
ORDER BY Total_Spend_in_$ DESC;

-- Number of customers in each Category

SELECT DISTINCT(Members_Category), COUNT(Members_Category) Total_Members
FROM  #Temp_Customers
GROUP BY Members_Category
ORDER BY Total_Members;

-- Discount Application to Members
-- Premium 6% , VVIP 4$, VIP 3.5%, Regular 0.5% of their total spent

SELECT *,
CASE
	WHEN Members_Category LIKE 'Premium Member' THEN Total_Spend_in_$ * 0.94
	WHEN Members_Category LIKE 'VVIP Member' THEN Total_Spend_in_$ * 0.96
	WHEN Members_Category LIKE 'Premium_Member' THEN Total_Spend_in_$ * 0.965
	ELSE Total_Spend_in_$ * 0.995
END Amount_After_Discount
FROM  #Temp_Customers
ORDER BY Total_Spend_in_$ DESC;

SELECT SUM(Total_Spend_in_$)
FROM #Temp_Customers


SELECT 
Customer_ID, 
Total_Amount, 
Country,
Year,
Month
FROM RetailCustomerData
WHERE Year LIKE 2023
ORDER BY Total_Amount DESC;
         


		 -- NUMBER OF SALES IN EACH YEAR

-- YEAR 2023

-- Individual Temporary Monthly sales table from highest to lowest month sales

DROP TABLE IF EXISTS #Temp_Financial2023
CREATE TABLE #Temp_Financial2023 (
	Month varchar(50), 
	NumberOfSalesIn_2023 int, 
	FinancialYear varchar(50),
	Total_Amount int
	);

INSERT INTO #Temp_Financial2023
	SELECT
	DISTINCT(Month), 
	COUNT(Month) NumberOfSalesIn_2023,
	CASE 
		WHEN Month IN ('January', 'February', 'March', 'April') THEN 'First Quater'
		WHEN Month IN ('May', 'June', 'July', 'August') THEN 'Second Quater'
		ELSE 'Last Quarter'
	END FinancialYear,
	SUM(Total_Amount)
	FROM RetailCustomerData
	WHERE Year LIKE 2023
	GROUP BY Month;

SELECT *
FROM #Temp_Financial2023
ORDER BY NumberOfSalesIn_2023 DESC;

-- ANALYZATION Table with the Monthly sales above 

WITH CTE_FinancialYear as (
	SELECT
	DISTINCT(Month), 
	COUNT(Month) NumberOfSalesIn_2023,
	CASE 
		WHEN Month IN ('January', 'February', 'March', 'April') THEN 'First Quater'
		WHEN Month IN ('May', 'June', 'July', 'August') THEN 'Second Quater'
		ELSE 'Last Quarter'
	END FinancialYear,
	SUM(Total_Amount) Total_Amount_OfSalesIn_$
	FROM RetailCustomerData
	WHERE Year LIKE 2023
	GROUP BY Month
)
SELECT 
DISTINCT(FinancialYear),
SUM(NumberOfSalesIn_2023) NumOfSalesIn2023,
SUM(Total_Amount_OfSalesIn_$) Total_Amount_OfSalesIn_$
FROM CTE_FinancialYear
GROUP BY FinancialYear;


/*
With the result In 2023 highest number of products(51119) were purchased in the 
Second Quarter (41.5% ) of the FY calender sales, where August had the highest number(14902) of product Sales in the Qaurter.
This reflects positively since Highest amount of sales  was achieved in the year 69,903,810 Dollars.

I also notice First Quarter received the least number of product sales(35422) which 
covers (28.7% ) of the FY sales, Which is a total of 48,610,203 Dollars in sales, where February received lowest number of product sales(137) recorded in the FY calender
and April receiveing the highest number(18448) of sales in the FY calender. 

*/



-- YEAR 2024

-- Individual Temporary Monthly sales table from highest to lowest sales

DROP TABLE IF EXISTS #Temp_Financial2024
CREATE TABLE #Temp_Financial2024 (
	Month varchar(50), 
	NumberOfSalesIn_2024 int, 
	FinancialYear varchar(50),
	Total_Amount int
	);

INSERT INTO #Temp_Financial2024
	SELECT
	DISTINCT(Month), 
	COUNT(Month) NumberOfSalesIn_2024,
	CASE 
		WHEN Month IN ('January', 'February', 'March', 'April') THEN 'First Quater'
		WHEN Month IN ('May', 'June', 'July', 'August') THEN 'Second Quater'
		ELSE 'Last Quarter'
	END FinancialYear,
	SUM(Total_Amount)
	FROM RetailCustomerData
	WHERE Year LIKE 2024
	GROUP BY Month;

SELECT *
FROM #Temp_Financial2024
ORDER BY NumberOfSalesIn_2024 DESC;


-- ANALYZATION  Table with the Monthly sales above 

WITH CTE_FinancialYear as (
	SELECT
	DISTINCT(Month), 
	COUNT(Month) NumberOfSalesIn_2024,
	CASE 
		WHEN Month IN ('January', 'February', 'March', 'April') THEN 'First Quater'
		WHEN Month IN ('May', 'June', 'July', 'August') THEN 'Second Quater'
		ELSE 'Last Quarter'
	END FinancialYear,
	SUM(Total_Amount) Total_Amount_OfSalesIn_$
	FROM RetailCustomerData
	WHERE Year LIKE 2024
	GROUP BY Month
)
SELECT 
DISTINCT(FinancialYear),
SUM(NumberOfSalesIn_2024) NumOfSalesIn2024,
SUM(Total_Amount_OfSalesIn_$) Total_Amount_OfSalesIn_$
FROM CTE_FinancialYear
GROUP BY FinancialYear;


/*
With the result In 2024 highest number of products(21432) were purchased in the 
First Quarter (87.6% ) of the FY sales, where January had the highest number of Sales.
This reflects relatively with the total amount of sales which was 29,274,024 Dollars

I  also notice Last Quarter received the least number of product sales(95) which 
covers (0.4% ) of the FY sales, where September received lowest number of products sales, 
With total amount of 122,845 Dollars in sales

Inotice the number of sales reflects positively to the total amount of money made
*/
