CREATE TABLE [Admin].[EntityHistory]
(
	[Id] INT IDENTITY(1,1), 
	[EntityId] INT NOT NULL,
	[EntityTypeName] NVARCHAR(64) NOT NULL, 
	[EntityTypeDescription] NVARCHAR(256) NOT NULL, 
	[PropertyName] NVARCHAR(64) NOT NULL, 
	[PropertyDescription] NVARCHAR(256) NOT NULL, 
	[OriginalValue] NVARCHAR(MAX) NOT NULL, 
	[CurrentValue] NVARCHAR(MAX) NOT NULL,
	[User] NVARCHAR(32) NOT NULL, 
	[DateTime] DATETIME NOT NULL,   
	CONSTRAINT PK_Admin_EntityHistory PRIMARY KEY (Id)	
);
GO

/* By statistic */
CREATE INDEX [IX_Admin_EntityHistory_EntityTypeName_PropertyName] ON [Admin].[EntityHistory] 
(
  [EntityTypeName],
  [PropertyName]
) 
INCLUDE 
(
  [Id], [DateTime]
);
GO

CREATE INDEX [IX_Admin_EntityHistory_EntityTypeName] 
ON [Admin].[EntityHistory]
(
	[EntityId], [EntityTypeName]
);

GO