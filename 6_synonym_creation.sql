USE master
GO

CREATE DATABASE education
GO

USE education

CREATE SCHEMA PDubnytskyi
GO

-- 1-st synonym
CREATE SYNONYM PDubnytskyi.Synonym1
    FOR PDubnytskyi_module_2.dbo.teacher

SELECT * FROM PDubnytskyi.Synonym1

-- 2-nd synonym
CREATE SYNONYM PDubnytskyi.Synonym2
    FOR PDubnytskyi_module_2.dbo.class

SELECT * FROM PDubnytskyi.Synonym2

-- 3-rd synonym
CREATE SYNONYM PDubnytskyi.Synonym3
    FOR PDubnytskyi_module_2.dbo.users

SELECT * FROM PDubnytskyi.Synonym3

-- 4-th synonym
CREATE SYNONYM PDubnytskyi.Synonym4
    FOR PDubnytskyi_module_2.dbo.users_audit

SELECT * FROM PDubnytskyi.Synonym4


