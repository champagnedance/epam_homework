USE PDubnytskyi_module3
													-- CTE AND Hierarchical queries
--1
WITH avg_qty AS
(SELECT AVG(quantity)  as average_quantity FROM supplies),
 more_than_avg AS
(SELECT AVG(quantity) as average_quantity, productID FROM supplies
 GROUP BY productID
 HAVING AVG(quantity) > (SELECT average_quantity  FROM avg_qty))

 SELECT * FROM more_than_avg

 --2

;WITH factorial_values AS
(SELECT 1 AS position, 1  AS value
 UNION ALL
 SELECT position + 1, (position + 1) * value from factorial_values
 WHERE position < 10)

SELECT * FROM factorial_values

--3
;WITH fibonacci_seq AS
(SELECT 1 as position, 0 as prev_value, 1 as [value]
UNION ALL
SELECT position + 1, [value] ,  prev_value + [value]  FROM fibonacci_seq
WHERE position < 20
)

SELECT position, value FROM fibonacci_seq

--4
DECLARE @start DATE = '2013-11-25'
DECLARE @end   DATE = '2014-03-05'

;WITH months_calendar AS(
SELECT DATEADD(month, DATEDIFF(month, 0, '2013-11-25'), 0) AS StartOfMonth, 
       DATEADD(day, -1, DATEADD(MONTH, DATEDIFF(month, 0, @start) + 1, 0)) AS EndOfMonth
UNION ALL
SELECT DATEADD(month, 1, StartOfMonth) AS StartDate,
	   DATEADD(day, -1, DATEADD(month, DATEDIFF(month, 0,  DATEADD(month, 1, StartOfMonth)) + 1, 0)) AS EndOfMonth
FROM months_calendar
WHERE DATEADD(month, 1, StartOfMonth) <= @End)

SELECT  
    CAST((CASE WHEN StartOfMonth < @start THEN @start ELSE StartOfMonth END) AS date) AS StartDate,
    CAST((CASE WHEN EndOfMonth > @End THEN @End ELSE EndOfMonth END) AS date) AS EndDate
FROM months_calendar;

--5
set datefirst 1;

;WITH calendar AS (
SELECT CAST('2019-07-01' AS date) AS startDate
UNION ALL
SELECT DATEADD(D, 1 ,startDate)  FROM calendar
WHERE DATEADD(D, 1 ,startDate) <= EOMONTH(startDate))

SELECT [Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday], [Sunday] FROM
(SELECT DATENAME(DW,startDate) weekDayName, DATEPART(D,startDate) AS daysDate, DATEPART(WEEK, startDate) as Weel FROM calendar) AS cal
PIVOT
(
MIN(daysDate)
FOR weekDayName IN ([Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday], [Sunday])
) as pvt

																		--GEO
USE master
GO
CREATE DATABASE GEO
GO
USE GEO
GO

DROP TABLE IF EXISTS geography
GO

