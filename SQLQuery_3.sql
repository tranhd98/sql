-- 1/
SELECT DISTINCT City
FROM Customers
WHERE city in (
    SELECT City
    FROM Employees
)
-- 2/
-- sub-query
SELECT DISTINCT City
FROM Customers
WHERE city not in (
    SELECT City
    FROM Employees
)

-- not use sub-query


SELECT DISTINCT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City
WHERE e.City is NULL

-- 3/
-- join
SELECT p.ProductID, SUM(od.Quantity) [Total Order Quantities]
FROM Products p left join [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID
--subquery

SELECT p.ProductID,
(SELECT SUM(Quantity) FROM [Order Details] od WHERE od.ProductID = p.ProductID) [Total Order Quantities]
FROM Products p
GROUP BY p.ProductID

-- 4/ 
SELECT c.City, SUM(od.Quantity) [Total Products]
FROM Customers c left join Orders o ON c.CustomerID = o.CustomerID inner join [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City

-- 5/
-- UNION
Select City, COUNT(CustomerID)
FROM Customers
GROUP BY City

-- 7/
SELECT c.CustomerID, c.ContactName, c.City, o.ShipCity 
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity

-- 8/


SELECT TOP 5 p.ProductID, AVG(od.UnitPrice) Average, SUM(od.Quantity) TheSum, c.City, od.Quantity,DENSE_RANK() OVER(PARTITION BY c.City ORDER BY od.Quantity DESC) RNK
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID INNER JOIN Customers c ON o.CustomerID = c.CustomerID 
GROUP BY p.ProductID, c.City, od.Quantity
ORDER BY TheSum DESC


-- 9/
--subquery

WITH CityCTE
AS(SELECT City
FROM Customers 
WHERE CustomerID NOT IN(
    SELECT DISTINCT CustomerID FROM Orders
))
SELECT City
FROM Employees
WHERE City in(Select Distinct City FROM CityCTE)

-- not subquery
WITH CityCTE
AS(SELECT City
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID is NULL)
SELECT e.City
FROM Employees e INNER JOIN CityCTE cte ON e.City = cte.City

-- 10/

-- 11/
-- 1/ Using group by clause and max()
-- example
-- Delete from empDetail where ID not in(
--     select MAX(<primary key>) From empDetail Group By <all non aggregate attributes>
-- )
-- 2/ Using CTE and Row_Number()
-- use to keep track on row number
-- if row number > 1, delete the row in cte
