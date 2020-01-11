SET IDENTITY_INSERT [Rules].[DefaultMeasurementUnit] ON;
GO

INSERT INTO [Rules].[DefaultMeasurementUnit] 
  ([Id], [Code], [Description], [PhysicalParameterId], [DimensionId], [MeasurementUnitId])
VALUES 
  (1, 'GigaCalorie', 'ГигаКалория', 3/*Энергия*/, 5 /*Гига*/, 6 /*Кал*/),                                 
  (2, 'Tonne', 'Тонна', 6/*Масса*/, 12 /*Без размерности*/, 18),                                     
  (3, 'CubicMeter', 'Кубический метр', 14/*Объем*/, 12 /*Без размерности*/, 11),
  (4, 'Celsius', 'Градус Цельсия', 2/*Температура*/, 12 /*Без размерности*/, 5),
  (5, 'Kilogram-force.Per.SquareSantiMeter', 'Килограмм-сил на квадратный сантиметр', 1/*Давление*/, 12 /*Без размерности*/, 37),
  (6, 'Hour', 'Час', 15/*Время*/, 12/*Без размерности*/,  21),

  (7, N'GigaCalorie.Per.Hour', N'Гига калория в час', 18, 5, 27),
  (8, N'GigaCalorie.Per.Tonne', N'Гага калория на тонну', 20, 5, 47),
  (9, N'MegaWattHour', 'МегаВатт-час', 33 /*Электрическая энергия*/, 4 /*Мега*/, /*Втч (электрический)*/20),
  (10, N'TonnePerHour', 'Тонн в час', 17, 12, 26),
  (11, N'Amper', N'Ампер', 10, 12, 14)

GO

SET IDENTITY_INSERT [Rules].[DefaultMeasurementUnit] OFF;
GO