﻿CREATE TABLE [Core].[Source]
(
	[Id] INT NOT NULL IDENTITY, 
	[Code] NVARCHAR(32) NULL,
	[Description] NVARCHAR(128) NULL,
   [Template] NVARCHAR(MAX) NOT NULL
	CONSTRAINT [PK_Core_Source] PRIMARY KEY ([Id])
);
