-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-03-24
-- Description: Таблица связывает предметные параметры и физические параметры устройства
-- Parameter <-> DeviceParameter, а также добавляет привязку к единице измерения и размерности 
-- ===================================================================================================

CREATE TABLE [Business].[ParameterMapDeviceParameter]
(
    [Id] INT NOT NULL IDENTITY(1, 1),     
    [ParameterId] INT NOT NULL, 
    [PeriodTypeId] INT NOT NULL, 
    [MeasurementUnitId] INT NOT NULL, 
    [DimensionId] INT NOT NULL, 
    [DeviceParameterId] INT NOT NULL,
	[SubsystemTypeId] INT NOT NULL,
	[ParameterDictionaryId] INT NULL,
	[Order] INT NOT NULL,
    
    [ChannelTemplateId] INT NOT NULL, 

	/* в процессе постдеплоя NULL данной группы столбцов будет отменен */
	[CreatedBy]  NVARCHAR(32) NULL,
	[UpdatedBy]  NVARCHAR(32) NULL,
	[CreatedDate] DATETIME NULL,
	[UpdatedDate] DATETIME NULL,
    /**/

    CONSTRAINT [PK_Business_ParameterLinkDeviceParameter_Id] PRIMARY KEY ([Id]),

    CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_ParameterId] 
      FOREIGN KEY ([ParameterId]) REFERENCES [Dictionaries].[Parameter] ([Id]),

    CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_PeriodTypeId] 
      FOREIGN KEY ([PeriodTypeId]) REFERENCES [Dictionaries].[PeriodType] ([Id]),

    CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_MeasurementUnitId] 
      FOREIGN KEY ([MeasurementUnitId]) REFERENCES [Dictionaries].[MeasurementUnit] ([Id]),

    CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_DimensionId] 
      FOREIGN KEY ([DimensionId]) REFERENCES [Dictionaries].[Dimension] ([Id]),

	CONSTRAINT [FK_Business_ParameterMapDeviceParameter_ParameterDictionaryId_Dictionaries_ParameterDictionary_Id]
	  FOREIGN KEY ([ParameterDictionaryId]) REFERENCES [Dictionaries].[ParameterDictionary]([Id]),

    CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_DeviceParameterId] 
      FOREIGN KEY ([DeviceParameterId]) REFERENCES [Dictionaries].[DeviceParameter] ([Id]),

    CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_SubsystemTypeId]
	  FOREIGN KEY ([SubsystemTypeId]) REFERENCES [Dictionaries].[SubsystemType] ([Id]),

   CONSTRAINT [FK_Business_ParameterLinkDeviceParameter_ChannelTemplateId] 
      FOREIGN KEY ([ChannelTemplateId]) REFERENCES [Business].[ChannelTemplate] ([Id]) 
      ON DELETE CASCADE,

   CONSTRAINT [UQ_Business_ParameterLinkDeviceParameter_ParameterId_PeriodTypeId_DeviceParameterId_ChannelTemplateId]  
      UNIQUE ([ParameterId], [PeriodTypeId], [DeviceParameterId], [ChannelTemplateId])
)
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_ParameterId] 
  ON [Business].[ParameterMapDeviceParameter] ([ParameterId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_PeriodTypeId] 
  ON [Business].[ParameterMapDeviceParameter] ([PeriodTypeId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_PeriodTypeId2] 
  ON [Business].[ParameterMapDeviceParameter] ([PeriodTypeId])
  INCLUDE([ChannelTemplateId], [DeviceParameterId], [DimensionId], [MeasurementUnitId], [ParameterId])
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_MeasurementUnitId] 
  ON [Business].[ParameterMapDeviceParameter] ([MeasurementUnitId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_DimensionId] ON 
[Business].[ParameterMapDeviceParameter] ([DimensionId]) 
INCLUDE 
(
	[ParameterId], 
	[PeriodTypeId], 
	[MeasurementUnitId], 
	[DeviceParameterId], 
	[ParameterDictionaryId], 
	[ChannelTemplateId]
)
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_DeviceParameterId] 
  ON [Business].[ParameterMapDeviceParameter] ([DeviceParameterId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_SubsystemTypeId]
  ON [Business].[ParameterMapDeviceParameter] ([SubsystemTypeId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_ParameterDictionaryId]
  ON [Business].[ParameterMapDeviceParameter] ([ParameterDictionaryId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_ChannelTemplateId] 
  ON [Business].[ParameterMapDeviceParameter] ([ChannelTemplateId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ParameterMapDeviceParameter_Order] 
  ON [Business].[ParameterMapDeviceParameter] ([Order]) INCLUDE([Id], [ParameterId], [MeasurementUnitId], [DimensionId], [DeviceParameterId]);
GO

/*

*/