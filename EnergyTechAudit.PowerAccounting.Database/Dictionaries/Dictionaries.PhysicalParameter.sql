CREATE TABLE [Dictionaries].[PhysicalParameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	Code NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
  [Order] INT NULL,
  CONSTRAINT PK_Dictionaries_PhysicalParameter PRIMARY KEY(Id)
);
