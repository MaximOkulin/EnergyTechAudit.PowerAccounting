CREATE TABLE [Dictionaries].[ProcessingStatus]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NULL,
	[Description] NVARCHAR(128) NULL,

	CONSTRAINT PK_Dictionaries_ProcessingStatus_Id PRIMARY KEY ([Id])
)
