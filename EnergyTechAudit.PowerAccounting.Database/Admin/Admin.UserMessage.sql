CREATE TABLE [Admin].[UserMessage]
(
	[Id] INT NOT NULL IDENTITY(1,1),	  
	[Text] NVARCHAR(1024) NOT NULL,
  [UserId] INT NOT NULL,
  [Date] DATETIME NOT NULL, 

  CONSTRAINT [PK_Admin_UserMessage_Id] PRIMARY KEY ([Id]),
  CONSTRAINT [FK_Admin_UserMessage_UserId_Admin_User_Id] FOREIGN KEY ([UserId]) REFERENCES [Admin].[User]([Id]) ON DELETE CASCADE
);
GO

ALTER TABLE [Admin].[UserMessage]
ADD CONSTRAINT [DF_Admin_UserMessage_Date] DEFAULT GETDATE() FOR [Date];
GO

CREATE NONCLUSTERED INDEX [IX_Admin_UserMessage_UserId] 
   ON [Admin].[UserMessage] ([UserId]);
GO

