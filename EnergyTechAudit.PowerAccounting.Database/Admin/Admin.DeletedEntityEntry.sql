CREATE TABLE [Admin].[DeletedEntityLogEntry]
(
	[Id] INT IDENTITY(1,1), 
	[EntityId] INT NOT NULL,
	[EntityDescription] NVARCHAR(256) NULL,
	[EntityTypeName] NVARCHAR(64) NOT NULL, 
	[EntityTypeDescription] NVARCHAR(256) NOT NULL,   
	[CascadeDeletedEntities] NVARCHAR(MAX),
	[User] NVARCHAR(32) NOT NULL, 
	[DateTime] DATETIME NOT NULL,   
  CONSTRAINT [PK_Admin_DeletedEntityEntry_Id] PRIMARY KEY (Id)	
);

GO

CREATE INDEX [IX_Admin_DeletedEntityLogEntry_EntityTypeName] 
ON [Admin].[DeletedEntityLogEntry] 
(
	[EntityTypeName]
);

GO

CREATE INDEX [IX_Admin_DeletedEntityLogEntry_DateTime] 
ON [Admin].[DeletedEntityLogEntry] 
(
  [DateTime]
) INCLUDE 
(
  [Id], 
  [EntityId], 
  [EntityDescription], 
  [EntityTypeName], 
  [EntityTypeDescription], 
  [User]
);
GO