CREATE TABLE [Dictionaries].[TypeConnection]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128),
	CONSTRAINT [PK_TypeConnection] PRIMARY KEY ([Id])
);
