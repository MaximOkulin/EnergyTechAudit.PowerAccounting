CREATE TABLE [Core].[Pivot]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64)  NOT NULL,
	[Description] NVARCHAR(128),
	CONSTRAINT [PK_Core_Pivot] PRIMARY KEY ([Id])	
);
