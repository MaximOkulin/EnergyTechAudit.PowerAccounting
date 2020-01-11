

SET IDENTITY_INSERT [Core].[Dictionary] ON;
GO

INSERT INTO [Core].[Dictionary] 
	(Id, Code, [Description], [UpdateOnly])
VALUES
	(1, 'TypeConnection', 'Типы соединений', 1),
	(2, 'StatusConnection', 'Статусы соединений', 1),
	(3, 'PhysicalParameter', 'Физическая величина', 0),
	(4, 'MeasurementUnit', 'Единица измерения', 0),
	(6, 'AgreementSystemParameter', 'Тип договорного параметра системы ресурсов', 0),
	(7, 'Dimension', 'Размерности', 0),
	(8, 'City', 'Населенные пункты', 0),
	(9, 'BuildingPurpose', 'Назначения строений', 0),
	(10, 'Device', 'Модели измерительных устройств', 0),
	(12, 'DeviceEventParameter', 'Параметры событий приборов', 0),
	(13, 'Parameter', 'Величины', 0),
	(14, 'PeriodType', 'Тип периода', 1),
	(15, 'PlacementPurpose', 'Назначения помещений', 0),
	(16, 'ResourceSystemType', 'Типы ресурсных систем', 0),
	(17, 'Baud', 'Скорость передачи информации', 0),
	(18, 'ComPort', 'COM-порт', 0),
	(19, 'DataBit', 'Количество значимых битов', 0),
	(20, 'DeviceParameter', 'Параметры прибора', 0),
	
  (29, 'DefaultMeasurementUnit', 'Единицы измерения по умолчанию', 0),
  (31,  'Binary', 'Бинуарии', 0),
  (32,  'StatusConnection', 'Статусы соединения', 0),
  (33,  'TypeConnection', 'Типы подключения', 0),
  (34,  'TransportType', 'Типы транспорта', 0),
  (35,  'TransportServerModel', 'Модели транспортного сервера', 0),
  (36,  'District', 'Районы населенного пункта', 0),
  (37,  'MeteoDataSourceType', 'Источники метеоданных', 1),
  (38,  'TechnologicAdjunctionType', 'Тип присоединения', 0)
GO

SET IDENTITY_INSERT [Core].[Dictionary] OFF;
GO