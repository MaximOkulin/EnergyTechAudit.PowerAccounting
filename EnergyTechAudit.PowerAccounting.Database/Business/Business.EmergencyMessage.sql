CREATE TABLE [Business].[EmergencyMessage]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Time] DATETIME NOT NULL,
	[NotificationTypeId] INT NOT NULL,
	[UserAdditionalInfoId] INT NOT NULL,
	[Text] NVARCHAR(MAX) NULL,
	[EmergencyLogId] INT NOT NULL,

	CONSTRAINT [PK_Business_EmergencyMessage] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_EmergencyMessage_NotificationTypeId_Dictionaries_NotificationType_Id] FOREIGN KEY ([NotificationTypeId]) REFERENCES [Dictionaries].[NotificationType]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_EmergencyMessage_UserAdditionalInfoId_Business_UserAdditionalInfo_Id] FOREIGN KEY ([UserAdditionalInfoId]) REFERENCES [Business].[UserAdditionalInfo]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_EmergencyMessage_EmergencyLogId_Business_EmergencyLog_Id] FOREIGN KEY ([EmergencyLogId]) REFERENCES [Business].[EmergencyLog]([Id]) ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_EmergencyMessage_NotificationTypeId]
     ON [Business].[EmergencyMessage]([NotificationTypeId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_EmergencyMessage_UserAdditionalInfoId]
     ON [Business].[EmergencyMessage]([UserAdditionalInfoId]);
GO

CREATE NONCLUSTERED INDEX [IX_Busines_EmergencyMessage_EmergencyLogId]
   ON [Business].[EmergencyMessage]([EmergencyLogId]);
GO

CREATE INDEX [IX_Busines_EmergencyMessage_NotificationTypeId_UserAdditionalInfoId_Time] 
ON [Business].[EmergencyMessage] 
(
  [NotificationTypeId], [UserAdditionalInfoId], [Time]
) 
INCLUDE 
(
  [Id], [Text], [EmergencyLogId]
)
GO
CREATE INDEX [IX_Busines_EmergencyMessage_Time] 
ON [Business].[EmergencyMessage] ([Time])

GO