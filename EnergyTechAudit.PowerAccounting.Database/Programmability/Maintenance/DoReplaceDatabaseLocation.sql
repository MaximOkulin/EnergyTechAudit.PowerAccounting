/*
  1) Папка с правами NT SERVICE\MSSQL$SERVER
  2) Запуск скрипта
  3) Перенос файлов руками (физическое копирование файлов в целевой каталог)
  4) Перевод базы в онлайн
*/

USE master;

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database] SET OFFLINE WITH ROLLBACK IMMEDIATE;
GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database.mdf'
);

GO
ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database_log], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_log.ldf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.ArchiveDay], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_ArchiveDay.ndf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.ArchiveHour], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_ArchiveHour.ndf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.ArchiveFinalInstant], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_ArchiveFinalInstant.ndf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.ArchiveFinal], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_ArchiveFinal.ndf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.ArchiveInstant], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_ArchiveInstant.ndf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.ArchiveMonth], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_ArchiveMonth.ndf'
);

GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
MODIFY FILE 
( 
  NAME = [EnergyTechAudit.PowerAccounting.Database.FileStream], 
  FILENAME = 'E:\EnergyTechAudit.PowerAccounting.Database\DATA\EnergyTechAudit.PowerAccounting.Database_FileStream'
);

GO
--ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database] SET ONLINE;