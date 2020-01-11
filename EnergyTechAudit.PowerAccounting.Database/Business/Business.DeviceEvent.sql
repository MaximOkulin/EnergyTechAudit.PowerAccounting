CREATE TABLE [Business].[DeviceEvent]
(
	[Id] BIGINT NOT NULL IDENTITY(1,1),
	[Time] DATETIME NOT NULL, 
	[DeviceEventParameterId] INT NOT NULL,
	[MeasurementDeviceId] INT NOT NULL,
	[State] DECIMAL(19, 7) NOT NULL,	
	
    CONSTRAINT [PK_Business_DeviceEvent] PRIMARY KEY ([Id]),	
    CONSTRAINT [FK_Business_DeviceEvent_DeviceEventParameterId_Dictionaries_DeviceEventParameter_Id] FOREIGN KEY ([DeviceEventParameterId]) REFERENCES [Dictionaries].[DeviceEventParameter]([Id]),
    CONSTRAINT [FK_Business_DeviceEvent_MeasurementDeviceId_Business_MeasurementDevice_Id] FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE
);

GO
CREATE NONCLUSTERED INDEX [IX_Business_DeviceEvent_DeviceEventParameterId] 
   ON [Business].[DeviceEvent] ([DeviceEventParameterId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceEvent_MeasurementDeviceId] 
   ON [Business].[DeviceEvent] ([MeasurementDeviceId])

GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceEvent_MeasurementDeviceId_Time]
  ON [Business].[DeviceEvent] ([MeasurementDeviceId], [Time])
  INCLUDE ([Id], [DeviceEventParameterId], [State])

GO

ALTER TABLE [Business].[DeviceEvent]
   ADD CONSTRAINT [DF_Business_DeviceEvent_State] DEFAULT 0 FOR [State];
GO