CREATE PROCEDURE [Programmability].[EncryptData]
  @clearText VARBINARY(MAX), 
  @encryptedText VARBINARY(MAX) OUT
WITH EXECUTE AS OWNER
AS 
BEGIN
  BEGIN TRY
    OPEN SYMMETRIC KEY  [EnergyTechAudit.PowerAccounting.Database.SymmetricKey] 
      DECRYPTION BY CERTIFICATE [EnergyTechAudit.PowerAccounting.Database.Certificate];

    SET @encryptedText = ENCRYPTBYKEY(KEY_GUID(N'[EnergyTechAudit.PowerAccounting.Database.SymmetricKey]'), @clearText);

    CLOSE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
  END TRY
  BEGIN CATCH
    SET @encryptedText = NULL;
    CLOSE SYMMETRIC KEY [EnergyTechAudit.PowerAccounting.Database.SymmetricKey];
    RETURN -1;
  END CATCH
  
  RETURN 0;
END
