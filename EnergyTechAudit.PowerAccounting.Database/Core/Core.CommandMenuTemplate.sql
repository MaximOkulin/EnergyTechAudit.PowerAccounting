CREATE TABLE [Core].[CommandMenuTemplate]
(
	[Id] INT NOT NULL IDENTITY, 
	[Code] NVARCHAR(64) NOT NULL,    
	[Description] NVARCHAR(128) NULL, 		
	[Template] XML NOT NULL,
	CONSTRAINT [PK_Core_CommandMenuTemplate] PRIMARY KEY ([Id]),	
);
GO
