SET IDENTITY_INSERT [Dictionaries].[MeasurementUnit] ON;
GO

INSERT INTO [Dictionaries].[MeasurementUnit]
     ([Id], [Code], [Description],[PhysicalParameterId])
VALUES
     (1,'Pascal','Па',1),
	 (2,'Atmosphere','атм',1),
	 (3,'Bar','бар',1),
	 (4,'Kelvin','К',2),
	 (5,'Celsius','°С',2),
	 (6,'Calorie','кал',3),
	 (7,'Joule','Дж',3),
	 (8,'Watt','Вт',4),
	 (9,'Kilogram.Per.CubicMeter','кг/м3',5),
	 (10,'Kilogram','кг',6),
	 (11,'CubicMeter','м3',14),
	 (12,'Hertz','Гц',8),
	 (13,'Volt','В',9),
	 (14,'Amper','А',10),
	 (15,'Joule.Per.CubicMeter','Дж/м3',11),
	 (16,'Empty','',12),
	 (17,'CubicMeter.Per.Hour','м3/ч',7),
	 (18,'Tonne','т',6),
	 (19,'Kilogram-force.Per.SquareMeter','кгс/м2',1),
	 (20,'WattHourElectro','Втч',33),
	 (21,'Hour','ч',15),
	 (22,'VAr','ВАр', 25),
	 (23,'VA','ВА', 26),
	 (25,'Meter.Per.Second', 'м/с', 16),
	 (26,'Tonne.Per.Hour','т/ч', 17),
	 (27,'Calorie.Per.Hour','кал/ч', 18),
	 (28,'Ohm','Ом', 19),
	 (29,'Joule.Per.Hour','Дж/ч', 18),
	 (30,'Joule.Per.Kilogram','Дж/кг', 20),
	 (31,'Liters.Per.Minute','литр/мин', 7),
	 (32,'Kilogram.Per.Second','кг/сек', 17),
	 (33,'Second','с', 15),
	 (34,'Minute','мин', 15),
	 (35,'State','', 22),
	 (36,'Liter', 'литр', 14),
	 (37,'Kilogram-force.Per.SquareSantiMeter','кгс/см2', 1),
	 (38,'Coefficient', '', 23),
	 (39,'Liters.Per.Hour', 'л/ч', 7),
	 (40,'Percent', '%', 24),
	 (41,'Day', 'день', 15),
	 (42,'PowerFactor', '', 27),
	 (43,'Degree', '°', 28),
	 (44,'Radian', 'рад', 28),
	 (45,'VArHour', 'ВАрч', 25),
	 (46, 'Joule.Per.Tonne', 'Дж/т', 20),
	 (47, 'Calorie.Per.Tonne', 'кал/т', 20),
	 (48, 'Meter', 'м', 31),
	 (49, 'CubicMeter.Per.Second', 'м3/с', 7),
	 (50, 'CoilEquivalentKilogram.Per.GigaCalorie', 'кг.у.т/Гкал', 32),
	 (51, 'WattHourHeat', 'Втч', 3),
	 (52, 'Standard.CubicMeter.Per.GigaCalorie', 'нм3/Гкал', 32),
	 (53, 'KiloWattHourElectro.Per.GigaCalorie', 'кВтч/Гкал', 32),
	 (54, 'CubicMeter.Per.GigaCalorie', 'м3/Гкал', 32),
	 (55, 'Byte', 'байт', 35),
	 (56, 'KiloWattHour.Per.CubicMeter', 'кВтч/м3', 36),
	 (57, 'Month', 'мес.', 15),
     (58, 'Bell', 'Б', 39),
     (59, 'Bell_mV', 'Бм', 39),
     (60,'CubicMeter.Per.Minute','м3/мин',7),
     (61,'Tonne.Per.Minute','т/мин', 17),
     (62,'Calorie.Per.Minute','кал/мин', 18)
GO

SET IDENTITY_INSERT [Dictionaries].[MeasurementUnit] OFF;
GO



