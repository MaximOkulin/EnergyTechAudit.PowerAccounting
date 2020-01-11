CREATE TABLE [Business].[UserLinkEmergencyNotificationType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[EmergencySituationParameterId] INT NOT NULL,
	[UserAdditionalInfoId] INT NOT NULL,
	[NotificationTypeId] INT NOT NULL,
	[RepetitionMinutes] INT NOT NULL,

	CONSTRAINT [PK_Business_UserLinkEmergencyNotificationType] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_UserLinkEmergencyNotificationType_EmergencySituationParameterId_Business_EmergencySituationParameter_Id] FOREIGN KEY ([EmergencySituationParameterId]) REFERENCES [Business].[EmergencySituationParameter]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_UserLinkEmergencyNotificationType_UserAdditionalInfoId_Business_UserAdditionalInfo_Id] FOREIGN KEY ([UserAdditionalInfoId]) REFERENCES [Business].[UserAdditionalInfo]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_UserLinkEmergencyNotificationType_NotificationTypeId_Dictionaries_NotificationType_Id] FOREIGN KEY ([NotificationTypeId]) REFERENCES [Dictionaries].[NotificationType]([Id]) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_UserLinkEmergencyNotificationType_EmergencySituationParameterId]
   ON [Business].[UserLinkEmergencyNotificationType] ([EmergencySituationParameterId]);
GO

/*На основе статистики добавлена секция покрытия */
CREATE NONCLUSTERED INDEX [IX_Business_UserLinkEmergencyNotificationType_UserAdditionalInfoId]
   ON [Business].[UserLinkEmergencyNotificationType] ([UserAdditionalInfoId])
  INCLUDE ([Id], [EmergencySituationParameterId], [NotificationTypeId], [RepetitionMinutes])
GO

CREATE NONCLUSTERED INDEX [IX_Business_UserLinkEmergencyNotificationType_NotificationTypeId]
   ON [Business].[UserLinkEmergencyNotificationType] ([NotificationTypeId]);
GO

CREATE INDEX [IX_Business_UserLinkEmergencyNotificationType_UserAdditionalInfoId_NotificationTypeId] 
  ON [Business].[UserLinkEmergencyNotificationType] ([UserAdditionalInfoId], [NotificationTypeId]) 
INCLUDE ([Id], [EmergencySituationParameterId], [RepetitionMinutes])