
	ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME = 'EnergyTechAudit.PowerAccounting.Database.InMemory',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_InMemory.ndf'
	) TO FILEGROUP [INMEMORY]