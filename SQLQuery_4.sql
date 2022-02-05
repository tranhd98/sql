-- 1/

CREATE VIEW view_product_order_Tran
AS 
SELECT ProductID, SUM(Quantity) as [Total Quantities]
FROM [Order Details]
GROUP BY ProductID
GO
SELECT * FROM view_product_order_Tran
GO
-- 2/
CREATE PROC sp_product_order_quantity_Tran
@id int
AS 
BEGIN
DECLARE @total AS INT
SELECT @total = SUM(Quantity) FROM [Order Details] WHERE @id= ProductID GROUP BY ProductID
RETURN @total
END

DECLARE @result INT
EXEC @result = sp_product_order_quantity_Tran 1
PRINT @result
GO
-- 3/
CREATE PROC sp_product_order_city_Tran
@name VARCHAR(255)
AS
BEGIN
SELECT TOP 5 c.City, p.ProductName, SUM(Quantity) [Total Quantity]
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID JOIN [Order Details] od ON o.OrderID = od.OrderID JOIN Products p ON p.ProductID = od.ProductID
WHERE  p.ProductName = @name
GROUP BY c.City, p.ProductName
ORDER BY SUM(Quantity) DESC
END

EXEC sp_product_order_city_Tran 'Chai'

-- 4/
-- create city table
CREATE TABLE city_Tran(
    CityId int primary key,
    City varchar(255) DEFAULT 'Madison' 
)
-- insertion
INSERT INTO city_Tran VALUES(1, 'Seattle')
INSERT INTO city_Tran VALUES(2, 'Green Bay')
-- create people table
CREATE TABLE people_your_Tran(
    Id int primary key,
    Name varchar(255) not null,
    City int FOREIGN KEY REFERENCES city_Tran(CityId) on DELETE SET DEFAULT
)
-- insertion
INSERT INTO people_your_Tran VALUES(1, 'Aaron Eodgers', 2)
INSERT INTO people_your_Tran VALUES(2, 'Russell Wilson', 1)
INSERT INTO people_your_Tran VALUES(3, 'Jody Nelson', 2)
-- select tables
SELECT * FROM city_Tran
SELECT * FROM people_your_Tran

-- remove Seattle and replace to Madison 
UPDATE city_Tran
set City = 'Madison'
WHERE City = 'Seattle'
GO

CREATE VIEW Packers_Tran
AS
SELECT p.Name, c.City
FROM city_Tran c join people_your_Tran p ON c.CityId = p.City
WHERE c.City = [GREEN BAY]
GO

-- drop tables
-- DROP TABLE city_Tran
-- DROP TABLE people_your_Tran
-- DROP VIEW Packers_Tran


-- 5/ 

CREATE PROC sp_birthday_employees_Tran
AS
BEGIN
SELECT * INTO birthday_employees_Tran
FROM Employees WHERE MONTH(BirthDate)=2
END

EXEC sp_birthday_employees_Tran

SELECT * FROM birthday_employees_Tran
DROP TABLE birthday_employees_Tran
GO

-- 6/
-- use union. If result set from two select statements have different rows than table 1 and 2. Then they don't have same data.
-- use except. If result set return nothing. It means they have same data.