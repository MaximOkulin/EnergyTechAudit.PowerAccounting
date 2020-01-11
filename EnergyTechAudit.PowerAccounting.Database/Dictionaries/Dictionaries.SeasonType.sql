CREATE TABLE [Dictionaries].[SeasonType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,

	CONSTRAINT [PK_Dictionaries_SeasonType] PRIMARY KEY ([Id])
)