create table [geography]
(id int not null primary key, name varchar(20), region_id int);
ALTER TABLE [geography]
ADD CONSTRAINT R_GB
FOREIGN KEY (region_id)
REFERENCES [geography] (id);
insert into [geography] values (1, 'Ukraine', null);
insert into [geography] values (2, 'Lviv', 1);
insert into [geography] values (8, 'Brody', 2);
insert into [geography] values (18, 'Gayi', 8);
insert into [geography] values (9, 'Sambir', 2);
insert into [geography] values (17, 'St.Sambir', 9);
insert into [geography] values (10, 'Striy', 2);
insert into [geography] values (11, 'Drogobych', 2);
insert into [geography] values (15, 'Shidnytsja', 11);
insert into [geography] values (16, 'Truskavets', 11);
insert into [geography] values (12, 'Busk', 2);
insert into [geography] values (13, 'Olesko', 12);
insert into [geography] values (30, 'Lvivska st', 13);
insert into [geography] values (14, 'Verbljany', 12);
insert into [geography] values (3, 'Rivne', 1);
insert into [geography] values (19, 'Dubno', 3);
insert into [geography] values (31, 'Lvivska st', 19);
insert into [geography] values (20, 'Zdolbuniv', 3);
insert into [geography] values (4, 'Ivano-Frankivsk', 1);
insert into [geography] values (21, 'Galych', 4);
insert into [geography] values (32, 'Svobody st', 21);
insert into [geography] values (22, 'Kalush', 4);
insert into [geography] values (23, 'Dolyna', 4); 
insert into [geography] values (5, 'Kiyv', 1);
insert into [geography] values (24, 'Boryspil', 5);
insert into [geography] values (25, 'Vasylkiv', 5);
insert into [geography] values (6, 'Sumy', 1);
insert into [geography] values (26, 'Shostka', 6);
insert into [geography] values (27, 'Trostjanets', 6);
insert into [geography] values (7, 'Crimea', 1);
insert into [geography] values (28, 'Yalta', 7);
insert into [geography] values (29, 'Sudack', 7);


--1
;WITH region_CTE AS
(SELECT region_id, ID, [name], 1 AS PlaceLevel  FROM [geography]
 WHERE region_id = 1
)

SELECT * FROM region_CTE

--2

;WITH sub_req_CTE AS
(SELECT region_id, ID, [name], 0 AS PlaceLevel FROM [geography]
 WHERE region_id = 4
 UNION ALL
 SELECT b.region_id, b.ID, b.[name], PlaceLevel + 1 FROM sub_req_CTE a
 inner join geography b ON a.id = b.region_id)

 SELECT * FROM sub_req_CTE


 --3
 ;WITH ua_root_cte AS (
 SELECT region_id, ID, [name], 0 AS PlaceLevel, CAST([name] AS varchar(200)) AS path FROM [geography]
 WHERE [name] = 'Ukraine'
 UNION ALL
 SELECT a.region_id,a.ID, a.[name], PlaceLevel + 1,CAST( Path + '/' + CAST(a.name AS varchar(200)) AS varchar(200)) FROM [geography] a
 JOIN ua_root_cte b ON b.id = a.region_id
 )

 SELECT * FROM ua_root_cte


 --4
 ;WITH lviv_root_cte AS (
 SELECT region_id, ID, [name], 1 AS level FROM [geography]
 WHERE [name] = 'Lviv'
 UNION ALL
 SELECT a.region_id,a.ID, a.[name], [level] + 1 FROM [geography] a
 JOIN lviv_root_cte b ON b.id = a.region_id)

 SELECT [name], id, region_id, [level] FROM lviv_root_cte

 --5
 ;WITH lviv_root_cte AS (
 SELECT region_id, ID, [name], CAST([name] AS varchar(200)) AS path FROM [geography]
 WHERE [name] = 'Lviv'
 UNION ALL
 SELECT a.region_id,a.ID, a.[name],CAST( Path + '/' + CAST(a.name AS varchar(200)) AS varchar(200)) FROM [geography] a
 JOIN lviv_root_cte b ON b.id = a.region_id)

 SELECT [name], id, [path] FROM lviv_root_cte

 --6
 
 ;WITH lv_root_cte AS (
 SELECT region_id, ID, [name], 0 AS pathlen, CAST([name] AS varchar(200)) AS path FROM [geography]
 WHERE [name] = 'Lviv'
 UNION ALL
 SELECT a.region_id, a.ID, a.[name], pathlen + 1, CAST( Path + '/' + CAST(a.name AS varchar(200)) AS varchar(200)) FROM [geography] a
 JOIN lv_root_cte b ON b.id = a.region_id)

 SELECT [name], 
		(SELECT [name] FROM [geography]
		WHERE id = 2) AS center,
		id, 
		pathlen, 
		[path] 
FROM lv_root_cte

