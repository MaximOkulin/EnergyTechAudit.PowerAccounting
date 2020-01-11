SET IDENTITY_INSERT [Dictionaries].[PhysicalParameter] ON;
GO

INSERT INTO [Dictionaries].[PhysicalParameter]
    ([Id], Code, [Description], [Order])
VALUES
    (1,'Pressure', 'Давление', 60),
	(2,'Temper','Температура', 10),
	(3,'Energy','Энергия', 20),
	(4,'ActivePower','Активная электрическая мощность', NULL),
	(5,'Density','Плотность', NULL),
	(6,'Mass','Масса', 40),
	(7,'VolumeFlow','Объемный расход', 30),
	(8,'Frequency','Частота', NULL),
	(9,'Voltage','Напряжение', NULL),
	(10,'Current','Электрический ток', NULL),
	(11,'Combustion','Теплота сгорания', NULL),
	(12,'Empty','Без размерности', 100),
	(14,'Volume','Объем', 20),
	(15,'TimeSpan','Промежуток времени', NULL),
	(16,'Velocity','Скорость', NULL),
	(17,'MassFlow','Массовый расход', 31),
	(18,'ThermalPower','Тепловая мощность', NULL),
	(19,'Resistance','Сопротивление', NULL),
	(20,'Enthalpy', 'Энтальпия', NULL),
	(22,'State', 'Состояние', NULL),
	(23,'Сoefficient', 'Коэффициент', NULL),
	(24,'Percent', 'Процент', NULL),
	(25,'ReactivePower', 'Реактивная электрическая мощность', NULL),
	(26,'FullPower', 'Полная электрическая мощность', NULL),
	(27,'PowerFactor', 'Коэффициент мощности', NULL),
	(28,'AngleStandard', 'Угловая мера', NULL),
	(29,'DateTime', 'Дата/время', NULL),
	(30, 'Humidity', 'Влажность', NULL),
	(31, 'Height', 'Высота', NULL),
	(32, 'CoalEquivalent', 'Расход условного топлива', NULL),
	(33, 'ElectricEnergy', 'Электрическая энергия', 110),
	(34, 'Time', 'Время', NULL),
	(35, 'Information', 'Информация', NULL),
	(36, 'CalorificValue', 'Теплотворная способность', NULL),
    (37, 'Mode', 'Режим', NULL),
    (38, 'Status', 'Статус', NULL),
    (39, 'LogarithmicRatio', 'Логарифмическое отношение', NULL)

GO

SET IDENTITY_INSERT [Dictionaries].[PhysicalParameter] OFF;
GO