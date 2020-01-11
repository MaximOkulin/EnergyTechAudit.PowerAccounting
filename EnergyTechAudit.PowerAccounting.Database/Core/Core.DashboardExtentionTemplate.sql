CREATE TABLE [Core].[DashboardExtentionTemplate]
(
	[Id] INT NOT NULL IDENTITY, 
	[Code] NVARCHAR(64) NOT NULL,    
	[Description] NVARCHAR(128) NULL, 		
	[PredicateExpression] NVARCHAR(MAX) NULL,
	[Template] XML NOT NULL,
	CONSTRAINT [PK_Core_DashboardExtentionTemplate_Id] PRIMARY KEY ([Id]),	
);
GO
