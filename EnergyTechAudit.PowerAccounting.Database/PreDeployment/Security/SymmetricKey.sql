CREATE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey] WITH	
	ALGORITHM = AES_128 
	ENCRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];