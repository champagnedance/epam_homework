--2
USE master
DROP DATABASE PDubnytskyi_module_2

CREATE DATABASE PDubnytskyi_module_2
GO


USE PDubnytskyi_module_2
GO

--3.1,3.2,3.3

CREATE TABLE TEACHER(
	[ID]				integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[degree]			integer NOT NULL CHECK(degree BETWEEN 1 AND 5) DEFAULT(1),
	[f_name]			nvarchar(40) NOT NULL,
	[l_name]			nvarchar(40) NOT NULL,
	[phone_number]		varchar(10) NOT NULL UNIQUE,
	[email]				varchar(40) NOT NULL UNIQUE,
	[office]			integer NOT NULL DEFAULT(1),
	[adress]			varchar (40) NOT NULL,
	[inserted_date]		datetime NOT NULL DEFAULT (getdate()),
	[updated_date]		datetime
)


CREATE TABLE CLASS(
	[ID]				integer NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[floor]				nvarchar(20) NOT NULL,
	[type_of_class]		integer NOT NULL CHECK([type_of_class] BETWEEN 1 AND 5),
	[day_of_week]		varchar(10) NOT NULL UNIQUE CHECK (day_of_week IN ('monday','tuesday','wednesday','thursday','friday')),
	[amount_of_places]	integer NOT NULL CHECK(amount_of_places > 0),
	[course_code]		integer NOT NULL CHECK(course_code > 0),
	[private]			varchar(3) NOT NULL CHECK([private] IN('yes','no')),
	[teachers_ID]		integer NOT NULL FOREIGN KEY(ID) REFERENCES TEACHER(ID),
	[inserted_date]		datetime NOT NULL DEFAULT (getdate()),
	[updated_date]		datetime NOT NULL DEFAULT (getdate())	
)


--3.4
GO
CREATE TRIGGER date_update ON TEACHER
AFTER UPDATE
AS

BEGIN

IF @@ROWCOUNT = 0 RETURN 
ELSE
	UPDATE TEACHER SET updated_date = getdate()
	FROM TEACHER
	INNER JOIN INSERTED ON teacher.id = inserted.id
END


--3.5
GO
CREATE VIEW TEACHER_VIEW
AS
SELECT * FROM TEACHER

GO
CREATE VIEW CLASS_VIEW
AS
SELECT * FROM CLASS

--3.6
GO
CREATE VIEW TEACHER_VIEW1
AS
SELECT * FROM TEACHER
WITH CHECK OPTION

GO
CREATE VIEW CLASS_VIEW1
AS
SELECT * FROM CLASS
WITH CHECK OPTION
