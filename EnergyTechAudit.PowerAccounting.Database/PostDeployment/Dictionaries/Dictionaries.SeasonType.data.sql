SET IDENTITY_INSERT [Dictionaries].[SeasonType] ON;
GO

INSERT INTO [Dictionaries].[SeasonType]([Id],[Code],[Description])
VALUES (1, 'NoSeason', 'Без сезона'),
       (2, 'Summer', 'Летний режим'),
       (3, 'Winter', 'Зимний режим')
GO

SET IDENTITY_INSERT [Dictionaries].[SeasonType] OFF;
GO


