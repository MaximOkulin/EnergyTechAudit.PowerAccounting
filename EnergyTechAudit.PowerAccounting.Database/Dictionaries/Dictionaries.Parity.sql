CREATE TABLE [Dictionaries].[Parity]
(
	[Id] INT NOT NULL, 
	[Code] NVARCHAR(64) NULL, 
	[Description] NCHAR(128) NULL,
	CONSTRAINT PK_Dictionaries_Parity PRIMARY KEY(Id)
);
