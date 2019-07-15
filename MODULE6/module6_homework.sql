USE SalesOrder
GO


--1

SELECT productID,
	   [name],
	   city,
	   ROW_NUMBER() OVER (order by city) AS ROW_NUM
FROM products


--2
SELECT productID,
	   [name],
	   city,
	   ROW_NUMBER() OVER (partition by city  order by [name]) AS ROW_NUM
FROM products
ORDER BY [city]


--3
SELECT * FROM (
SELECT productID,
	   [name],
	   city,
	   ROW_NUMBER() OVER (partition by city  order by [name]) AS ROW_NUM
FROM products) AS city1
WHERE ROW_NUM = 1
ORDER BY [city]

--4
SELECT productID,
	   detailID,
	   quantity,
	   SUM(quantity) OVER (PARTITION BY productID order by productID) AS all_quantity_per_prod,
	   SUM(quantity) OVER (PARTITION BY detailID order by detailID) AS all_quantity_per_det
FROM supplies

--5
SELECT * FROM (
SELECT supplierID,
	   detailID,
	   productID,
	   quantity,
	   ROW_NUMBER() OVER (order by supplierID) AS rn,
	   COUNT(*) OVER () AS tot
FROM supplies) AS total
WHERE rn BETWEEN 10 AND 15


--6
SELECT * FROM (
SELECT supplierID,
	   detailID,
	   productID,
	   quantity,
	   AVG(quantity) OVER () AS avg_qty
FROM supplies) AS average_quantity_table
WHERE quantity < avg_qty