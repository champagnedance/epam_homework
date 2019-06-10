USE PDubnytskyi_module_2
	GO


DROP TRIGGER IUD_TRIGGER
DROP TABLE USERS
DROP TABLE USERS_AUDIT


CREATE TABLE [USERS](
	[ID]				integer NOT NULL PRIMARY KEY,
	[username]			nvarchar (40) NOT NULL ,
	[f_name]			nvarchar(40) NOT NULL,
	[l_name]			nvarchar(40) NOT NULL,
	[phone_number]		varchar(10) NOT NULL UNIQUE,
	[email]				varchar(40) NOT NULL UNIQUE,
	[type_of_acc]		integer NOT NULL DEFAULT(1) CHECK ([type_of_acc] BETWEEN 1 AND 5),
	[adress]			varchar (40) NOT NULL,
)



CREATE TABLE [USERS_AUDIT](
	[ID]				integer NOT NULL IDENTITY PRIMARY KEY,
	[userID]			integer NOT NULL,
	[username]			nvarchar(40) NOT NULL ,
	[f_name]			nvarchar(40) NOT NULL,
	[l_name]			nvarchar(40) NOT NULL,
	[phone_number]		varchar(10) NOT NULL,
	[email]				varchar(40) NOT NULL,
	[type_of_acc]		integer NOT NULL,
	[adress]			varchar (40) NOT NULL,
	[type_of_operation]	varchar (10),
	[date_of_operation] datetime
)

GO
CREATE TRIGGER IUD_TRIGGER ON USERS
AFTER INSERT, UPDATE, DELETE
AS

BEGIN

IF @@ROWCOUNT = 0 RETURN 
DECLARE @operation char (10)
DECLARE @ins int = (SELECT COUNT(*) FROM INSERTED)
DECLARE @del int = (SELECT COUNT(*) FROM DELETED)
SET @operation = 
CASE
	WHEN @ins > 0 AND @del > 0 THEN 'Update'
	WHEN @ins = 0 AND @del > 0 THEN 'Delete'
	WHEN @ins > 0 AND @del = 0 THEN 'Insert'
END
---INSERT
IF @operation = 'Insert'
BEGIN
	INSERT INTO [USERS_AUDIT](userID,username,f_name,l_name,phone_number,email,type_of_acc,adress,type_of_operation,date_of_operation)
	SELECT a.ID,a.username,a.f_name,a.l_name,a.phone_number,a.email,a.type_of_acc,a.adress, @operation, getdate()  FROM USERS a
	INNER JOIN inserted ON a.ID = inserted.ID
END
---DELETE
IF @operation = 'Delete'
BEGIN
	INSERT INTO [USERS_AUDIT](userID,username,f_name,l_name,phone_number,email,type_of_acc,adress,type_of_operation,date_of_operation)
	SELECT a.ID, a.username, a.f_name,a.l_name,a.phone_number,a.email,a.type_of_acc,a.adress, @operation, getdate()
	FROM deleted a
END
--UPDATE
IF @operation = 'Update'
BEGIN
	INSERT INTO [USERS_AUDIT](userID,username,f_name,l_name,phone_number,email,type_of_acc,adress,type_of_operation,date_of_operation)
	SELECT b.ID,b.username,b.f_name,b.l_name,b.phone_number,b.email,b.type_of_acc,b.adress, @operation, getdate() 
	FROM USERS a
	INNER JOIN inserted b ON a.id = b.ID
	INNER JOIN deleted ON a.id = deleted.ID
END
END
