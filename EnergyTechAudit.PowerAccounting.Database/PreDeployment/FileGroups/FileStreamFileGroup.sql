/*
ALTER DATABASE [$(DatabaseName)]
	ADD FILEGROUP [FILESTREAM] CONTAINS FILESTREAM;
GO


ALTER DATABASE [$(DatabaseName)]
ADD FILE
	( NAME = 'EnergyTechAudit.PowerAccounting.Database.FileStream',
	  FILENAME = '$(DefaultDataPath)$(DefaultFilePrefix)_FileStream'
	)
TO FILEGROUP [FILESTREAM]
*/

GO
