CREATE TABLE [Admin].[UserGroup]
(
  [Id] INT NOT NULL IDENTITY(1,1),
  [Description] NVARCHAR(128) NOT NULL,
  [ProductLogoPlaceholder] NVARCHAR(MAX),
  [ProductCard] NVARCHAR(MAX),
  
  [CustomData] NVARCHAR(MAX),

  [CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,    

  CONSTRAINT [PK_Admin_UserGroup_Id] PRIMARY KEY ([Id])
)
