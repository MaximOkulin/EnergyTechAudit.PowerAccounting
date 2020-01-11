
CREATE TABLE [Admin].[NewsLinkRole]
(
  [NewsId] INT NOT NULL, 
  [RoleId] INT NOT NULL
  CONSTRAINT PK_Admin_NewsLinkRole PRIMARY KEY (NewsId, RoleId),
	CONSTRAINT [FK_Admin_NewsLinkRole_NewsId_Admin_News_Id] FOREIGN KEY ([NewsId]) REFERENCES [Admin].[News]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Admin_NewsLinkRole_RoleId_Admin_Role_Id] FOREIGN KEY ([RoleId]) REFERENCES [Admin].[Role]([Id])
);
