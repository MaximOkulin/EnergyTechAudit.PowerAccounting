CREATE TABLE [Core].[GoogleMapsStyle]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128),
	[Template] NVARCHAR(MAX)
	CONSTRAINT [PK_Core_GoogleMapsStyle_Id] PRIMARY KEY ([Id])	
);

