CREATE TABLE [Business].[DeviceReaderErrorLog]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Time] DATETIME NOT NULL,
	[Exception] NVARCHAR(64) NULL,
	[Message] NVARCHAR(MAX) NULL,
	[StackTrace] NVARCHAR(MAX) NULL,
	[Text] NVARCHAR(MAX) NULL,
	[DeviceReaderId] INT NULL,
	[MeasurementDeviceId] INT NULL,
	[ErrorTypeId] INT NULL,

	CONSTRAINT PK_Business_DeviceReaderErrorLog PRIMARY KEY (Id),
  
    CONSTRAINT [FK_Business_DeviceReaderErrorLog_DeviceReaderId_Business_DeviceReader_Id]
      FOREIGN KEY ([DeviceReaderId]) REFERENCES [Business].[DeviceReader]([Id]) ON DELETE CASCADE,

	CONSTRAINT FK_Business_DeviceReaderErrorLog_MeasurementDeviceId_Business_MeasurementDevice_Id 
      FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,
	  
	CONSTRAINT [FK_Business_DeviceReaderErrorLog_ErrorTypeId_Dictionaries_ErrorType_Id]
	  FOREIGN KEY ([ErrorTypeId]) REFERENCES [Dictionaries].[ErrorType]([Id])
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceReaderErrorLog_MeasurementDeviceId]
  ON [Business].[DeviceReaderErrorLog] ([MeasurementDeviceId])
  INCLUDE ([Id]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceReaderErrorLog_DeviceReaderId]
  ON [Business].[DeviceReaderErrorLog] ([DeviceReaderId])
  INCLUDE ([Id]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceReaderErrorLog_ErrorTypeId]
  ON [Business].[DeviceReaderErrorLog] ([ErrorTypeId])
  INCLUDE ([Id]);

GO
CREATE INDEX [IX_Business_DeviceReaderErrorLog_Time] 
	ON [Business].[DeviceReaderErrorLog] ([Time])

GO
CREATE INDEX [IX_Business_DeviceReaderErrorLog_MeasurementDeviceId_Time] 
	ON [Business].[DeviceReaderErrorLog] ([MeasurementDeviceId], [Time]) 
	INCLUDE ([Exception], [Message], [StackTrace], [Text], [DeviceReaderId], [ErrorTypeId])