
ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME = 'EnergyTechAudit.PowerAccounting.Database.ArchiveHour',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_ArchiveHour.ndf',
		FILEGROWTH = 5 MB,
		MAXSIZE = UNLIMITED
	) TO FILEGROUP [ARCHIVE_HOUR]
	
