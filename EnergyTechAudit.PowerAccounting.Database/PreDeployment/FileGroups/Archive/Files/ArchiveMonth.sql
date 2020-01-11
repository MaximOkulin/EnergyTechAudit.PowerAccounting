
ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME = 'EnergyTechAudit.PowerAccounting.Database.ArchiveMonth',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_ArchiveMonth.ndf',
		FILEGROWTH = 1 MB,
		MAXSIZE = UNLIMITED
	) TO FILEGROUP [ARCHIVE_MONTH]
	
