USE [EnergyTechAudit.PowerAccounting.Database]

GO

SET XACT_ABORT  ON;
GO

BEGIN TRANSACTION
BEGIN TRY
  IF EXISTS (SELECT [A].[N]  FROM 
        (SELECT  ROW_NUMBER() OVER
          (PARTITION BY [PeriodTypeId], [Time], [MeasurementDeviceId], [DeviceParameterId] ORDER BY [Id]) [N]  
        FROM [Business].[Archive] [a]) [A] WHERE [A].[N] > 1)
  BEGIN
  	RAISERROR ('Дубликаты в новом ключе уникальности архивной записи!', 16, 1);
  END;
     
  --1. Удаление ограничения уникальности 
  IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Business].[Archive]') 
    AND name = N'UQ_PeriodTypeId_Time_ChannelId_ParameterId_Tariff')
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP CONSTRAINT [UQ_PeriodTypeId_Time_ChannelId_ParameterId_Tariff]
  END;
  
  
  -- 1.1. Удаление индексов
  IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Business].[Archive]') 
    AND name = N'IX_Business_Archive_ChannelId')
  BEGIN
    DROP INDEX [IX_Business_Archive_ChannelId] ON [Business].[Archive]
  END;
  
  
  IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Business].[Archive]') 
    AND name = N'IX_Business_Archive_ForSheet')
  BEGIN
    DROP INDEX [IX_Business_Archive_ForSheet] ON [Business].[Archive]
  END;
  
  
  IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Business].[Archive]') 
    AND name = N'IX_Business_Archive_ParameterId')
  BEGIN
    DROP INDEX IX_Business_Archive_ParameterId ON Business.Archive
  END;  
  
  
  -- 1.2. Удаление внешних ключей
  
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_ChannelId_Business_Channel_Id]') 
    AND parent_object_id = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP CONSTRAINT [FK_Business_Archive_ChannelId_Business_Channel_Id]
  END;
  
  
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_DimensionId_Dictionaries_Dimension_Id]') 
    AND parent_object_id = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP CONSTRAINT [FK_Business_Archive_DimensionId_Dictionaries_Dimension_Id]
  END;
  
  
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_MeasurementUnitId_Dictionaries_MeasurementUnit_Id]') 
    AND parent_object_id = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP CONSTRAINT [FK_Business_Archive_MeasurementUnitId_Dictionaries_MeasurementUnit_Id]
  END;
    
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Business].[FK_Business_Archive_ParameterId_Dictionaries_Parameter_Id]') 
    AND parent_object_id = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP CONSTRAINT [FK_Business_Archive_ParameterId_Dictionaries_Parameter_Id]
  END;
    
  -- 2.Удаление столбцов
  IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[Business].[DF_Business_Archive_Tariff]') AND type = 'D')
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP CONSTRAINT [DF_Business_Archive_Tariff]
  END
  
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'Tariff' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive] 
      DROP COLUMN [Tariff]
  END;
  
  
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'ChannelId' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive]
      DROP COLUMN [ChannelId]
  END;
    
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'ParameterId' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive]
      DROP COLUMN [ParameterId]
  END;
    
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'DimensionId' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive]
      DROP COLUMN [DimensionId]
  END;
    
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'MeasurementUnitId' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive]
      DROP COLUMN [MeasurementUnitId]
  END;
    
  -- 3.включаем ограничение на недопущения NULL
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'MeasurementDeviceId' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive]
      ALTER COLUMN [MeasurementDeviceId] INT NOT NULL
  END;
  
  
  IF EXISTS(SELECT * FROM sys.columns 
          WHERE [name] = N'DeviceParameterId' AND [object_id] = OBJECT_ID(N'[Business].[Archive]'))
  BEGIN
    ALTER TABLE [Business].[Archive]
      ALTER COLUMN [DeviceParameterId] INT NOT NULL
  END;
    
  -- 4.новое ограничение уникальности
  IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[Business].[Archive]') 
    AND name = N'UQ_Business_Archive_PeriodTypeId_Time_MeasurementDeviceId_DeviceParameterId')
  BEGIN
    ALTER TABLE [Business].[Archive]
      ADD CONSTRAINT [UQ_Business_Archive_PeriodTypeId_Time_MeasurementDeviceId_DeviceParameterId] 
      UNIQUE ([PeriodTypeId], [Time], [MeasurementDeviceId], [DeviceParameterId])
  END;
  
  IF(@@trancount > 0)
  BEGIN
     COMMIT TRANSACTION; 
  END;

  IF(@@error = 0)
  BEGIN
    -- 5. жмем базу
    DBCC SHRINKDATABASE ('EnergyTechAudit.PowerAccounting.Database')
  END;
END TRY  
BEGIN CATCH
   IF(@@trancount > 0)
   BEGIN
      ROLLBACK TRANSACTION;
   END;
END CATCH