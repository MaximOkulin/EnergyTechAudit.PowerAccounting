CREATE TABLE [Core].[Query]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64)  NOT NULL,
	[Description] NVARCHAR(128),
    [ExportableOnly] BIT NOT NULL, -- указывает на то, что решетка не поддерживает аналитических операций
    [Template] XML NULL,

    CONSTRAINT [PK_Core_Query] PRIMARY KEY ([Id])	
);

GO
ALTER TABLE [Core].[Query]
  ADD CONSTRAINT [DF_Core_Query_ExportableOnly] DEFAULT 0 FOR [ExportableOnly];
GO