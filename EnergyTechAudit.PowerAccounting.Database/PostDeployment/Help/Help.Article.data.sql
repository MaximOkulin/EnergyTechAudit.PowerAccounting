SET IDENTITY_INSERT [Help].[Article] ON;

GO

:setvar xmlQuote "'"

DECLARE @maxHwsFlowTemperature NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\MaxHwsFlowTemperature.html
$(xmlQuote)

DECLARE @hwsProportionalBand NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\HwsProportionalBand.html
$(xmlQuote)

DECLARE @hwsIntegrationTime NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\HwsIntegrationTime.html
$(xmlQuote)

DECLARE @hwsDriveStockTravelTime NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\HwsDriveStockTravelTime.html
$(xmlQuote)

DECLARE @hwsNeutralZone NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\HwsNeutralZone.html
$(xmlQuote)

DECLARE @maxHsSetFlowTemperature NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\MaxHsSetFlowTemperature.html
$(xmlQuote)

DECLARE @maxHsBorderFlowTemperature NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\MaxHsBorderFlowTemperature.html
$(xmlQuote)

DECLARE @minHsSetFlowTemperature NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\MinHsSetFlowTemperature.html
$(xmlQuote)

DECLARE @minHsBorderFlowTemperature NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\Help\Html\MinHsBorderFlowTemperature.html
$(xmlQuote)

DECLARE @hsPumpIterationTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpIterationTime.html
$(xmlQuote)

DECLARE @hsPumpChangePeriod NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpChangePeriod.html
$(xmlQuote)

DECLARE @hsPumpChangeHour NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpChangeHour.html
$(xmlQuote)

DECLARE @hsPumpStabilizationTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpStabilizationTime.html
$(xmlQuote)

DECLARE @hsPumpSwitchingTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpSwitchingTime.html
$(xmlQuote)

DECLARE @hwsPumpIterationTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HwsPumpIterationTime.html
$(xmlQuote)

DECLARE @hwsPumpChangePeriod NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HwsPumpChangePeriod.html
$(xmlQuote)

DECLARE @hwsPumpChangeHour NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HwsPumpChangeHour.html
$(xmlQuote)

DECLARE @hwsPumpStabilizationTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HwsPumpStabilizationTime.html
$(xmlQuote)

DECLARE @hwsPumpSwitchingTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HwsPumpSwitchingTime.html
$(xmlQuote)

DECLARE @hsPumpTrainingTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpTrainingTime.html
$(xmlQuote)

DECLARE @hwsPumpTrainingTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HwsPumpTrainingTime.html
$(xmlQuote)

DECLARE @hsPumpRequiredPressure NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpRequiredPressure.html
$(xmlQuote)

DECLARE @hsPumpSwitchingDiff NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpSwitchingDiff.html
$(xmlQuote)

DECLARE @hsPumpToppingDuration NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsPumpToppingDuration.html
$(xmlQuote)

DECLARE @hsSupplyPumpTrainingTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\HsSupplyPumpTrainingTime.html
$(xmlQuote)

DECLARE @UniqueIdEntity NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\UniqueIdEntity.html
$(xmlQuote)

DECLARE @FactoryNumber NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\FactoryNumber.html
$(xmlQuote)

DECLARE @a_3 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_3.html
$(xmlQuote)

DECLARE @a_4 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_4.html
$(xmlQuote)

DECLARE @a_5 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_5.html
$(xmlQuote)

DECLARE @a_6 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_6.html
$(xmlQuote)

DECLARE @a_7 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_7.html
$(xmlQuote)

DECLARE @a_8 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_8.html
$(xmlQuote)

DECLARE @a_9 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_9.html
$(xmlQuote)

DECLARE @a_10 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_10.html
$(xmlQuote)

DECLARE @a_11 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_11.html
$(xmlQuote)

DECLARE @a_12 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_12.html
$(xmlQuote)

DECLARE @a_13 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_13.html
$(xmlQuote)

DECLARE @a_14 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_14.html
$(xmlQuote)

DECLARE @a_15 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_15.html
$(xmlQuote)

DECLARE @a_16 NVARCHAR(MAX) =
$(xmlQuote)
:r ..\Help\Html\a_16.html
$(xmlQuote)


INSERT INTO [Help].[Article]
	([Id], [ParentId], [Title], [Html])
VALUES

