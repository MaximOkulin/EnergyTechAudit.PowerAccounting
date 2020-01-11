CREATE TABLE [Business].[DeviceReaderLinkScheduleItem]
(
	[DeviceReaderId] INT NOT NULL,
	[ScheduleItemId] INT NOT NULL,

	CONSTRAINT [PK_Business_DeviceReaderLinkScheduleItem_DeviceReaderId_ScheduleItemId]
	  PRIMARY KEY ([DeviceReaderId],[ScheduleItemId]),

    CONSTRAINT [FK_Business_DeviceReaderLinkScheduleItem_DeviceReaderId_Business_DeviceReader_Id]
	  FOREIGN KEY ([DeviceReaderId]) REFERENCES [Business].[DeviceReader]([Id]) ON DELETE CASCADE,

	CONSTRAINT [FK_Business_DeviceReaderLinkScheduleItem_Core_ScheduleItem_Id]
	  FOREIGN KEY ([ScheduleItemId]) REFERENCES [Core].[ScheduleItem]([Id]) ON DELETE CASCADE
)
