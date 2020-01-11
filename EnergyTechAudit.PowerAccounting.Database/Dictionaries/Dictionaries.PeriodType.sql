CREATE TABLE [Dictionaries].[PeriodType]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(32) NOT NULL,
	
	CONSTRAINT PK_Dictionaries_PeriodType PRIMARY KEY (Id)
);
