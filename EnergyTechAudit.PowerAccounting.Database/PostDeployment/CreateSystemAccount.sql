GO

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'EnergyTechAudit.PowerAccounting.Web.Login')
BEGIN
    CREATE LOGIN [EnergyTechAudit.PowerAccounting.Web.Login] WITH PASSWORD = N'gh8nc3pe4'
END
GO

IF NOT EXISTS (SELECT name FROM [EnergyTechAudit.PowerAccounting.Database].sys.sysusers  WHERE name = 'EnergyTechAudit.PowerAccounting.Web.User')
BEGIN
	CREATE USER [EnergyTechAudit.PowerAccounting.Web.User]
		FOR LOGIN [EnergyTechAudit.PowerAccounting.Web.Login]
		WITH DEFAULT_SCHEMA = dbo
END
GO

GRANT CONNECT TO [EnergyTechAudit.PowerAccounting.Web.User]
GO 
GRANT SELECT TO [EnergyTechAudit.PowerAccounting.Web.User]
GO
GRANT DELETE TO [EnergyTechAudit.PowerAccounting.Web.User]
GO
GRANT INSERT TO [EnergyTechAudit.PowerAccounting.Web.User]
GO
GRANT UPDATE TO [EnergyTechAudit.PowerAccounting.Web.User]
GO
GRANT EXECUTE TO [EnergyTechAudit.PowerAccounting.Web.User]
GO

GRANT CREATE SCHEMA TO [EnergyTechAudit.PowerAccounting.Web.User]
GO 

GRANT CREATE TABLE TO [EnergyTechAudit.PowerAccounting.Web.User]
GO

USE [tempdb];
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [guest];
GO
ALTER ROLE [db_owner] ADD MEMBER [guest];
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [guest];
GO

USE [EnergyTechAudit.PowerAccounting.Database];
GO