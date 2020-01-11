CREATE TABLE [Business].[RegulatorParameterValue]
(
	[Id] INT NOT NULL IDENTITY(1, 1),
	[MeasurementDeviceId] INT NOT NULL,	
	[DeviceParameterId] INT NOT NULL,
	
	[DeviceValue] DECIMAL(9, 3) NOT NULL,
	[UserValue] DECIMAL(9, 3) NOT NULL,
	[SyncDeviceTime] DATETIME NOT NULL,
	[UpdateUserValueTime] DATETIME NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	CONSTRAINT PK_Business_RegulatorParameterValue PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_RegulatorParameterValue_MeasurementDeviceId_Business_MeasurementDevice_Id] FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id])  ON DELETE CASCADE,	
	CONSTRAINT [FK_Business_RegulatorParameterValue_DeviceParameterId_Dictionaries_DeviceParameter_Id] FOREIGN KEY ([DeviceParameterId]) REFERENCES [Dictionaries].[DeviceParameter]([Id]),	
);

GO

CREATE NONCLUSTERED INDEX [IX_Business_RegulatorParameterValue_MeasurementDeviceId]
     ON [Business].[RegulatorParameterValue] ([MeasurementDeviceId]);
GO

CREATE INDEX [IX_Business_RegulatorParameterValue_DeviceParameterId]
	ON [Business].[RegulatorParameterValue] ([DeviceParameterId])


