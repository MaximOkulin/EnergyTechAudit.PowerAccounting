CREATE TABLE [Business].[UserAdditionalInfoLinkScheduleItem]
(
	[UserAdditionalInfoId] INT NOT NULL,
	[ScheduleItemId] INT NOT NULL,

	CONSTRAINT [PK_Business_UserAdditionalInfoLinkScheduleItem_UserAdditionalInfoId_ScheduleItemId]
	    PRIMARY KEY ([UserAdditionalInfoId], [ScheduleItemId]),

    CONSTRAINT [FK_Business_UserAdditionalInfoLinkScheduleItem_UserAdditionalInfoId_Business_UserAdditionalInfo_Id]
	    FOREIGN KEY ([UserAdditionalInfoId]) REFERENCES [Business].[UserAdditionalInfo]([Id]) ON DELETE CASCADE,

    CONSTRAINT [FK_Business_UserAdditionalInfoLinkScheduleItem_ScheduleItemId_Core_ScheduleItem_Id]
	    FOREIGN KEY ([ScheduleItemId]) REFERENCES [Core].[ScheduleItem]([Id]) ON DELETE CASCADE
)
