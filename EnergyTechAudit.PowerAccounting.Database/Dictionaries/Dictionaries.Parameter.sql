CREATE TABLE [Dictionaries].[Parameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[PhysicalParameterId] INT NOT NULL,
	[ResourceSystemTypeId] INT NOT NULL,
	[ShortDescription] NVARCHAR(32) NULL,
	[IntegrableValue] BIT NOT NULL,

	CONSTRAINT PK_Dictionaries_Parameter PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Dictionaries_Parameter_PhysicalParameterId_Dictionaries_PhysicalParameter_Id] FOREIGN KEY ([PhysicalParameterId]) REFERENCES [Dictionaries].[PhysicalParameter]([Id]),
	CONSTRAINT [FK_Dictionaries_Parameter_ResourceSystemTypeId_Dictionaries_SystemType_Id] FOREIGN KEY ([ResourceSystemTypeId]) REFERENCES [Dictionaries].[ResourceSystemType]([Id]),
	
	INDEX [IX_Dictionaries_Parameter_Code] NONCLUSTERED ([Code]) 
);
GO

ALTER TABLE [Dictionaries].[Parameter] 
  ADD CONSTRAINT [DF_Dictionaries_Parameter_IntegrableValue] DEFAULT 0 FOR [IntegrableValue];

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_Parameter_PhysicalParameterId] 
   ON [Dictionaries].[Parameter] ([PhysicalParameterId]);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_Parameter_ResourceSystemTypeId] 
   ON [Dictionaries].[Parameter] ([ResourceSystemTypeId]);