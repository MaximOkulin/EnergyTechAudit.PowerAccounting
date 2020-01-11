CREATE TABLE [Dictionaries].[Gender]
(
	[Id] INT NOT NULL, 
    [Code] NVARCHAR(64) NULL, 
    [Description] NCHAR(128) NULL,
	CONSTRAINT PK_Dictionaries_Gender PRIMARY KEY(Id)
)