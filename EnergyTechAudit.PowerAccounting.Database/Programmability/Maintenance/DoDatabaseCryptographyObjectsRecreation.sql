-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-11-05
-- Description: Пересоздание криптографических объектов базы даннях при переносе базы 
-- или восстановлении с резервной копии на другой машине 
-- ===================================================================================================

USE [EnergyTechAudit.PowerAccounting.Database]
GO

DROP SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
GO

DROP CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];
GO  

DROP MASTER KEY;
GO

CREATE MASTER KEY ENCRYPTION BY
  PASSWORD = 'gh8nc3pe4';
GO

CREATE CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate]   
	WITH SUBJECT = '[EnergyTechAudit.PowerAccounting.Database]',
  START_DATE = N'2015-09-18', 
  EXPIRY_DATE = N'2025-09-18';
GO

CREATE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey] WITH	
	ALGORITHM = AES_128 
	ENCRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];   