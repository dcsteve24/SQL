-- =============================================
-- DELETE/UPDATE Database Script
-- Steven Craig 20Oct19
-- For school project CTU CS660 IP3
-- MICROSOFT SQL SERVER
-- =============================================

-- Swtich to Database --
USE GoodExcuse

-- Delete an entire Order based off unique identifier (Customer Returns Item)
  --My unique identifiers for "whole" order change thanks to NEWID() so what works on mine wont work on another PC... 
  --So this was what I came up with to make it work on all PCs (Typically the reciept would have the order number on it and you just do it that way.)
DELETE FROM tblOrders WHERE OrderID IN 
	(SELECT OrderID FROM tblOrders WHERE DateofPurchase = '2019-09-21' AND CustomerID = 
		(SELECT CustomerID FROM tblCustomers WHERE FirstName LIKE 'Jeff' AND
			MiddleName LIKE 'Michael' AND LastName LIKE 'Gordon' AND DOB = '1971-08-04'
		)
	)

-- Update a price of the product using a unique identifier
UPDATE tblProducts SET CustomerCost = 59.99 WHERE Barcode = '2941021105'

-- Update Address of Customer on Unique Identifier
UPDATE tblAddress 
	SET StreetAddress = '4444 Cherry Lane', 
		City = 'Indianapolis', 
		StateAbrv = 'IN',
		Country = 'USA',
		ZipCode = 46221
	WHERE AddressID = (SELECT AddressID FROM tblCustomers WHERE FirstName LIKE 'Jeff' AND
			MiddleName LIKE 'Michael' AND LastName LIKE 'Gordon' AND DOB = '1971-08-04'
			)

-- Update Count of Stock on Shelves when Stocking Up on Unique Identifier
UPDATE tblProducts SET QtyShelf += 15 WHERE Barcode = 2941021105

-- Update the Sales Tax on Unique Identifier
UPDATE tblSalesTax SET SalesTax = 7.25 WHERE StateAbrv LIKE 'IN'