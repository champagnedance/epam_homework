USE SalesOrders
GO 


--1
SELECT DISTINCT CustCity FROM Customers


--2
SELECT EmpFirstName, EmpLastName, EmpPhoneNumber FROM Employees


--3
SELECT DISTINCT CategoryDescription FROM Categories


--4
SELECT ProductName, RetailPrice, CategoryID FROM Products
WHERE ProductNumber IN (SELECT ProductNumber FROM Product_Vendors)


--5
SELECT VendName FROM Vendors
ORDER BY VendZipCode


--6
SELECT EmployeeID, EmpFirstName, EmpLastName,EmpPhoneNumber FROM Employees
ORDER BY EmpFirstName, EmpLastName


--7
SELECT VendName FROM Vendors


--8
SELECT DISTINCT CustState FROM Customers


--9
SELECT ProductName, RetailPrice FROM Products


--10
SELECT EmployeeID,
	   EmpFirstName,
	   EmpLastName,
	   EmpStreetAddress,
	   EmpCity,
	   EmpState,
	   EmpZipCode,
	   EmpAreaCode,
	   EmpPhoneNumber 
FROM Employees


--11
SELECT VendName, VendCity FROM Vendors
ORDER BY VendName


--12
SELECT OrderNumber, Max(DaysToDeliver) AS DaysToDeliver FROM Product_Vendors a
JOIN Order_Details b ON a.ProductNumber=b.ProductNumber
GROUP BY OrderNumber


--13
SELECT ProductName, QuantityOnHand * RetailPrice AS Price FROM Products


--14
SELECT OrderNumber, DATEDIFF(day, OrderDate, ShipDate) AS DaysToShip FROM Orders


----------------------------------------------------------------------------------------------------------

--1
;WITH seq AS
(SELECT 1 AS num
 UNION ALL
 SELECT num + 1 FROM seq
 WHERE num < 10000)

SELECT * FROM seq
OPTION (MAXRECURSION 10000)

--2
;WITH weekends AS(
 SELECT CAST('2019-01-01' AS date) as [days]
 UNION ALL
 SELECT DATEADD(dd,1,[days]) FROM weekends
 WHERE DATEADD(dd,1,[days]) <= CAST('2019-12-31' AS date)
) 

SELECT COUNT([days]) Total, DATENAME(dw, [days]) AS [days] FROM weekends
WHERE DATENAME(dw,[days]) = 'Sunday' OR DATENAME(dw,[days]) = 'Saturday'
GROUP BY DATENAME (dw,[days])
OPTION (MAXRECURSION 365)