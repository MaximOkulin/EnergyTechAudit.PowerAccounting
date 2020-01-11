CREATE TABLE [Dictionaries].[TransportServerModel]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	CONSTRAINT [PK_Dictionaries_TransportServerModel] PRIMARY KEY ([Id])
);
