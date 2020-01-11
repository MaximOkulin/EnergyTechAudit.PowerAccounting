CREATE TABLE [Core].[EntityProperty]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[EntityId] INT NOT NULL,
	[PropertyName] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,

	CONSTRAINT PK_Core_EntityProperty PRIMARY KEY([Id]),
	CONSTRAINT FK_Core_EntityPropery_EntityId_Core_Entity_Id FOREIGN KEY ([EntityId]) REFERENCES [Core].[Entity]([Id])
)
