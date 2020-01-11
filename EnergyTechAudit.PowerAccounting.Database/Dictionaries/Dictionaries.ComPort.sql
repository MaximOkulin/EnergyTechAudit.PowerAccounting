CREATE TABLE [Dictionaries].[ComPort]
(
	[Id] INT NOT NULL, 
    [Code] NVARCHAR(64) NULL, 
    [Description] NVARCHAR(128) NULL,
	CONSTRAINT PK_Dictionaries_ComPort PRIMARY KEY(Id)
);