
ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME = 'EnergyTechAudit.PowerAccounting.Database.ArchiveInstant',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_ArchiveInstant.ndf',
		FILEGROWTH = 10 MB,
		MAXSIZE = UNLIMITED
	) TO FILEGROUP [ARCHIVE_INSTANT]
	
