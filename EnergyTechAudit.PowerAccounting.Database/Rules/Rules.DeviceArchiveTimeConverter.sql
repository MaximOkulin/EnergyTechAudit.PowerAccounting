CREATE TABLE [Rules].[DeviceArchiveTimeConverter]
(
	[Id] INT NOT NULL IDENTITY(1, 1),
	[DeviceId] INT NOT NULL,
	[PeriodTypeId] INT NOT NULL,
	[Expression] NVARCHAR(128) NOT NULL,
	[Interval] INT NOT NULL,

	CONSTRAINT [PK_Rules_DeviceArchiveConverter] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Rules_DeviceArchiveTimeConverter_DeviceId_Dictionaries_Device_Id] 
		FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id]),
	CONSTRAINT [FK_Rules_DeviceArchiveTimeConverter_PeriodTypeId_Dictionaries_PeriodType_Id] 
		FOREIGN KEY ([PeriodTypeId]) REFERENCES [Dictionaries].[PeriodType]([Id]),
	CONSTRAINT [UQ_Rules_DeviceArchiveTimeConverter_DeviceId_PeriodTypeId]
	     UNIQUE ([DeviceId], [PeriodTypeId])
)
GO

CREATE NONCLUSTERED INDEX [IX_Rules_DeviceArchiveTimeConverter_DeviceId]
   ON [Rules].[DeviceArchiveTimeConverter] ([DeviceId])
GO

CREATE NONCLUSTERED INDEX [IX_Rules_DeviceArchiveTimeConverter_PeriodTypeId]
   ON [Rules].[DeviceArchiveTimeConverter] ([PeriodTypeId])
GO

