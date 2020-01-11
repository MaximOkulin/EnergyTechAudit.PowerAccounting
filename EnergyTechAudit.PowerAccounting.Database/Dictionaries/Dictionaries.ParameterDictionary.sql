CREATE TABLE [Dictionaries].[ParameterDictionary]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128),

	CONSTRAINT [PK_Dictionaries_ParameterDictionary] PRIMARY KEY ([Id])
)
