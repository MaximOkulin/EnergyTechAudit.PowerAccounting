CREATE TABLE [Dictionaries].[AgreementSystemParameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(64) NOT NULL,
	[PhysicalParameterId] INT NOT NULL,
	[ResourceSystemTypeId] INT NOT NULL,

	CONSTRAINT PK_Dictionaries_AgreementSystemParameter PRIMARY KEY (Id),
	CONSTRAINT [FK_Dictionaries_AgreementSystemParameter_PhysicalParameterId_Dictionaries_PhysicalParameter_Id] FOREIGN KEY ([PhysicalParameterId]) REFERENCES [Dictionaries].[PhysicalParameter]([Id]),
	CONSTRAINT [FK_Dictionaries_AgreementSystemParameter_ResourceSystemTypeId_Dictionaries_SystemType_Id] FOREIGN KEY ([ResourceSystemTypeId]) REFERENCES [Dictionaries].[ResourceSystemType]([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_AgreementSystemParameter_PhysicalParameterId] 
   ON [Dictionaries].[AgreementSystemParameter] ([PhysicalParameterId]);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_AgreementSystemParameter_ResourceSystemTypeId] 
   ON [Dictionaries].[AgreementSystemParameter] ([ResourceSystemTypeId]);