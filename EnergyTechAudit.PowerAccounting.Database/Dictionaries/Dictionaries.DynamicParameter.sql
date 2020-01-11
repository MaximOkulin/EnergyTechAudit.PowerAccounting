CREATE TABLE [Dictionaries].[DynamicParameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NULL,
	[Description] NVARCHAR(64) NULL,
	[EntityTypeName] NVARCHAR(32) NOT NULL,
	[Type] NVARCHAR(32) NOT NULL,
	[IsDefault] BIT NOT NULL,
	[DefaultValue] NVARCHAR(MAX) NULL,
	[IsReadOnly] BIT NOT NULL,
	[Descriptor] NVARCHAR(MAX),

	CONSTRAINT [PK_Dictionaries_DynamicParameter] PRIMARY KEY ([Id])
);

GO

ALTER TABLE [Dictionaries].[DynamicParameter]
   ADD CONSTRAINT [DF_Dictionaries_DynamicParameter_EntityTypeName] DEFAULT 'MeasurementDevice' FOR [EntityTypeName];
GO

ALTER TABLE [Dictionaries].[DynamicParameter]
  ADD CONSTRAINT [DF_Dictionaries_DynamicParameter_Type] DEFAULT 'System.String' FOR [Type];
GO

ALTER TABLE [Dictionaries].[DynamicParameter]
  ADD CONSTRAINT [DF_Dictionaries_DynamicParameter_IsDefault] DEFAULT 0 FOR [IsDefault];
GO

ALTER TABLE [Dictionaries].[DynamicParameter]
  ADD CONSTRAINT [DF_Dictionaries_DynamicParameter_IsReadOnly] DEFAULT 1 FOR [IsReadOnly];
GO



