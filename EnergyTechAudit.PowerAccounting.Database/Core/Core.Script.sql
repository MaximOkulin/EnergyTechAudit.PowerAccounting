CREATE TABLE [Core].[Script]
(
	[Id] INT NOT NULL IDENTITY(1,1), 
	[Code] NVARCHAR(64) NULL,
	[Description] NVARCHAR(128) NULL,
    [Language] NVARCHAR(32) NOT NULL,
    [Template] NVARCHAR(MAX) NOT NULL
	CONSTRAINT [PK_Core_Script_Id] PRIMARY KEY ([Id])
);
