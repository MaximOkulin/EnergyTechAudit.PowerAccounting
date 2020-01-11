CREATE TABLE [Core].[Entity]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NULL,
	[Schema] NVARCHAR(32) NOT NULL,

	CONSTRAINT PK_Core_Entity PRIMARY KEY([Id])
)
GO

CREATE INDEX [IX_Core_Entity_Code] ON [Core].[Entity] ([Code]);
