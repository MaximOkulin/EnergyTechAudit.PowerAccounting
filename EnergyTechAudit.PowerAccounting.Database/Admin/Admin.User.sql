CREATE TABLE [Admin].[User]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[RoleId] INT NOT NULL,   
  [UserGroupId]  INT NULL, 
	[UserName] NVARCHAR(32) NOT NULL, 
  [Email] NVARCHAR(128) NOT NULL, 	
  [Password] NVARCHAR(64) NOT NULL, 
  [EncryptedPassword] VARBINARY(1024) NULL, 
  [CreateDate] DATETIME NOT NULL , 
	[ExpiredDate] DATETIME NOT NULL , 
	[IsTemporary] BIT NOT NULL , 
  [IsApproved] BIT NOT NULL , 
	[IsOnline] BIT NOT NULL DEFAULT 0, 
	[Description] NVARCHAR(64) NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,    
  
  CONSTRAINT PK_Admin_User PRIMARY KEY (Id), 

  CONSTRAINT [FK_Admin_User_RoleId_Admin_Role_Id] FOREIGN KEY ([RoleId]) REFERENCES [Admin].[Role]([Id]),

  CONSTRAINT [FK_Admin_User_UserGroupId_Admin_UserGroup_Id] FOREIGN KEY ([UserGroupId]) REFERENCES [Admin].[UserGroup]([Id]),
	
  CONSTRAINT [UQ_Admin_User_UserName] UNIQUE ([UserName])
)

GO

CREATE NONCLUSTERED INDEX [IX_Admin_User_RoleId] 
   ON [Admin].[User] ([RoleId]);

GO

CREATE NONCLUSTERED INDEX [IX_Admin_User_UserName]
  ON [Admin].[User] ([UserName]);

