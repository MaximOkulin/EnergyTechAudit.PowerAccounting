CREATE PROCEDURE [Programmability].[DecryptData]
  @encryptedText VARBINARY(MAX), 
  @clearText VARBINARY(MAX) OUT
WITH EXECUTE AS OWNER
AS 
BEGIN
  BEGIN TRY
    OPEN SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey] 
      DECRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];

    SET @clearText = DECRYPTBYKEY (@encryptedText);
    CLOSE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
  END TRY
  BEGIN CATCH
    SET @clearText = NULL;
    CLOSE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
    RETURN -1;
  END CATCH
  
  RETURN 0;
END
