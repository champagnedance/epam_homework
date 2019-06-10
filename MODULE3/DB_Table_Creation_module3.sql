USE master
GO

DROP DATABASE PDubnytskyi_module3
GO

CREATE DATABASE PDubnytskyi_module3
GO

USE PDubnytskyi_module3
GO

CREATE TABLE suppliers(
					   supplierID integer PRIMARY KEY,
					   name varchar(20),
					   rating integer,
					   city varchar(20)
)

INSERT INTO suppliers VALUES
(1,'Smith',20,'London'),
(2,'Jonth',10,'Paris'),
(3,'Blacke',30,'Paris'),
(4,'Clark',20,'London'),
(5,'Adams',30,'Athens')

CREATE TABLE details(
					 detailID integer PRIMARY KEY,
					 name varchar(20),
					 color varchar(20),
					 weight integer,
					 city varchar(20)
)

INSERT INTO details VALUES
(1,'Screw','Red',12,'London'),
(2,'Bolt','Green',17,'Paris'),
(3,'Male-screw','Blue',17,'Roma'),
(4,'Male-screw','Red',14,'London'),
(5,'Whell','Blue',12,'Paris'),
(6,'Bloom','Red',19,'London')

CREATE TABLE products(
					  productID integer PRIMARY KEY,
					  name varchar(20),
					  city varchar(20)
)

INSERT INTO products VALUES
(1,'HDD','Paris'),
(2,'Perforator','Roma'),
(3,'Reader','Athens'),
(4,'Printer','Athens'),
(5,'FDD','London'),
(6,'Terminal','Oslo'),
(7,'Ribbon','London')

CREATE TABLE supplies(
					  supplierID integer FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID),
					  detailID integer FOREIGN KEY (detailID) REFERENCES details(detailID),
					  productID integer FOREIGN KEY (productID) REFERENCES products(productID),
					  quantity integer
) 

INSERT INTO supplies VALUES
(1,1,1,200),
(1,1,4,700),
(2,3,1,400),
(2,3,2,200),
(2,3,3,200),
(2,3,4,500),
(2,3,5,600),
(2,3,6,400),
(2,3,7,800),
(2,5,2,100),
(3,3,1,200),
(3,4,2,500),
(4,6,3,300),
(4,6,7,300),
(5,2,2,200),
(5,2,4,100),
(5,5,5,500),
(5,5,7,100),
(5,6,2,200),
(5,1,4,100),
(5,3,4,200),
(5,4,4,800),
(5,5,4,400),
(5,6,4,500)