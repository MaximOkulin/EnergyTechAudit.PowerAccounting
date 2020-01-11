
ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME = 'EnergyTechAudit.PowerAccounting.Database.ArchiveFinalInstant',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_ArchiveFinalInstant.ndf',
		FILEGROWTH = 1 MB,
		MAXSIZE = UNLIMITED
	) TO FILEGROUP [ARCHIVE_FINALINSTANT]
	
