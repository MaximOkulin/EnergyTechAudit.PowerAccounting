CREATE TABLE [Business].[TimeSignature]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[MeasurementDeviceId] INT NOT NULL,
	[Time] DATETIME NOT NULL,
	[DeviceTime] DATETIME NOT NULL,
	[PollingDuration] INT NOT NULL,
	[StatusConnectionId] INT NOT NULL,

	CONSTRAINT PK_Business_TimeSignature PRIMARY KEY ([Id]),

	CONSTRAINT [FK_Business_TimeSignature_MeasurementDeviceId_Business_MeasurementDevice_Id] 
    FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,

	CONSTRAINT [FK_Business_TimeSignature_StatusConnectionId_Dictionaries_StatusConnection_Id] 
      FOREIGN KEY ([StatusConnectionId]) REFERENCES [Dictionaries].[StatusConnection]([Id])
);
GO

ALTER TABLE [Business].[TimeSignature] 
  ADD CONSTRAINT [DF_Business_TimeSignature_StatusConnectionId] DEFAULT 1 FOR [StatusConnectionId];
GO

CREATE NONCLUSTERED INDEX [IX_Business_TimeSignature_MeasurementDeviceId] 
  ON [Business].[TimeSignature] ([MeasurementDeviceId])
  INCLUDE ([Id],[Time],[DeviceTime],[PollingDuration]);
GO 

CREATE NONCLUSTERED INDEX [IX_Business_TimeSignature_MeasurementDeviceIdTime] 
  ON [Business].[TimeSignature] ([MeasurementDeviceId], [Time]  DESC)
  INCLUDE ([Id])
  WITH (SORT_IN_TEMPDB = OFF, ONLINE = ON) ;
