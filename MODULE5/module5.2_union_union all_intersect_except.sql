use PDubnytskyi_module3
GO

--1
SELECT [name] FROM suppliers
WHERE city = 'London'
UNION
SELECT [name] FROM suppliers
WHERE city = 'Paris'

--2
SELECT city FROM suppliers
UNION ALL
SELECT city FROM details
ORDER BY city


SELECT city FROM suppliers
UNION
SELECT city FROM details
ORDER BY city

--3
SELECT name FROM suppliers
EXCEPT
SELECT name FROM suppliers
WHERE city = 'London'

--4
SELECT productID, name, city FROM products
WHERE city = 'London' OR city = 'Paris'
EXCEPT
SELECT productID, name, city FROM products
WHERE city = 'Paris' OR city = 'Roma'

--5
SELECT supplierID, detailID, productID FROM supplies
WHERE supplierID IN (SELECT supplierID FROM suppliers
					 WHERE city = 'London')
UNION
SELECT supplierID, detailID, productID FROM supplies
WHERE detailID IN (SELECT detailID FROM details
			  WHERE color = 'green')
EXCEPT
SELECT supplierID, detailID, productID FROM supplies
WHERE productID IN (SELECT productID FROM products
					WHERE city = 'Paris')
