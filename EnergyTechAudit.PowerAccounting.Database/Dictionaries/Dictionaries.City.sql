CREATE TABLE [Dictionaries].[City]
(
	[Id] INT NOT NULL IDENTITY(1,1),	
	Code NVARCHAR(32) NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[LatinCode] NVARCHAR(32) NULL,
	[MinimalTemperature] INT NULL,
	
	CONSTRAINT PK_Dictionaries_City PRIMARY KEY(Id)
);
