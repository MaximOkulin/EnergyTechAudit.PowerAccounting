GO

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'EnergyTechAudit.PowerAccounting.DeviceReader')
BEGIN
    CREATE LOGIN [EnergyTechAudit.PowerAccounting.DeviceReader] WITH PASSWORD = N'17#TpV93H'
END
GO

IF NOT EXISTS (SELECT name FROM [EnergyTechAudit.PowerAccounting.Database].sys.sysusers  WHERE name = 'EnergyTechAudit.PowerAccounting.DeviceReaderUser')
BEGIN
	CREATE USER [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
		FOR LOGIN [EnergyTechAudit.PowerAccounting.DeviceReader]
		WITH DEFAULT_SCHEMA = dbo
END
GO

GRANT CONNECT TO [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
GO
GRANT SELECT TO [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
GO
GRANT DELETE TO [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
GO
GRANT INSERT TO [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
GO
GRANT UPDATE TO [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
GO
GRANT EXECUTE TO [EnergyTechAudit.PowerAccounting.DeviceReaderUser]
GO