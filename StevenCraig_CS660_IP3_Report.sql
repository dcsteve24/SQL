-- =============================================
-- DELETE/UPDATE Database Script
-- Steven Craig 20Oct19
-- For school project CTU CS660 IP3
-- MICROSOFT SQL SERVER
-- =============================================

-- Swtich to Database --
USE GoodExcuse

-- Total revenue (sales) per month, grouped by customer
SELECT MONTH(o.DateofPurchase) AS Order_Month, c.FirstName, c.MiddleName, c.LastName, SUM(o.TotalPrice) AS Total_Revenue
FROM tblOrders o, tblCustomers c
WHERE o.CustomerID = c.CustomerID
GROUP BY c.FirstName, c.MiddleName, c.LastName, MONTH(o.DateofPurchase)
ORDER BY Order_Month

-- Total revenue (sales) per month, grouped by product
SELECT MONTH(o.DateofPurchase) AS Order_Month, p.Manufacturer, p.MakeModel, SUM(o.TotalPrice) AS Total_Revenue
FROM tblOrders o, tblProducts p
WHERE o.Barcode = p.Barcode
GROUP BY p.Manufacturer, p.MakeModel, MONTH(o.DateofPurchase)
ORDER BY Order_Month

-- Total count of products, grouped by category
SELECT Category, QtyTotal
FROM tblProducts
GROUP BY Category, QtyTotal
ORDER BY Category

-- Total revenue (sales) per month, grouped by year (crosstab)
SELECT YEAR(DateofPurchase) AS 'YEAR',
	SUM(CASE MONTH(DateofPurchase) WHEN 1 THEN TotalPrice ELSE 0 END) AS JAN,
	SUM(CASE MONTH(DateofPurchase) WHEN 2 THEN TotalPrice ELSE 0 END) AS FEB,
	SUM(CASE MONTH(DateofPurchase) WHEN 3 THEN TotalPrice ELSE 0 END) AS MAR,
	SUM(CASE MONTH(DateofPurchase) WHEN 4 THEN TotalPrice ELSE 0 END) AS APR,
	SUM(CASE MONTH(DateofPurchase) WHEN 5 THEN TotalPrice ELSE 0 END) AS MAY,
	SUM(CASE MONTH(DateofPurchase) WHEN 6 THEN TotalPrice ELSE 0 END) AS JUN,
	SUM(CASE MONTH(DateofPurchase) WHEN 7 THEN TotalPrice ELSE 0 END) AS JUL,
	SUM(CASE MONTH(DateofPurchase) WHEN 8 THEN TotalPrice ELSE 0 END) AS AUG,
	SUM(CASE MONTH(DateofPurchase) WHEN 9 THEN TotalPrice ELSE 0 END) AS SEP,
	SUM(CASE MONTH(DateofPurchase) WHEN 10 THEN TotalPrice ELSE 0 END) AS OCT,
	SUM(CASE MONTH(DateofPurchase) WHEN 11 THEN TotalPrice ELSE 0 END) AS NOV,
	SUM(CASE MONTH(DateofPurchase) WHEN 12 THEN TotalPrice ELSE 0 END) AS 'DEC'
FROM tblOrders
GROUP BY YEAR(DateofPurchase)
ORDER BY YEAR(DateofPurchase)

-- Total available stock in physical and online stores, grouped by Make and Model
SELECT Manufacturer, MakeModel, QtyShelf, SUM(QtyTotal - QtyShelf) AS 'OnlineStock'
FROM tblProducts
GROUP BY Manufacturer, MakeModel, QtyShelf
ORDER BY Manufacturer

-- Total Revenue Per Year Based on Customer City
SELECT YEAR(o.DateofPurchase) AS 'YEAR', 
	SUM(o.TotalPrice) AS TOTAL_REVENUE,
	a.City AS CUSTOMER_CITY
FROM 
	tblOrders o, 
	tblCustomers c, 
	tblAddress a
WHERE 
	o.CustomerID = c.CustomerID AND
	a.AddressID = c.AddressID
GROUP BY a.City, YEAR(o.DateofPurchase)
ORDER BY YEAR(o.DateofPurchase)