-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-09-06
-- Description: Восстановление потерянных индексов таблицы [Business].[Archive]
-- ===================================================================================================

USE [EnergyTechAudit.PowerAccounting.Database]
GO

IF (SELECT user_access_desc  FROM sys.databases WHERE name = N'EnergyTechAudit.PowerAccounting.Database') = 'MULTI_USER'
BEGIN
  ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;
END;  
  
IF (@@ERROR <> 0)
BEGIN 
	PRINT ERROR_MESSAGE();
	GOTO ErrorExit;
END;

SET XACT_ABORT  ON;

BEGIN TRANSACTION
BEGIN TRY
  
  -- ===================================================================================================
  PRINT N'Восстановление внешних ключей таблицы [Business].[Archive].';
  
  DECLARE @count INT = 0;
  IF NOT EXISTS 
    (
      SELECT * FROM sys.foreign_keys 
      WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_TimeSignatureId_Business_TimeSignature_Id]')
         AND parent_object_id = OBJECT_ID(N'[Business].[Archive]')
    )
  BEGIN
    ALTER TABLE [Business].[Archive]
    ADD CONSTRAINT [FK_Business_Archive_TimeSignatureId_Business_TimeSignature_Id] 
      FOREIGN KEY ([TimeSignatureId]) REFERENCES [Business].[TimeSignature]([Id]);
      PRINT N'Ключ [FK_Business_Archive_TimeSignatureId_Business_TimeSignature_Id]';
      SET @count = @count + 1;
  END;

  IF NOT EXISTS 
    (
      SELECT * FROM sys.foreign_keys 
      WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_MeasurementDeviceId_Business_MeasurementDevice_Id]')
         AND parent_object_id = OBJECT_ID(N'[Business].[Archive]')
    )
  BEGIN
    ALTER TABLE [Business].[Archive]
      ADD CONSTRAINT [FK_Business_Archive_MeasurementDeviceId_Business_MeasurementDevice_Id] 
        FOREIGN KEY ([MeasurementDeviceId]) 
        REFERENCES [Business].[MeasurementDevice]([Id]) 
        ON DELETE CASCADE;
    PRINT N'Ключ [FK_Business_Archive_MeasurementDeviceId_Business_MeasurementDevice_Id]';
    SET @count = @count + 1;
  END;

  IF NOT EXISTS 
    (
      SELECT * FROM sys.foreign_keys 
      WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_DeviceParameterId_Dictionaries_DeviceParameter_Id]')
         AND parent_object_id = OBJECT_ID(N'[Business].[Archive]')
    )
  BEGIN
    ALTER TABLE [Business].[Archive]
      ADD	CONSTRAINT [FK_Business_Archive_DeviceParameterId_Dictionaries_DeviceParameter_Id] 
        FOREIGN KEY ([DeviceParameterId]) 
        REFERENCES [Dictionaries].[DeviceParameter]([Id]);
    PRINT N'Ключ [FK_Business_Archive_DeviceParameterId_Dictionaries_DeviceParameter_Id]';
    SET @count = @count + 1;
  END;

  IF NOT EXISTS 
    (
      SELECT * FROM sys.foreign_keys 
      WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_PeriodTypeId_Dictionaries_PeriodType_Id]')
         AND parent_object_id = OBJECT_ID(N'[Business].[Archive]')
    )
  BEGIN
    ALTER TABLE [Business].[Archive]
      ADD	CONSTRAINT [FK_Business_Archive_PeriodTypeId_Dictionaries_PeriodType_Id] 
        FOREIGN KEY ([PeriodTypeId]) 
        REFERENCES [Dictionaries].[PeriodType]([Id]);
    PRINT N'Ключ [FK_Business_Archive_PeriodTypeId_Dictionaries_PeriodType_Id]';
    SET @count = @count + 1;
  END;
  -- ===================================================================================================
  
  IF(@@trancount > 0)
  BEGIN
     COMMIT TRANSACTION; 
  END;

  PRINT CONCAT('Всего восстановлено ключей: ', + @count);
END TRY
BEGIN CATCH

  PRINT ERROR_MESSAGE();
  IF(@@trancount > 0)
   BEGIN
      ROLLBACK TRANSACTION;
   END;  
   
END CATCH;

IF (SELECT user_access_desc  FROM sys.databases WHERE name = N'EnergyTechAudit.PowerAccounting.Database') = 'SINGLE_USER'
BEGIN
  ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
  SET MULTI_USER;
END;

GOTO NoErrorExit;

ErrorExit:
	PRINT CONCAT ('Пакет обработки завершился аварийно с ошибкой :"', ERROR_MESSAGE(), '"');

NoErrorExit:
	