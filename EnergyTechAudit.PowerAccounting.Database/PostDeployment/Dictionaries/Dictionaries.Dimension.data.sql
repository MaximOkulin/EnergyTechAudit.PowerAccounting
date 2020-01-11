SET IDENTITY_INSERT [Dictionaries].[Dimension] ON;
GO

INSERT INTO [Dictionaries].[Dimension] ([Id],[Code],[Description], [Prefix], [Value])
VALUES  
   (1,'Deka','дека', 'да', 10),
   (2,'Hecto','гекто', 'г', 100),
	(3,'Kilo','кило', 'к', 1000),
	(4,'Mega','мега', 'М', 1000000), 
	(5,'Giga','гига', 'Г', 1000000000),
	(6,'Tera','тера', 'Т', 1000000000000),
	(7,'Deci','деци', 'д', 0.1),
	(8,'Centi','санти', 'с', 0.01),
	(9,'Milli','милли', 'м', 0.001),
	(10,'Micro','микро', 'мк', 0.000001),
	(11,'Nano','нано', 'н', 0.000000001),
	(12,'Empty','Отсутствует', '', 1)
GO

SET IDENTITY_INSERT [Dictionaries].[Dimension] OFF;
GO