(1, 0, 'Общие сведения о программе', @UniqueIdEntity),
	(102, 1, 'Требования к программному обеспечению', ''),
	(103, 1, 'Требования к аппаратному обеспечению', @a_16),
	(104, 1, 'Техническая поддержка', ''),
	(105, 1, 'Дополнительные ресурсы', ''),

(2, 0, 'Начало работы в системе', ''),
	(201, 2, 'Терминология', ''),
	(202, 2, 'Модель данных', ''),
		(20201, 202, 'Перечень таблиц бизнес-сущностей', @a_15)


	/*(1, 0, 'Уникальный идентификатор сущности', @UniqueIdEntity),

	(2, 0, 'Заводской номер измерительного прибора', @FactoryNumber),

	(3, 0, 'Максимальное влияние (ограничение комнатной температуры)', @a_3),

	(4, 0, 'Принудительное время открытия (A266.2)', @a_4),
	
	(5, 0, 'Принудительное время закрытия (A266.2)', @a_5),
	
	(6, 0, 'Время (холост.) (A266.2)', @a_6),
	
	(7, 0, 'Температура подачи ГВС (холост., A266.2)', @a_7),

	(8, 0, 'М работа (Время перемещения штока регулирующего клапана с электроприводом)', @a_8),
	
	(9, 0, 'Время адаптации',  @a_9),

	(10, 0,  'Время адаптации', @a_10),
	
	(11, 0, 'Минимальный импульс (мин. время активации, редукторный электропривод)', @a_11),
	
	(12, 0, 'Минимальный импульс (мин. время активации, редукторный электропривод)',@a_12),

	(13, 0, 'Ограничение температуры обратки ГВС', @a_13),

	(14, 0, 'Максимальный коэффициент влияния обратки', @a_14),
	
	(15, 0, 'Минимальный коэффициент влияния обратки', @a_15),

	(16, 0, 'Минимальная температура подачи ГВС', @a_15),

	(17, 0, 'Максимальная температура подачи ГВС', @maxHwsFlowTemperature),
		
	(18, 0, 'Зона пропорциональности ГВС', @hwsProportionalBand),

	(19, 0, 'Постоянная времени интегрирования', @hwsIntegrationTime),

	(20, 0, 'М работа (Время перемещения штока регулирующего клапана с электроприводом)', @hwsDriveStockTravelTime),

	(21, 0, 'Нейтральная зона ГВС', @hwsNeutralZone),

	(22, 0, 'Верхнее значение темп-ры подачи (X2)', @maxHsSetFlowTemperature),
		
	(23, 0, 'Верхнее значение макс. границы (Y2)', @maxHsBorderFlowTemperature),

	(24, 0, 'Нижнее значение темп-ры подачи (X1)', @minHsSetFlowTemperature),

	(25, 0, 'Нижнее значение макс. границы (Y1)', @minHsBorderFlowTemperature),
		
	(26, 0, 'Время повтора (система отопления)', @hsPumpIterationTime),

	(27, 0, 'Длительность смены (система отопления)', @hsPumpChangePeriod),

	(28, 0, 'Время смены (система отопления)', @hsPumpChangeHour),

	(29, 0, 'Время стабилизации (система отопления)', @hsPumpStabilizationTime),

	(30, 0, 'Время переключения насосов (система отопления)', @hsPumpSwitchingTime),

	(31, 0, 'Время повтора (ГВС)', @hwsPumpIterationTime),

	(32, 0, 'Длительность смены (ГВС)', @hwsPumpChangePeriod),

	(33, 0, 'Время смены (ГВС)', @hwsPumpChangeHour),

	(34, 0, 'Время стабилизации (ГВС)', @hwsPumpStabilizationTime),

	(35, 0, 'Время переключения насосов (ГВС)', @hwsPumpSwitchingTime),

	(36, 0, 'Время тестирования насосов (система отопления)', @hsPumpTrainingTime),

	(37, 0, 'Требуемое давление (система отопления)', @hsPumpRequiredPressure),

	(38, 0, 'Разница переключения (система отопления)', @hsPumpSwitchingDiff),	

	(39, 0, 'Длительность долива (система отопления)', @hsPumpToppingDuration),

	(40, 0, 'Время тестирования насосов (ГВС)', @hwsPumpTrainingTime),

	(41, 0, 'Время тестирования насосов подпитки (система отопления)', @hsSupplyPumpTrainingTime)*/

GO

SET IDENTITY_INSERT [Help].[Article] OFF;

GO