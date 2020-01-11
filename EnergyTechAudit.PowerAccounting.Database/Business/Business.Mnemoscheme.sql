CREATE TABLE [Business].[Mnemoscheme]
(
	[Id] INT NOT NULL IDENTITY(1, 1), 
	[Description] NVARCHAR(256) NOT NULL, 
  [Image] XML NOT NULL,
  [MnemoschemeTypeId] INT NOT NULL, 	
  [Zoom] FLOAT NOT NULL, 

  CONSTRAINT PK_Business_Mnemoscheme PRIMARY KEY (Id),

	

  CONSTRAINT [FK_Business_Mnemoscheme_MnemoschemeTypeId_Dictionaries_MnemoschemeType_Id] 
    FOREIGN KEY ([MnemoschemeTypeId]) REFERENCES [Dictionaries].[MnemoschemeType]([Id])
);
GO

ALTER TABLE [Business].[Mnemoscheme]
  ADD CONSTRAINT [DF_Business_Mnemoscheme_Zoom] DEFAULT 1 FOR [Zoom];
GO
