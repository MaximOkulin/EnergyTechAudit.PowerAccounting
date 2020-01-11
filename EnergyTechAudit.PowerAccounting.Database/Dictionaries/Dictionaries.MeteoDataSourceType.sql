CREATE TABLE [Dictionaries].[MeteoDataSourceType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[Settings] NVARCHAR(MAX) NULL,
	[IsUse] BIT NOT NULL,

	CONSTRAINT [PK_Dictionaries_MeteoDataSourceType] PRIMARY KEY ([Id])
)
