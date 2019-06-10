USE PDubnytskyi_module3
GO

--1 
UPDATE suppliers SET rating = rating + 10
WHERE rating < (SELECT rating FROM suppliers WHERE supplierID = 4) 

SELECT * FROM suppliers

--2
SELECT productID 
INTO #london_products
FROM products
WHERE city = 'LONDON' OR productID IN (SELECT productID FROM supplies 
									   WHERE supplierID IN 
									  (SELECT supplierID FROM suppliers WHERE city = 'LONDON'))

SELECT * FROM #london_products

--3
INSERT INTO #london_products VALUES
(10),
(9)

DELETE FROM #london_products
WHERE productID NOT IN (SELECT productID FROM supplies)


--4
SELECT DISTINCT t1.supplierid, t1.detailid detail1, t2.detailid detail2 
INTO #supllier_details
FROM supplies t1
INNER JOIN supplies t2 ON t1.supplierid = t2.supplierid AND t1.detailid != t2.detailid AND t1.detailID > t2.detailID

--5
UPDATE supplies SET quantity = quantity + quantity*0.1
WHERE detailID IN (SELECT detailID FROM details WHERE color = 'red') 

SELECT * from supplies

--6
SELECT DISTINCT color, city
INTO #color_city_table
FROM details

SELECT * FROM #color_city_table

--7
SELECT detailID
INTO #london_details
FROM details
WHERE detailID IN (SELECT DISTINCT detailID FROM supplies
				   WHERE supplierID IN	
				  (SELECT supplierID FROM suppliers WHERE city = 'London')
				   OR productID IN
				  (SELECT productID FROM products WHERE city = 'London'))


--8
INSERT INTO suppliers VALUES
(10,'White',null,'New-York')

--9
DELETE FROM supplies
WHERE productID IN (SELECT productID FROM products WHERE city = 'Roma')

DELETE FROM products
WHERE city = 'Roma'

--10
SELECT city FROM (SELECT city FROM suppliers
				  UNION
				  SELECT city FROM details
				  UNION
				  SELECT city FROM products) city
ORDER BY city ASC

--11
UPDATE details SET color = 'yellow'
WHERE color = 'red' AND weight < 15

SELECT * FROM details

--12
SELECT productID,city
INTO #products_city_table
FROM products
WHERE city LIKE '_O%'

SELECT * FROM #products_city_table

--13
UPDATE suppliers SET rating = rating + 10
WHERE supplierID IN (SELECT supplierID FROM supplies
					 WHERE quantity >
					(SELECT AVG(quantity) FROM supplies))

SELECT * FROM suppliers

--14
SELECT supplierID, name 
INTO #supplier_for_p1
FROM suppliers
WHERE supplierID IN (SELECT supplierID FROM supplies WHERE productID = 1)
ORDER BY 1,2


--15
INSERT INTO suppliers VALUES
(7,'Black',20,'Roma'),
(8,'Strong',30,'New-York')


--16
SELECT *
INTO #tmp_details
FROM details
WHERE 1<>1

INSERT INTO #tmp_details (detailid, name, color, weight, city) VALUES 
(1, 'Screw', 'Blue', 13, 'Osaka'),
(2, 'Bolt', 'Pink', 12, 'Tokio'),
(18, 'Whell-24', 'Red', 14, 'Lviv'),
(19, 'Whell-28', 'Pink', 15, 'London')

SELECT * FROM details

--17
MERGE details t1
USING #tmp_details t2
ON (t1.detailID = t2.detailID)

WHEN MATCHED THEN
UPDATE SET t1.detailID = t2.detailID,t1.name = t2.name,t1.color = t2.color,t1.weight = t2.weight, t1.city = t2.city
WHEN NOT MATCHED BY TARGET THEN
INSERT VALUES (t2.detailID,t2.name,t2.color,t2.weight,t2.city);

select * from #tmp_details

select * from details