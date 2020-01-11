
ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME = 'EnergyTechAudit.PowerAccounting.Database.ArchiveFinal',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_ArchiveFinal.ndf',
		FILEGROWTH = 1 MB,
		MAXSIZE = UNLIMITED
	) TO FILEGROUP [ARCHIVE_FINAL]
	
