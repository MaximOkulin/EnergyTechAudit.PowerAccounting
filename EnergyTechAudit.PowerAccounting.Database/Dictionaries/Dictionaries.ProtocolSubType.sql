CREATE TABLE [Dictionaries].[ProtocolSubType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NULL,
	[Description] NVARCHAR(128) NULL,
	CONSTRAINT PK_Dictionaries_ProtocolSubType PRIMARY KEY([Id])
)
