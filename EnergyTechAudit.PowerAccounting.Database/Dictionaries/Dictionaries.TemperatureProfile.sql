CREATE TABLE [Dictionaries].[TemperatureProfile]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(64) NOT NULL,

	CONSTRAINT [PK_Dictionaries_TemperatureProfile] PRIMARY KEY ([Id])
)
