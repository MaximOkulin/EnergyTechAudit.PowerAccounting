CREATE TABLE [Business].[MeasurementDeviceLinkScheduleItem]
(
	[MeasurementDeviceId] INT NOT NULL,
	[ScheduleItemId] INT NOT NULL,

	CONSTRAINT [PK_Business_MeasurementDeviceLinkScheduleItem_MeasurementDeviceId_ScheduleItemId]
		PRIMARY KEY ([MeasurementDeviceId],[ScheduleItemId]),
	
	CONSTRAINT [FK_Business_MeasurementDeviceLinkScheduleItem_MeasurementDeviceId_Business_MeasurementDevice_Id]
		FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,

	CONSTRAINT [FK_Business_MeasurementDeviceLinkScheduleItem_ScheduleItemId_Core_ScheduleItem_Id]
		FOREIGN KEY ([ScheduleItemId]) REFERENCES [Core].[ScheduleItem]([Id]) ON DELETE CASCADE
)
