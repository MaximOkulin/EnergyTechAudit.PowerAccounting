CREATE TABLE [Dictionaries].[MnemoschemeType]
(
	[Id] INT NOT NULL IDENTITY(1,1),	
	[Code] NVARCHAR(32) NULL,
	[Description] NVARCHAR(128) NOT NULL,
	
	CONSTRAINT [PK_Dictionaries_MnemoschemeType_Id] PRIMARY KEY(Id)
);
