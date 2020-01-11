SET IDENTITY_INSERT [Dictionaries].[TemperatureProfile] ON;
GO

INSERT INTO [Dictionaries].[TemperatureProfile] ([Id],[Code],[Description])
VALUES
    (1, 'Empty', 'Отсутствует'),
	(2, '150_70', '150/70'),
	(3, '150_65', '150/65'),
	(4, '135_70', '135/70'),
	(5, '135_65', '135/65'),
	(6, '115_70', '115/70'),
	(7, '115_65', '115/65'),
	(8, '95_70', '95/70'),
	(9, '95_65', '95/65')
GO

SET IDENTITY_INSERT [Dictionaries].[TemperatureProfile] OFF;

