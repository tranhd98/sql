USE AdventureWorks2019
GO

-- 1/ 
SELECT COUNT(*)
FROM Production.Product

-- 2/
SELECT COUNT(ProductSubcategoryID)
FROM Production.Product

-- 3/
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) as CountedProducts
FROM Production.Product
GROUP BY ProductSubcategoryID

-- 4/
SELECT COUNT(*)
FROM Production.Product
WHERE ProductSubcategoryID is NULL

-- 5/ 
SELECT SUM(Quantity)
FROM Production.ProductInventory

-- 6/
SELECT ProductID, SUM(Quantity) AS TheSum 
FROM Production.ProductInventory
WHERE LocationID = 40 and Quantity < 100
GROUP BY ProductID
-- 7/
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum 
FROM Production.ProductInventory
WHERE LocationID = 40 and Quantity < 100
GROUP BY Shelf, ProductID

-- 8/
SELECT AVG(Quantity) 
FROM Production.ProductInventory
WHERE LocationID = 10

-- 9/
SELECT Shelf, AVG(Quantity) 
FROM Production.ProductInventory
GROUP BY Shelf

-- 10/
SELECT Shelf, AVG(Quantity) 
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf

select *
From Production.Product
-- 11/
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) as AvgPrice
FROM Production.Product
WHERE Color is not NULL and Class is not NULL
GROUP BY Color, Class

-- 12/
-- join
SELECT c.Name as Country, s.Name as Province
FROM Person.CountryRegion c INNER JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
-- subquery
SELECT
(SELECT Name FROM Person.CountryRegion c WHERE c.CountryRegionCode = s.CountryRegionCode) Country,
s.Name AS Province
FROM Person.StateProvince s

-- 13/
-- join
SELECT c.Name as Country, s.Name as Province
FROM Person.CountryRegion c INNER JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name = 'Germany' or c.Name = 'Canada'

-- subquery
SELECT
(SELECT Name FROM Person.CountryRegion c WHERE c.CountryRegionCode = s.CountryRegionCode) Country,
s.Name AS Province
FROM Person.StateProvince s
WHERE (SELECT Name FROM Person.CountryRegion c1 WHERE c1.CountryRegionCode = s.CountryRegionCode) = 'Germany' or (SELECT Name FROM Person.CountryRegion c1 WHERE c1.CountryRegionCode = s.CountryRegionCode) = 'Canada'


-- 14/
USE Northwind
GO



SELECT p.ProductName, o.OrderDate, p.UnitsOnOrder
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE p.UnitsOnOrder >= 1 and Year(o.OrderDate) >= 2022 - 25

-- 15/
SELECT TOP 5 od.OrderID, o.ShipPostalCode, SUM(od.Quantity) as [Total Products]
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY od.OrderID, o.ShipPostalCode
ORDER BY [Total Products] DESC

-- 16/
SELECT TOP 5 od.OrderID, o.ShipPostalCode, o.OrderDate, SUM(od.Quantity) as [Total Products]
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE Year(o.OrderDate) >= 2022 - 25
GROUP BY od.OrderID, o.ShipPostalCode, o.OrderDate
ORDER BY [Total Products] DESC

-- 17/

SELECT City, COUNT(CustomerID) [Total of Customers in the city]
FROM Customers
GROUP BY City
ORDER BY 2 

-- 18/
SELECT City, COUNT(CustomerID) [Total of Customers in the city]
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2;

-- 19/
SELECT c.ContactName, o.OrderDate
FROM Customers c INNER JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE Month(o.OrderDate) >= 1 and Day(o.OrderDate) > 1 and Year(o.OrderDate) >= 1998  

-- 20/
declare @recentDates DATETIME
select @recentDates = (SELECT DISTINCT TOP 1 OrderDate FROM Orders ORDER BY OrderDate DESC)
SELECT c.ContactName, o.OrderDate
FROM Customers c INNER JOIN Orders o ON o.CustomerID = c.CustomerID
WHERE OrderDate = @recentDates

-- 21/
SELECT c.ContactName, COUNT(od.ProductID) as [Total Products]
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.ContactName

-- 22/

SELECT c.CustomerID, COUNT(od.ProductID) as [Total Products]
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.ProductID) > 100

-- 23/
SELECT DISTINCT su.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipping Company Name]
FROM Suppliers su INNER JOIN Products p ON su.SupplierID = p.SupplierID INNER JOIN [Order Details] od ON p.ProductID = od.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID INNER JOIN Shippers sh ON o.ShipVia = sh.ShipperID

-- 24/
SELECT o.OrderDate, p.ProductName
FROM Orders o INNER JOIN [Order Details] od ON o.OrderID = od.OrderID INNER JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate

-- 25/
SELECT e1.FirstName AS [Person 1], e2.FirstName AS [Person 2]
FROM Employees e1, Employees e2
WHERE e1.Title = e2.Title and e1.EmployeeID <> e2.EmployeeID

-- 26/
SELECT m.FirstName + ' '+ m.LastName as Manager, COUNT(m.EmployeeID) AS [Total Employees reporting]
FROM Employees e INNER JOIN Employees m ON e.ReportsTO = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(m.EmployeeID) > 2

-- 27/
SELECT City, CompanyName as Name, ContactName as [Contact Name], 'Customers' AS Type
FROM Customers
UNION 
SELECT City, CompanyName as Name, ContactName as [Contact Name], 'Suppliers' AS Type
FROM Suppliers
