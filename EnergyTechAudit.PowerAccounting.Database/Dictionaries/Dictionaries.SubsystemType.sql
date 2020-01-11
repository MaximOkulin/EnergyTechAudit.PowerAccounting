CREATE TABLE [Dictionaries].[SubsystemType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,

	CONSTRAINT PK_Dictionaries_SubsystemType PRIMARY KEY ([Id])
)
