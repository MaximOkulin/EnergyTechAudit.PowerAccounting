CREATE TABLE [Business].[MeasurementDeviceStatusConnectionLog]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[ConnectionTime] DATETIME  NOT NULL,
	[MeasurementDeviceId] INT NOT NULL,
	[StatusConnectionId] INT NOT NULL,

	CONSTRAINT PK_Business_MeasurementDeviceStatusConnectionLog PRIMARY KEY ([Id]),
	CONSTRAINT FK_Business_MeasurementDeviceStatusConnectionLog_MeasurementDeviceId_Business_MeasurementDevice_Id FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,
	CONSTRAINT FK_Business_MeasurementDeviceStatusConnectionLog_StatusConnectionId_Dictionaries_StatusConnection_Id FOREIGN KEY ([StatusConnectionId]) REFERENCES [Dictionaries].[StatusConnection]([Id])
)
GO

ALTER TABLE [Business].[MeasurementDeviceStatusConnectionLog]
  ADD CONSTRAINT [DF_Business_MeasurementDeviceStatusConnectionLog_ConnectionTime] 
  DEFAULT '1900-01-01' FOR [ConnectionTime];
GO

ALTER TABLE [Business].[MeasurementDeviceStatusConnectionLog]
  ADD CONSTRAINT [DF_Business_MeasurementDeviceStatusConnectionLog_StatusConnectionId]
  DEFAULT 1 FOR [StatusConnectionId]
GO

CREATE NONCLUSTERED INDEX [IX_Business_StatusConnectionLog_Time] 
   ON [Business].[MeasurementDeviceStatusConnectionLog] ([ConnectionTime] DESC);
GO

CREATE NONCLUSTERED INDEX [IX_Business_StatusConnectionLog_MeasurementDeviceId] 
   ON [Business].[MeasurementDeviceStatusConnectionLog] ([MeasurementDeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_StatusConnectionLog_StatusConnectionId] 
   ON [Business].[MeasurementDeviceStatusConnectionLog] ([StatusConnectionId] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_Business_StatusConnectionLog_MeasurementDeviceCustomInfoListForOperAdmin] 
   ON [Business].[MeasurementDeviceStatusConnectionLog] ([MeasurementDeviceId] ASC, [ConnectionTime] DESC)
   INCLUDE([Id],  [StatusConnectionId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_StatusConnectionLog_MeasurementDeviceCustomInfoListForOperAdmin1] 
   ON [Business].[MeasurementDeviceStatusConnectionLog] ([Id] ASC)
   INCLUDE( [StatusConnectionId]);
GO

GO
CREATE NONCLUSTERED INDEX [IX_Business_StatusConnectionLog_MeasurementDeviceCustomInfoListForOperAdmin2]
ON [Business].[MeasurementDeviceStatusConnectionLog] ([MeasurementDeviceId])
INCLUDE ([Id],[ConnectionTime],[StatusConnectionId])
GO