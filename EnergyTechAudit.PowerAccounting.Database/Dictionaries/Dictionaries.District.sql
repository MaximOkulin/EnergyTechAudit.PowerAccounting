CREATE TABLE [Dictionaries].[District]
(
	[Id] INT NOT NULL IDENTITY(1,1),		
	[Description] NVARCHAR(128) NOT NULL,

	[CityId] INT NOT NULL,

	CONSTRAINT PK_Dictionaries_District PRIMARY KEY(Id),
	CONSTRAINT [FK_Dictionaries_District_CityId_Dictionaries_City_Id] FOREIGN KEY ([CityId]) REFERENCES [Dictionaries].[City]([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_District_CityId] 
   ON [Dictionaries].[District] ([CityId]);
