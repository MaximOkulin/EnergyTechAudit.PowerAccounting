CREATE TABLE [Business].[IntegrationArchiveInfo]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[MeasurementDeviceId] INT NOT NULL,
	[PeriodTypeId] INT NOT NULL,
	[LastCalculatedDate] DATETIME NULL,
	[CurrentArchiveDate] DATETIME NULL,
	[DiffDeviceParameterId] INT NOT NULL,

	CONSTRAINT [PK_Business_IntergrationArchiveInfo] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_IntegrationArchiveInfo_MeasurementDeviceId_Business_MeasurementDevice_Id] 
	   FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Business_IntegrationArchiveInfo_PeriodTypeId_Dictionaries_PeriodType_Id]
	   FOREIGN KEY ([PeriodTypeId]) REFERENCES [Dictionaries].[PeriodType]([Id]),
    CONSTRAINT [FK_Business_IntegrationArchiveInfo_DiffDeviceParameterId_Dictionaries_DeviceParameter_Id]
	  FOREIGN KEY ([DiffDeviceParameterId]) REFERENCES [Dictionaries].[DeviceParameter]([Id])
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_IntegrationArchiveInfo_MeasurementDeviceId]
     ON [Business].[IntegrationArchiveInfo]([MeasurementDeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_IntegrationArchiveInfo_PeriodTypeId]
    ON [Business].[IntegrationArchiveInfo]([PeriodTypeId])
GO

CREATE NONCLUSTERED INDEX [IX_Business_IntegrationArchiveInfo_DiffDeviceParameterId]
    ON [Business].[IntegrationArchiveInfo]([DiffDeviceParameterId])
GO
