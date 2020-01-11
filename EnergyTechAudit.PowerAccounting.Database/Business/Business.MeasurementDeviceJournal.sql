CREATE TABLE [Business].[MeasurementDeviceJournal]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[MeasurementDeviceId] INT NOT NULL,
	[InternalDeviceEventId] INT NOT NULL,
	[Time] DATETIME NOT NULL,
	[Description] NVARCHAR(128) NULL,
	[OriginalValue] NVARCHAR(128) NULL,
	[CurrentValue] NVARCHAR(128) NULL,

	CONSTRAINT [PK_Business_MeasurementDeviceJournal] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_MeasurementDeviceJournal_MeasurementDeviceId_Business_MeasurementDevice_Id] FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_MeasurementDeviceJournal_InternalDeviceEventId_Dictionaries_InternalDeviceEvent_Id] FOREIGN KEY ([InternalDeviceEventId]) REFERENCES [Dictionaries].[InternalDeviceEvent]([Id]),
	CONSTRAINT [UQ_Business_MeasurementDeviceJournal_MeasurementDeviceId_InternalDeviceEventId_Time_OriginalValue_CurrentValue] UNIQUE ([MeasurementDeviceId],[InternalDeviceEventId],[Time],[OriginalValue],[CurrentValue])
);

GO

CREATE NONCLUSTERED INDEX [IX_Business_MeasurementDeviceJournal_MeasurementDeviceId]
   ON [Business].[MeasurementDeviceJournal] ([MeasurementDeviceId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_MeasurementDeviceJournal_InternalDeviceEventId]
   ON [Business].[MeasurementDeviceJournal] ([InternalDeviceEventId]);

