CREATE TABLE [Dictionaries].[ResourceSystemType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[ShortName] NVARCHAR(8) NOT NULL,
	CONSTRAINT PK_Dictionaries_ResourceSystemType PRIMARY KEY(Id)
);
GO

CREATE INDEX [IX_Dictionaries_ResourceSystemType_Code]
ON [Dictionaries].[ResourceSystemType] ([Code]);