CREATE TABLE [Core].[MapInfoWindow]
(
	[Id] INT NOT NULL IDENTITY (1,1),
	[Code] NVARCHAR(64)  NOT NULL,
	[Description] NVARCHAR(128),    
   [Template] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT [PK_Core_MapInfoWindow] PRIMARY KEY ([Id])
);
