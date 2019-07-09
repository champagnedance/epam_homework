use PDubnytskyi_module3
GO



--a
SELECT productID FROM products
WHERE productID IN (SELECT productID FROM supplies
					WHERE supplierID = 3)

--b
SELECT supplierID, name FROM suppliers
WHERE supplierID IN (SELECT detailID FROM supplies
					 WHERE detailID = 1 AND quantity > (SELECT AVG(quantity) FROM supplies))



--c
SELECT detailID FROM supplies
WHERE detailID IN (SELECT detailID FROM supplies
				   WHERE productID IN (SELECT productID FROM products
									   WHERE city = 'London'))

--d
SELECT supplierID, name FROM suppliers
WHERE supplierID IN (SELECT supplierID FROM supplies
					 WHERE detailID IN (SELECT detailID FROM details
										WHERE color = 'red'))

--e
SELECT detailID FROM details
WHERE detailID IN (SELECT detailID FROM supplies 
				   WHERE supplierID = 2)

--f
SELECT productID FROM products
WHERE productID IN (SELECT productID FROM supplies
					GROUP BY productID
					HAVING AVG(quantity) > (SELECT MAX(quantity) FROM supplies WHERE productID = 1))

--g
SELECT productID FROM products
WHERE productID NOT IN (SELECT DISTINCT productID FROM supplies)
