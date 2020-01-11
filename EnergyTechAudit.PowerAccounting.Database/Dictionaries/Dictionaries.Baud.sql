CREATE TABLE [Dictionaries].[Baud]
(
	[Id] INT NOT NULL, 
   [Code] NVARCHAR(64) NULL, 
   [Description] NCHAR(128) NULL,
	CONSTRAINT PK_Dictionaries_Baud PRIMARY KEY(Id)
);