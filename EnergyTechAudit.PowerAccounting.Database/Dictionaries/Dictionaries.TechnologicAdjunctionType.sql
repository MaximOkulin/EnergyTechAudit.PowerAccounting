CREATE TABLE [Dictionaries].[TechnologicAdjunctionType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(64) NOT NULL,

	CONSTRAINT [PK_Dictionaries_TechnologicAdjunctionType] PRIMARY KEY ([Id])
)
