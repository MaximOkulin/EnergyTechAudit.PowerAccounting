SET IDENTITY_INSERT [Dictionaries].[BuildingPurpose] ON;
GO

INSERT INTO [Dictionaries].[BuildingPurpose]
    ([Id], Code, [Description])
VALUES
    (1,'House','Жилой дом'),
	(2,'Factory','Завод'),
	(3,'KinderGarden','Детский сад'),
	(4,'BoilerHouse', 'Котельная'),
	(5,'Office', 'Офис'),
	(6, 'Garage', 'Гараж'),
	(7, 'PoliceDepartment', 'Отдел полиции'),
	(8, 'Hospital', 'Больница'),	
	(9, 'Policlinic', 'Поликлиника'),
	(10, 'Court', 'Суд'), 
	(11, 'School', 'Средняя школа'),
	(12, 'University', 'Высшее учебное заведение'),
	(13, 'Сollege', 'Техникум'),
    (14, 'Well', 'Колодец'),
    (15, 'Mall', 'Торговый центр'),
    (16, 'Bank', 'Банк')

GO

SET IDENTITY_INSERT [Dictionaries].[BuildingPurpose] OFF;
GO