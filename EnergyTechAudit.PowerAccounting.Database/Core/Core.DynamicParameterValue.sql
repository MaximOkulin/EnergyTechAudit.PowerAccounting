CREATE TABLE [Core].[DynamicParameterValue]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[EntityId] INT NOT NULL,
	[DynamicParameterId] INT NOT NULL,
	[Value] NVARCHAR(MAX) NOT NULL,

	CONSTRAINT [PK_Core_DynamicParameterValue] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Core_DynamicParameterValue_DynamicParameterId_Dictionaries_DynamicParameter_Id] FOREIGN KEY ([DynamicParameterId]) REFERENCES [Dictionaries].[DynamicParameter]([Id]),
	CONSTRAINT [UQ_EntityId_DynamicParameterId] UNIQUE ([EntityId], [DynamicParameterId])
);
GO

CREATE NONCLUSTERED INDEX [IX_Core_DynamicParameterValue_DynamicParameterId]
  ON [Core].[DynamicParameterValue] ([DynamicParameterId]);
GO



