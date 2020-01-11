CREATE TABLE [Dictionaries].[BuildingPurpose]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	Code NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(32) NOT NULL,
	CONSTRAINT PK_Dictionaries_BuildingPurpose PRIMARY KEY(Id)
);
