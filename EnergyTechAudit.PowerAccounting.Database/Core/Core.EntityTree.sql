CREATE TABLE [Core].[EntityTree]
(
	[Id] INT NOT NULL IDENTITY, 
	[Code] NVARCHAR(64) NOT NULL,    
   [Description] NVARCHAR(128) NULL, 	
   [Template] XML NOT NULL,
   CONSTRAINT [PK_Core_EntityTree] PRIMARY KEY ([Id]),	
);
GO
CREATE NONCLUSTERED INDEX [IX_Core_EntityTree_Code] 
   ON [Core].[EntityTree] ([Code]);
