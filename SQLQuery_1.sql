USE AdventureWorks2019
GO

-- 1/
SELECT ProductID, Name, Color, ListPrice
from Production.Product

-- 2/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice != 0
-- 3/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is NULL

-- 4/
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is NOT NULL

-- 5/ 
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color is NOT NULL and ListPrice > 0

-- 6/
SELECT Name + ' ' + Color AS [Name Color]
FROM Production.Product
WHERE Color is NOT NULL

-- 7/
SELECT TOP 6 'NAME: ' + Name + ' --  ' + 'COLOR: ' + Color AS [Name Color]
FROM Production.Product
WHERE Color is NOT NULL

-- 8/
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 and 501

-- 9/
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Black' or Color = 'Blue'

-- 10/ 
SELECT * 
FROM Production.Product
WHERE Name LIKE 'S%'

-- 11/
SELECT TOP 6 Name, CONVERT(DECIMAL(10,2) ,ListPrice) AS ListPrice
From Production.Product
WHERE Name LIKE 'S%'
ORDER BY 1 ASC

-- 12/
SELECT TOP 5 Name, CONVERT(DECIMAL(10,2) ,ListPrice) AS ListPrice
FROM Production.Product
WHERE Name LIKE 'S%' or Name LIKE 'A%'
ORDER BY 1 ASC

-- 13/ 
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY 1

-- 14/
SELECT DISTINCT Color
FROM Production.Product
WHERE Color is NOT NULL
ORDER BY Color DESC

-- 15/

SELECT DISTINCT Color, ProductSubcategoryID, Color + ' ' + CAST(ProductSubcategoryID AS nvarchar) AS Combination
FROM Production.Product
WHERE Color is NOT NULL and ProductSubcategoryID is NOT NULL
ORDER BY Color ASC, ProductSubcategoryID asc