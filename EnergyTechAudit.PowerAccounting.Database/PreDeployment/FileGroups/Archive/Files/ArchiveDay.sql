
ALTER DATABASE [$(DatabaseName)]
	ADD FILE
	(
		NAME =  'EnergyTechAudit.PowerAccounting.Database.ArchiveDay',
		FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_ArchiveDay.ndf',
		FILEGROWTH = 1 MB,
		MAXSIZE = UNLIMITED
	) TO FILEGROUP [ARCHIVE_DAY]

	GO 
