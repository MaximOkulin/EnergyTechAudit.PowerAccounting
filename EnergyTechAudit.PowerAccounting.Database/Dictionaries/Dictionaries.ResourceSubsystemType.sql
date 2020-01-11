CREATE TABLE [Dictionaries].[ResourceSubsystemType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[ResourceSystemTypeId] INT NOT NULL,
	[ShortName] NVARCHAR(16) NULL,

	CONSTRAINT [PK_Dictionaries_ResourceSubsystemType] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Dictionaries_ResourceSubsystemType_ResourceSystemTypeId_Dictionaries_ResourceSystemType_Id] FOREIGN KEY ([ResourceSystemTypeId]) REFERENCES [Dictionaries].[ResourceSystemType]([Id])
);
GO

CREATE NONCLUSTERED INDEX [IX_Dictionaries_ResourceSubsystemType_ResourceSystemTypeId]
  ON [Dictionaries].[ResourceSubsystemType] ([ResourceSystemTypeId]);
