CREATE TABLE [Business].[DeviceTechnicalParameter]
(
	[Id] INT NOT NULL IDENTITY(1, 1),
	[MeasurementDeviceId] INT NOT NULL,
	[DeviceParameterId] INT NOT NULL,
	[Time] DATETIME NOT NULL,

	[DeviceValue] INT NULL,
	[StringValue] NVARCHAR(256) NULL,

	CONSTRAINT [PK_Business_DeviceTechnicalParameter] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_DeviceTechnicalParameter_MeasurementDeviceId_Business_MeasurementDevice_Id]
	           FOREIGN KEY ([MeasurementDeviceId])
			   REFERENCES [Business].[MeasurementDevice]([Id]),
    CONSTRAINT [FK_Business_DeviceTechnicalParameter_DeviceParameterId_Dictionaries_DeviceParameter_Id]
	           FOREIGN KEY ([DeviceParameterId])
			   REFERENCES [Dictionaries].[DeviceParameter]([Id])
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceTechnicalParameter_MeasurementDeviceId]
            ON [Business].[DeviceTechnicalParameter] ([MeasurementDeviceId]);
GO 

CREATE NONCLUSTERED INDEX [IX_Business_DeviceTechnicalParameter_DeviceParameterId]
            ON [Business].[DeviceTechnicalParameter] ([DeviceParameterId])
