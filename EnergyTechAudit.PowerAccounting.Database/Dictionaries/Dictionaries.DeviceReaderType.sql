CREATE TABLE [Dictionaries].[DeviceReaderType]
(
	[Id] INT NOT NULL IDENTITY(1, 1), 
  [Code] NVARCHAR(64) NULL, 
  [Description] NCHAR(128) NULL,

	CONSTRAINT [PK_Dictionaries_DeviceReaderType] PRIMARY KEY(Id)
);