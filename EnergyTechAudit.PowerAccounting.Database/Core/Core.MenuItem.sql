CREATE TABLE [Core].[MenuItem]
(
	[Id] INT NOT NULL IDENTITY,
	[MenuId] INT NOT NULL,
	[MetaObjectId] INT NULL, 
	[Order] INT NOT NULL, 
	[Title] NVARCHAR(64) NULL, 
	[IconClass] NVARCHAR(128) NULL, 
	[Visible] BIT NOT NULL, 

    CONSTRAINT  [PK_Core_MenuItem] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Core_MenuItemId_MenuId_Core_Menu_Id] FOREIGN KEY ([MenuId]) REFERENCES [Core].[Menu] ([Id]),
	CONSTRAINT [FK_Core_MenuItemId_MetaObjectId_Core_MetaObject_Id] FOREIGN KEY ([MetaObjectId]) REFERENCES [Core].[MetaObject] ([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MenuItem_MenuId] 
   ON [Core].[MenuItem] ([MenuId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MenuItem_MetaObjectId] 
   ON [Core].[MenuItem] ([MetaObjectId]);