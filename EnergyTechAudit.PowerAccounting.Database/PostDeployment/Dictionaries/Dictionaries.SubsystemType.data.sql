SET IDENTITY_INSERT [Dictionaries].[SubsystemType] ON;
GO

INSERT INTO [Dictionaries].[SubsystemType] ([Id], [Code], [Description])
VALUES (1, 'Measurement', 'Подсистема измерения потребленного ресурса'),
       (2, 'RoomLimitation', 'Подсистема ограничения комнатной'),
	   (3, 'ReturnPipeLimitation', 'Подсистема ограничения обратки'),
	   (4, 'EnergyConsumptionLimitation', 'Подсистема ограничения расхода энергии'),
	   (5, 'Optimization', 'Подсистема оптимизации'),
	   (6, 'RegulatorParameters', 'Подсистема параметров регулятора'),
	   (7, 'Application', 'Подсистема приложения'),
	   (8, 'Crash', 'Аварийная подсистема'),
	   (9, 'Makeup', 'Подсистема подпитки'),
	   (10, 'WindInfluence', 'Подсистема влияния ветра'),
	   (11, 'PumpControl', 'Подсистема управления насосом'),
	   (12, 'Compensation', 'Подсистема компенсации'),
	   (13, 'DesiredTemperature', 'Подсистема желаемых температур'),
	   (14, 'FanControl', 'Подсистема управления вентилятором и вспомогательным оборудованием'),
	   (15, 'SafetyLimit', 'Подсистема ограничения температуры безопасности'),
	   (16, 'Relay', 'Подсистема управления реле'),
	   (17, 'HeatCurve', 'Температурный график'),
	   (18, 'Measurement', 'Подсистема измерения потребленного ресурса'),
	   (19, 'ElectroControl', 'Подсистема контроля подачи электричества'),
	   (20, 'ModeAndStatus', 'Режим и статус'),
	   (21, 'DesiredTemperatures', 'Желаемые температуры'),
	   (22, 'VisitingPlacement', 'Мониторинг посещения помещений'),
	   (23, 'BoilerRoom', 'Мониторинг работы котельной'),
	   (24, 'TemperatureMonitor', 'Температурный монитор'),
	   (25, 'HeatingStation', 'Мониторинг работы теплового пункта'),
	   (26, 'FlowTemperature', 'Подсистема регулирования температуры подачи'),
	   (27, 'LightingControl', 'Управление освещением'),
	   (28, 'Common', 'Общие'),
	   (29, 'ComPort', 'Настройки последовательного порта'),
	   (30, 'IP', 'IP-пакеты'),
	   (31, 'ClientMode', 'Режим клиента'),
       (32, 'ControlParameters', 'Параметры управления'),
	   (33, 'ProgramParameters', 'Параметры программы'),
	   (34, 'Regulator', 'Регулятор'),
	   (35, 'FailureControl', 'Контроль аварий'),
	   (36, 'SensorDiapazons', 'Контроль диапазонов аварий датчиков'),
	   (37, 'HeatCarrierTemperature', 'Температура теплоносителя'),
	   (38, 'PID', 'ПИД-регулирование'),
	   (39, 'TemperatureCorrection', 'Температурная поправка'),
	   (40, 'TemperatureBorders', 'Температурные границы'),
	   (41, 'Mode1', 'Режим 1'),
	   (42, 'Mode2', 'Режим 2'),
	   (43, 'Mode3', 'Режим 3'),
	   (44, 'Mode4', 'Режим 4'),
	   (45, 'SetPoints', 'Уставки')

GO

SET IDENTITY_INSERT [Dictionaries].[SubsystemType] OFF;
GO