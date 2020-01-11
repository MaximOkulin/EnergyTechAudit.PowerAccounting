CREATE TABLE [Dictionaries].[StopBit]
(
   [Id] INT NOT NULL, 
   [Code] NVARCHAR(64) NULL, 
   [Description] NCHAR(128) NULL,
	CONSTRAINT PK_Dictionaries_StopBit PRIMARY KEY(Id)
);