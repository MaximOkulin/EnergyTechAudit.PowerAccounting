CREATE TABLE [Core].[EntityTreeLinkRole]
(
	[EntityTreeId] INT NOT NULL,
	[RoleId] INT NOT NULL,

	CONSTRAINT PK_Core_EntityTreeLinkRole PRIMARY KEY (EntityTreeId, RoleId),
	CONSTRAINT [FK_Core_EntityTreeLinkRole_EntityTreeId_Core_EntityTree_Id] FOREIGN KEY ([EntityTreeId]) REFERENCES [Core].[EntityTree]([Id]),

	CONSTRAINT [FK_Core_EntityTreeLinkRole_RoleId_Admin_Role_Id] FOREIGN KEY ([RoleId]) REFERENCES [Admin].[Role]([Id])
);

GO

CREATE NONCLUSTERED INDEX [IX_Core_EntityTreeLinkRole_EntityTreeId] 
   ON [Core].[EntityTreeLinkRole] ([EntityTreeId]);
GO

CREATE NONCLUSTERED INDEX [IX_Core_EntityTreeLinkRole_RoleId] 
   ON [Core].[EntityTreeLinkRole] ([RoleId]);
