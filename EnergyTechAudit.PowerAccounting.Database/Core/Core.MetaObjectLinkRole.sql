-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20141010
-- Description: Указывает, что метаобъект связан с конкретной ролью
-- ===================================================================================================

CREATE TABLE [Core].[MetaObjectLinkRole]
(
	[MetaObjectId] INT NOT NULL, 
   [RoleId] INT NOT NULL,
	CONSTRAINT PK_Core_MetaObjectLinkRole PRIMARY KEY([MetaObjectId], [RoleId]),

	CONSTRAINT [FK_Core_MetaObjectLinkRole_MetaObjectId_Core_MetaObject_Id] FOREIGN KEY ([MetaObjectId]) REFERENCES [Core].[MetaObject]([Id]),

	CONSTRAINT [FK_Core_MetaObjectLinkRole_RoleId_Admin_Role_Id] FOREIGN KEY ([RoleId]) REFERENCES [Admin].[Role]([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObjectLinkRole_MetaObjectId] 
   ON [Core].[MetaObjectLinkRole] ([MetaObjectId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObjectLinkRole_RoleId] 
   ON [Core].[MetaObjectLinkRole] ([RoleId]);