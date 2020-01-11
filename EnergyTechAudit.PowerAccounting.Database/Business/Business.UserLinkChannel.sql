CREATE TABLE [Business].[UserLinkChannel]
(
  [UserId] INT NOT NULL, 
  [ChannelId] INT NOT NULL,
  
  CONSTRAINT PK_Business_UserLinkChannel PRIMARY KEY (UserId, ChannelId),

	CONSTRAINT [FK_Business_UserLinkChannel_UserId_Admin_User_Id] FOREIGN KEY ([UserId]) REFERENCES [Admin].[User]([Id]) ON DELETE CASCADE,

	CONSTRAINT [FK_Business_UserLinkChannel_ChannelId_Business_Channel_Id] FOREIGN KEY ([ChannelId]) REFERENCES [Business].[Channel]([Id]) ON DELETE CASCADE
)

GO

CREATE NONCLUSTERED INDEX [IX_Business_UserLinkChannel_UserId] 
   ON [Business].[UserLinkChannel] ([UserId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_UserLinkChannel_ChannelId] 
   ON [Business].[UserLinkChannel] ([ChannelId]);