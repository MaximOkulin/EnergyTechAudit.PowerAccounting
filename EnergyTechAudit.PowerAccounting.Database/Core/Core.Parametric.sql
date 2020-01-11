CREATE TABLE [Core].[Parametric]
(
	[Id] INT NOT NULL IDENTITY,
	[Code] NVARCHAR(64) NULL,
	[Description] NVARCHAR(128) NULL, 
	[Template] XML NOT NULL,
	CONSTRAINT [Core_Parametric_Id]  PRIMARY KEY ([Id])      
);
