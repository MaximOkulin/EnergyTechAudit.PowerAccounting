CREATE TABLE [Core].[MetaObjectType]
(
	[Id] INT NOT NULL IDENTITY (1,1), 
   [Code] NVARCHAR(16) NOT NULL, 
   [Description] NVARCHAR(64) NOT NULL,
	CONSTRAINT [PK_Core_MetaObjectType_Id] PRIMARY KEY ([Id])
);
