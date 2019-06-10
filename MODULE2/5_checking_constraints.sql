USE PDubnytskyi_module_2

--TO CHECK CORRECT BEHAVIOUR OF ALL CONSTRAINTS
--TASK 3
--TABLE TEACHER


UPDATE TEACHER SET degree = 7 -- to check CHECK CONSTRAINT
INSERT INTO TEACHER ([degree],[f_name],[l_name],[phone_number],[email],[office],[adress]) VALUES  --to check UNIQUE CONSTRAINT in columns phone_number and email
(1,'Ivan','Susanin','1111111111','susanin22@gmail.com',1,'Susanina 22'),
(4,'Petro','Ivanov','1111111111','susanin22@gmail.com',4,'Bandery 42')


--TABLE CLASS
INSERT INTO CLASS ([floor],[type_of_class],[day_of_week],[amount_of_places],[course_code],[private],[teachers_ID]) VALUES
(2,7,'monday',50,33,'yes',4), -- to check CHECK CONSTRAINT type_of_class
(2,4,'monday',50,33,'yes',4), -- to check UNIQUE CONSTRAINT day_of_week
(2,3,'lastday',50,33,'yes',4), --to check CHECK CONSTRAINT day_of_week
(2,2,'tuesday',0,33,'yes',4), -- to check CHECK CONSTRAINT amount_of_places
(2,5,'thursday',50,0,'yes',4), -- to check CHECK CONSTRAINT course_code
(2,1,'friday',50,33,'qwe',4) -- to check CHECK CONSTRAINT private


--TASK 4
--TABLE USERS
INSERT INTO USERS (ID,username,f_name,l_name,phone_number,email,type_of_acc,adress) VALUES
(2,'FLOW','JOHN','PEDRO',111111,'slasher@gmail.com',1,'Stepanyka 30'), 
(1,'Slowmo','Slon','Indro',111111,'slasher@gmail.com',1,'Stepanyka 30'), --to check UNIQUE CONSTRAINT IN phone_number and email
(4,'flash','Craig','Xen',1251251,'flash@gmail.com',8,'Stepanyka 30') --to check CHECK CONSTRAINT type_off_acc


--TO CHECK CORRECTED RECORDS INSERTED
--TASK 3
--TABLE TEACHER
INSERT INTO TEACHER ([degree],[f_name],[l_name],[phone_number],[email],[office],[adress]) VALUES
(1,'Ivan','Susanin','3344556677','susanin22@gmail.com',1,'Susanina 22'),
(4,'Petro','Ivanov','2222556333','ivanovp@gmail.com',4,'Bandery 42'),
(5,'Oleg','Gabral','3344525677','ogabral@gmail.com',3,'Shevchenka 47'),
(3,'Taras','Tyran','3341241424','tyrant53@gmail.com',2,'Virmenska 53'),
(2,'Danylo','Petrushevich','3344554666','danyloslasher@gmail.com',5,'Petrushevicha 2')


--TABLE CLASS
INSERT INTO CLASS ([floor],[type_of_class],[day_of_week],[amount_of_places],[course_code],[private],[teachers_ID]) VALUES
(2,3,'monday',50,33,'yes',4),
(4,3,'friday',25,37,'yes',1),
(2,5,'tuesday',10,59,'yes',3),
(3,4,'wednesday',20,47,'yes',2),
(1,1,'thursday',30,16,'yes',5)


--TO CHECK UPDATE TRIGGER
UPDATE TEACHER SET OFFICE = 1
WHERE OFFICE = 3


--TASK 4
--TABLE USERS
INSERT INTO USERS (ID,username,f_name,l_name,phone_number,email,type_of_acc,adress) VALUES
(2,'FLOW','JOHN','PEDRO',124125,'slasher@gmail.com',1,'Stepanyka 30'),
(1,'Slowmo','Slon','Indro',15125215,'slowmo@gmail.com',1,'Stepanyka 30'),
(4,'flash','Craig','Xen',1251251,'flash@gmail.com',1,'Stepanyka 30')


--TO CHECK INSERT,UPDATE,DELETE TRIGGER
INSERT INTO USERS (ID,username,f_name,l_name,phone_number,email,type_of_acc,adress) VALUES
(2,'FLOW','JOHN','PEDRO',124125,'slasher@gmail.com',1,'Stepanyka 30')

DELETE FROM USERS
WHERE ID = 4


UPDATE USERS SET type_of_acc = 2
WHERE ID = 2
