CREATE TABLE [Core].[Form]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64)  NOT NULL,
	[Description] NVARCHAR(128),
	[ReadOnly] BIT NOT NULL, 
	[LinkedEntityTypeName] NVARCHAR(64) NOT NULL, 
	[Layout] NVARCHAR(MAX) NOT NULL, 
  
  CONSTRAINT [PK_Core_Form] PRIMARY KEY ([Id])	
);
GO

ALTER TABLE [Core].[Form]
  ADD CONSTRAINT [DF_Core_Form_ReadOnly] DEFAULT 0 FOR [ReadOnly];
GO  