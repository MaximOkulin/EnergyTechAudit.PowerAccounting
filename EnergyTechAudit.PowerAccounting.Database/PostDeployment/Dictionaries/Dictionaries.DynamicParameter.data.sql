SET IDENTITY_INSERT [Dictionaries].[DynamicParameter] ON;
GO

:setvar xmlQuote "'"

DECLARE @sbtAccessType NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\SbtAccessType.json
$(xmlQuote)

DECLARE @ecl310Key NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\Ecl310Key.json
$(xmlQuote)

DECLARE @ecl110Key NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\Ecl110Key.json
$(xmlQuote)

DECLARE @ecl300Key NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\Ecl300Key.json
$(xmlQuote)

DECLARE @mobileOperatorType NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\MobileOperatorType.json
$(xmlQuote)

DECLARE @heatCurveSupplyPipe NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\HeatCurveSupplyPipe.json
$(xmlQuote)

DECLARE @heatCurveReturnPipe NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\HeatCurveReturnPipe.json
$(xmlQuote)

DECLARE @heatCurveTemplate NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Json\DynamicParameter\HeatCurveTemplate.json
$(xmlQuote)

DECLARE @signeticsKey NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Json\DynamicParameter\SigneticsKey.json
$(xmlQuote)

DECLARE @dateWithTime NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\DateWithTime.json
$(xmlQuote)

DECLARE @sirius2L NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\Sirius\2L.json
$(xmlQuote)

DECLARE @sirius2V NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\Sirius\2V.json
$(xmlQuote)

DECLARE @temFlashType NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\TemFlashType.json
$(xmlQuote)

DECLARE @webServiceProvider NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Json\DynamicParameter\WebServiceProvider.json
$(xmlQuote)

DECLARE @analogValueConvert NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Json\DynamicParameter\AnalogValueConvert.json
$(xmlQuote)

DECLARE @analogValueArchiveType NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Json\DynamicParameter\AnalogValueArchiveType.json
$(xmlQuote)

DECLARE @danfossMcxKey NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\DanfossMcxKey.json
$(xmlQuote)

DECLARE @psch4tm5mkNumber NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\DynamicParameter\Psch4tm5mkNumber.json
$(xmlQuote)



INSERT INTO [Dictionaries].[DynamicParameter]
  ([Id], [EntityTypeName], [Code], [Description], [Type], [IsDefault], [IsReadOnly], [DefaultValue], [Descriptor])
VALUES
  (1, 'MeasurementDevice', 'Device.KM5.HourArchiveLastIndex', 'Индекс последнего часового архива', 'Int32', 1, 1, '-1', NULL),
  (2, 'MeasurementDevice', 'Device.KM5.DayArchiveLastIndex', 'Индекс последнего суточного архива', 'Int32', 1, 1, '-1', NULL),
  (3, 'MeasurementDevice', 'Device.KM5.MonthArchiveLastIndex', 'Индекс последнего месячного архива', 'Int32', 1, 1, '-1', NULL),
  (4, 'MeasurementDevice', 'Device.Vzl24.LastHourArchiveScan1', 'Дата последнего запрошенного часового архива ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (5, 'MeasurementDevice', 'Device.Vzl24.LastDayArchiveScan1', 'Дата последнего запрошенного суточного архива ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (6, 'MeasurementDevice', 'Device.Vzl24.LastMonthArchiveScan1', 'Дата последнего запрошенного месячного архива ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (7, 'MeasurementDevice', 'Device.Vzl24.LastHourArchiveScan2', 'Дата последнего запрошенного часового архива ТС2', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (8, 'MeasurementDevice', 'Device.Vzl24.LastDayArchiveScan2', 'Дата последнего запрошенного суточного архива ТС2', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (9, 'MeasurementDevice', 'Device.Vzl24.LastMonthArchiveScan2', 'Дата последнего запрошенного месячного архива ТС2', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (10, 'MeasurementDevice', 'Device.Vzl24.LastHourArchiveScan3', 'Дата последнего запрошенного часового архива ТС3', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (11, 'MeasurementDevice', 'Device.Vzl24.LastDayArchiveScan3', 'Дата последнего запрошенного суточного архива ТС3', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (12, 'MeasurementDevice', 'Device.Vzl24.LastMonthArchiveScan3', 'Дата последнего запрошенного месячного архива ТС3', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (13, 'MeasurementDevice', 'Device.Vzl24.LastHourSummaryArchiveScan', 'Дата последнего запрошенного суммарного часового архива ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (14, 'MeasurementDevice', 'Device.Vzl24.LastDaySummaryArchiveScan', 'Дата последнего запрошенного суммарного суточного архива ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (15, 'MeasurementDevice', 'Device.Vzl24.LastMonthSummaryArchiveScan', 'Дата последнего запрошенного суммарного месячного архива ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (16, 'MeasurementDevice', 'Device.Vzl24.LastHourIncrescentArchiveScan', 'Дата последнего запрошенного нарастающего часового архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (17, 'MeasurementDevice', 'Device.Vzl24.LastDayIncrescentArchiveScan', 'Дата последнего запрошенного нарастающего суточного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (18, 'MeasurementDevice', 'Device.Vzl24.LastMonthIncrescentArchiveScan', 'Дата последнего запрошенного нарастающего месячного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (19, 'MeasurementDevice', 'Device.Vzl24.LastHsEmergencyLog1', 'Дата последней считанной записи журнала НС ТС1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (20, 'MeasurementDevice', 'Device.Vzl24.LastHsEmergencyLog2', 'Дата последней считанной записи журнала НС ТС2', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (21, 'MeasurementDevice', 'Device.Vzl24.LastHsEmergencyLog3', 'Дата последней считанной записи журнала НС ТС3', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (22, 'MeasurementDevice', 'Device.Vzl24.LastEmergencyLog', 'Дата последней считанной записи журнала НС всего прибора', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (23, 'MeasurementDevice', 'Device.Vzl24.LastFailureLog', 'Дата последней считанной записи журнала отказов', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (24, 'MeasurementDevice', 'Device.Vzl24.LastChangeModeLog', 'Дата последней считанной записи журнала режимов', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (25, 'MeasurementDevice', 'Device.LastHourArchiveScan', 'Дата последнего запрошенного часового архива','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (26, 'MeasurementDevice', 'Device.LastDayArchiveScan', 'Дата последнего запрошенного суточного архива','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (27, 'MeasurementDevice', 'Device.LastMonthArchiveScan', 'Дата последнего запрошенного месячного архива','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (31, 'MeasurementDevice', 'Device.VoltageTransCoef', 'Коэффициент трансформации по напряжению', 'Int32', 1, 0, '1', NULL),
  (32, 'MeasurementDevice', 'Device.CurrentTransCoef', 'Коэффициент трансформации по току', 'Int32', 1, 0, '1', NULL),
  (33, 'MeasurementDevice', 'Device.InitDate', 'Дата инициализации', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (34, 'MeasurementDevice', 'Device.IsManualInit', 'Ручная инициализация', 'Boolean', 1, 0, 'false', NULL),
  (35, 'MeasurementDevice', 'Device.SbtAccessType', 'Способ доступа к данным прибора через СБТ-Солярис', 'Int32', 0, 0, '1', @sbtAccessType),
  (36, 'MeasurementDevice', 'Device.ImpulseWeight', 'Вес импульса', 'Int32', 0, 0, '100', NULL),
  (37, 'MeasurementDevice', 'Device.SbtAdapterAddress', 'Адрес СБТ-адаптера', 'Int32', 0, 0, '0', NULL),
  (38, 'MeasurementDevice', 'Device.SbtAdapterChannel', 'Канал СБТ-адаптера', 'Int32', 0, 0, '1', NULL),
  (39, 'MeasurementDevice', 'Device.LastArchiveDate', 'Дата последнего архива', 'DateTime', 0, 1, '0001-01-01T00:00:00', NULL),
  (40, 'MeasurementDevice', 'Device.StartValue', 'Стартовое значение', 'Decimal', 0, 0, '0', NULL),
  (41, 'MeasurementDevice', 'Device.Ecl310.Key', 'Ключ-приложение', 'Int32', 1, 0, '1', @ecl310Key),
  (42, 'MeasurementDevice', 'Device.IsInit', 'Прибор инициализирован', 'Boolean', 1, 1, 'false', NULL),
  (43, 'AccessPoint', 'AccessPoint.MobileOperator.', 'Мобильный оператор', 'Int32', 0, 0, '1', @mobileOperatorType),
  (44, 'AccessPoint', 'AccessPoint.SimNumber', 'Номер SIM-карты', 'String', 0, 0, '0000000000000000000', NULL),
  (45, 'DeviceReader', 'DeviceReader.ListenIpAddress', 'Прослушиваемый локальный IP-адрес', 'String', 0, 0, '192.168.0.1', NULL),
  (46, 'DeviceReader', 'DeviceReader.ListenPort', 'Прослушиваемый локальный порт', 'Int32', 0, 0, '2780', NULL),
  (47, 'MeasurementDevice', 'Device.ReadOnlyDayArchivesViaCsd', 'Чтение только суточных архивов (через CSD)', 'Boolean', 0, 0, 'true', NULL),
  (48, 'MeasurementDevice', 'Device.TV7.AIBDLastIndex', 'Индекс последнего считанного архива АИБД', 'Int32', 1, 1, '-1', NULL),
  (49, 'MeasurementDevice', 'Device.TV7.AASLastIndex', 'Индекс последнего считанного архива ААС', 'Int32', 1, 1, '-1', NULL),
  (50, 'MeasurementDevice', 'Device.TV7.ADLastIndex', 'Индекс последнего считанного архива АД', 'Int32', 1, 1, '-1', NULL),
  (52, 'AccessPoint', 'AccessPoint.I7188GeneralAddress', 'Общий сетевой адрес контроллера I-7188', 'Int32', 0, 0, '0', NULL),
  (53, 'MeasurementDevice', 'Device.KM5.ErrorArchiveLastIndex', 'Индекс последнего архива ошибок', 'Int32', 1, 1, '-1', NULL),
  (54, 'AccessPoint', 'AccessPoint.MoxaCommandPort', 'Командный порт Moxa', 'Int32', 0, 0, '966', NULL),
  (55, 'MeasurementDevice', 'Device.HourArchiveLastIndex', 'Индекс последнего часового архива', 'Int32', 1, 1, '-1', NULL),
  (56, 'MeasurementDevice', 'Device.DayArchiveLastIndex', 'Индекс последнего суточного архива', 'Int32', 1, 1, '-1', NULL),
  (57, 'MeasurementDevice', 'Device.IsFactoryNumberInit', 'Заводской номер инициализирован', 'Boolean', 1, 1, 'false', NULL),
  (58, 'MeasurementDevice', 'Device.Vzl26.EmergencyLogLastIndex', 'Индекс последней записи журнала НС', 'Int32', 1, 1, '-1', NULL),
  (59, 'MeasurementDevice', 'Device.Vzl26.FailureLogLastIndex', 'Индекс последней записи журнала отказов', 'Int32', 1, 1, '-1', NULL),
  (60, 'MeasurementDevice', 'Device.Vzl26.ChangeModeLogLastIndex', 'Индекс последней записи журнала режимов', 'Int32', 1, 1, '-1', NULL),
  (61, 'Organization', 'Organization.HeatCurveSupplyPipe', 'Температурный график для подающего трубопровода', 'String', 0, 0, @heatCurveTemplate, @heatCurveSupplyPipe),
  (62, 'Organization', 'Organization.HeatCurveReturnPipe', 'Температурный график для обратного трубопровода', 'String', 0, 0, @heatCurveTemplate, @heatCurveReturnPipe),
  (63, 'Building', 'Building.OutdoorTemperatureCorrection', 'Коррекция температуры наружного воздуха, °С', 'Decimal', 0, 0, '0', NULL),
  (64, 'MeasurementDevice', 'Device.EskoMtr06v134.HourArchiveFullScan', 'Часовой архив просканирован полностью', 'Boolean', 1, 1, 'false', NULL),
  (65, 'MeasurementDevice', 'Device.EskoMtr06v134.DayArchiveFullScan', 'Суточный архив просканирован полностью', 'Boolean', 1, 1, 'false', NULL),
  (66, 'MeasurementDevice', 'Device.DelayBeforePolling', 'Задержка перед опросом (мс)', 'Int32', 0, 0, '2000', NULL),
  (67, 'MeasurementDevice', 'Device.Ecl300.Key', 'Ключ-приложение', 'Int32', 1, 0, '1', @ecl300Key),
  (68, 'MeasurementDevice', 'Device.UseLacePowerServer', 'Использовать Lace Power Server', 'Boolean', 0, 0, 'true', NULL),
  (69, 'MeasurementDevice', 'Device.LaceIdentifier', 'Идентификатор в системе Lace', 'String', 0, 0, '_', NULL),
  (70, 'AccessPoint', 'AccessPoint.LaceApiKey', 'Ключ API в системе', 'String', 0, 0, '_', NULL),
  (71, 'MeasurementDevice', 'Device.Spt943.HasHourArchiveTv1', 'Часовые архивы ТВ1 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (72, 'MeasurementDevice', 'Device.Spt943.HasDayArchiveTv1', 'Суточные архивы ТВ1 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (73, 'MeasurementDevice', 'Device.Spt943.HasHourArchiveTv2', 'Часовые архивы ТВ2 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (74, 'MeasurementDevice', 'Device.Spt943.HasDayArchiveTv2', 'Суточные архивы ТВ2 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (75, 'MeasurementDevice', 'Device.Spt943.LastHourArchiveScanTv1', 'Дата последнего запрошенного часового архива ТВ1','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (76, 'MeasurementDevice', 'Device.Spt943.LastDayArchiveScanTv1', 'Дата последнего запрошенного суточного архива ТВ1','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (77, 'MeasurementDevice', 'Device.Spt943.LastHourArchiveScanTv2', 'Дата последнего запрошенного часового архива ТВ2','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (78, 'MeasurementDevice', 'Device.Spt943.LastDayArchiveScanTv2', 'Дата последнего запрошенного суточного архива ТВ2','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (79, 'MeasurementDevice', 'Device.Spt943.IntegratingMachine', 'Описание параметров интеграционной машины СПТ943', 'String', 1, 1, '_', NULL),
  (80, 'MeasurementDevice', 'Device.HourArchiveFullScan', 'Часовой архив просканирован полностью', 'Boolean', 1, 1, 'false', NULL),
  (81, 'MeasurementDevice', 'Device.DayArchiveFullScan', 'Суточный архив просканирован полностью', 'Boolean', 1, 1, 'false', NULL),
  (82, 'MeasurementDevice', 'Device.Vkt7.SchemeTv1', 'Схема измерения по ТВ1 (СИ)', 'Int32', 1, 1, '-1', NULL),
  (83, 'MeasurementDevice', 'Device.Vkt7.SchemeTv2', 'Схема измерения по ТВ2 (СИ)', 'Int32', 1, 1, '-1', NULL),
  (84, 'MeasurementDevice', 'Device.Vkt7.Pipe3TargetTv1', 'Назначение трубопровода 3 по ТВ1 (ТР3)', 'Int32', 1, 1, '-1', NULL),
  (85, 'MeasurementDevice', 'Device.Vkt7.Pipe3TargetTv2', 'Назначение трубопровода 3 по ТВ2 (ТР3)', 'Int32', 1, 1, '-1', NULL),
  (86, 'MeasurementDevice', 'Device.Vkt7.t5TargetTv1', 'Назначение t5 по ТВ1', 'Int32', 1, 1, '-1', NULL),
  (87, 'MeasurementDevice', 'Device.Vkt7.t5TargetTv2', 'Назначение t5 по ТВ2', 'Int32', 1, 1, '-1', NULL),
  (88, 'MeasurementDevice', 'Device.Magika.UpperDayArchiveDate', 'Верхняя дата суточного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (89, 'MeasurementDevice', 'Device.Magika.DownDayArchiveDate', 'Нижняя дата суточного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (90, 'MeasurementDevice', 'Device.Magika.SliderDayArchiveDate', 'Промежуточная дата суточного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (91, 'MeasurementDevice', 'Device.Magika.UpperHourArchiveDate', 'Верхняя дата часового архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (92, 'MeasurementDevice', 'Device.Magika.DownHourArchiveDate', 'Нижняя дата часового архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (93, 'MeasurementDevice', 'Device.Magika.SliderHourArchiveDate', 'Промежуточная дата часового архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (94, 'MeasurementDevice', 'Device.LersModemBaudRateConfigure', 'Конфигурировать скорость ЛЭРС-модема перед опросом', 'Boolean', 0, 0, 'true', NULL),
  (95, 'MeasurementDevice', 'Device.Signetics.Key', 'Ключ-приложение', 'Int32', 1, 0, '1', @signeticsKey),
  (96, 'MeasurementDevice', 'Device.Pulsar.LastDayArchive', 'Дата последнего сохраненного суточного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (97, 'AccessPoint', 'AccessPoint.NetworkAddress', 'Сетевой адрес', 'Int32', 0, 0, '254', NULL),
  (98, 'MeasurementDevice', 'Device.UseEvenParity', 'Использовать программный контроль четности', 'Boolean', 0, 0, 'false', NULL),
  (99, 'MeasurementDevice', 'Device.HasHourArchive', 'Часовые архивы в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (100, 'MeasurementDevice', 'Device.HasDayArchive', 'Суточные архивы в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (101, 'MeasurementDevice', 'Device.MakeDayArchiveViaHour', 'Получать суточные архивы из часовых', 'Boolean', 0, 0, 'true', NULL),
  (102, 'MeasurementDevice', 'Device.HourIntegratingMachine', 'Описание параметров интеграционной машины (часовые архивы)', 'String', 1, 1, '_', NULL),
  (103, 'MeasurementDevice', 'Device.DayIntegratingMachine', 'Описание параметров интеграционной машины (суточные архивы)', 'String', 1, 1, '_', NULL),
  (104, 'MeasurementDevice', 'Device.ReportingDay', 'Отчетный день', 'Int32', 0, 0, '1', NULL),
  (105, 'MeasurementDevice', 'Device.HasMonthArchive', 'Месячные архивы в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (106, 'MeasurementDevice', 'Device.ConsumerPassword', 'Пароль уровня потребителя', 'String', 0, 0, '000000', NULL),
  (107, 'MeasurementDevice', 'Device.ActiveTariffsCount', 'Количество активных тарифов', 'Int32', 0, 0, '8', NULL),
  (108, 'MeasurementDevice', 'Device.HourArchiveViaPowerProfile', 'Описание настроек профиля мощности для получения часовых архивов', 'String', 1, 1, '_', NULL),
  (109, 'MeasurementDevice', 'Device.CoalEquivalentCondition', 'Описание условий расчета показателей расхода условного топлива', 'String', 1, 0, '_', NULL),
  (110, 'MeasurementDevice', 'Device.StartDate', 'Дата старта', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (111, 'MeasurementDevice', 'Device.LastHourCalculatedDate', 'Последняя рассчитанная часовая дата', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (112, 'MeasurementDevice', 'Device.LastDayCalculatedDate', 'Последняя рассчитанная суточная дата', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (113, 'MeasurementDevice', 'Device.LastHourArchiveScanAddress', 'Последний просканированный адрес часового архива', 'Int32', 1, 1, '-1', NULL),
  (114, 'MeasurementDevice', 'Device.LastDayArchiveScanAddress', 'Последний просканированный адрес суточного архива', 'Int32', 1, 1, '-1', NULL),
  (115, 'MeasurementDevice', 'Device.ModbusRegistersDescription', 'Описание регистров Modbus', 'String', 1, 1, '_', NULL),
  (116, 'MeasurementDevice', 'Device.StartValueImpulseInput', 'Стартовое значение по импульсному входу', 'Decimal', 0, 0, '0', NULL),
  (117, 'MeasurementDevice', 'Device.StartTimeChannel1', 'Время стартового значения по каналу 1', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (118, 'MeasurementDevice', 'Device.StartValueChannel1', 'Стартовое значение по каналу 1', 'Decimal', 0, 0, '0', NULL),
  (119, 'MeasurementDevice', 'Device.StartTimeChannel2', 'Время стартового значения по каналу 2', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (120, 'MeasurementDevice', 'Device.StartValueChannel2', 'Стартовое значение по каналу 2', 'Decimal', 0, 0, '0', NULL),
  (121, 'MeasurementDevice', 'Device.CurrentStartValueChannel1', 'Текущее стартовое значение по каналу 1', 'Decimal', 1, 1, '0', NULL),
  (122, 'MeasurementDevice', 'Device.CurrentStartValueChannel2', 'Текущее стартовое значение по каналу 2', 'Decimal', 1, 1, '0', NULL),
  (123, 'MeasurementDevice', 'Device.StartTimeChannel3', 'Время стартового значения по каналу 3', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (124, 'MeasurementDevice', 'Device.StartTimeChannel4', 'Время стартового значения по каналу 4', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (125, 'MeasurementDevice', 'Device.StartTimeChannel5', 'Время стартового значения по каналу 5', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (126, 'MeasurementDevice', 'Device.StartTimeChannel6', 'Время стартового значения по каналу 6', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (127, 'MeasurementDevice', 'Device.StartTimeChannel7', 'Время стартового значения по каналу 7', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (128, 'MeasurementDevice', 'Device.StartTimeChannel8', 'Время стартового значения по каналу 8', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (129, 'MeasurementDevice', 'Device.StartTimeChannel9', 'Время стартового значения по каналу 9', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (130, 'MeasurementDevice', 'Device.StartTimeChannel10', 'Время стартового значения по каналу 10', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (131, 'MeasurementDevice', 'Device.StartTimeChannel11', 'Время стартового значения по каналу 11', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (132, 'MeasurementDevice', 'Device.StartTimeChannel12', 'Время стартового значения по каналу 12', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (133, 'MeasurementDevice', 'Device.StartTimeChannel13', 'Время стартового значения по каналу 13', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (134, 'MeasurementDevice', 'Device.StartTimeChannel14', 'Время стартового значения по каналу 14', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (135, 'MeasurementDevice', 'Device.StartTimeChannel15', 'Время стартового значения по каналу 15', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (136, 'MeasurementDevice', 'Device.StartTimeChannel16', 'Время стартового значения по каналу 16', 'DateTime', 0, 0, '0001-01-01T00:00:00', @dateWithTime),
  (137, 'MeasurementDevice', 'Device.StartValueChannel3', 'Стартовое значение по каналу 3', 'Decimal', 0, 0, '0', NULL),
  (138, 'MeasurementDevice', 'Device.StartValueChannel4', 'Стартовое значение по каналу 4', 'Decimal', 0, 0, '0', NULL),
  (139, 'MeasurementDevice', 'Device.StartValueChannel5', 'Стартовое значение по каналу 5', 'Decimal', 0, 0, '0', NULL),
  (140, 'MeasurementDevice', 'Device.StartValueChannel6', 'Стартовое значение по каналу 6', 'Decimal', 0, 0, '0', NULL),
  (141, 'MeasurementDevice', 'Device.StartValueChannel7', 'Стартовое значение по каналу 7', 'Decimal', 0, 0, '0', NULL),
  (142, 'MeasurementDevice', 'Device.StartValueChannel8', 'Стартовое значение по каналу 8', 'Decimal', 0, 0, '0', NULL),
  (143, 'MeasurementDevice', 'Device.StartValueChannel9', 'Стартовое значение по каналу 9', 'Decimal', 0, 0, '0', NULL),
  (144, 'MeasurementDevice', 'Device.StartValueChannel10', 'Стартовое значение по каналу 10', 'Decimal', 0, 0, '0', NULL),
  (145, 'MeasurementDevice', 'Device.StartValueChannel11', 'Стартовое значение по каналу 11', 'Decimal', 0, 0, '0', NULL),
  (146, 'MeasurementDevice', 'Device.StartValueChannel12', 'Стартовое значение по каналу 12', 'Decimal', 0, 0, '0', NULL),
  (147, 'MeasurementDevice', 'Device.StartValueChannel13', 'Стартовое значение по каналу 13', 'Decimal', 0, 0, '0', NULL),
  (148, 'MeasurementDevice', 'Device.StartValueChannel14', 'Стартовое значение по каналу 14', 'Decimal', 0, 0, '0', NULL),
  (149, 'MeasurementDevice', 'Device.StartValueChannel15', 'Стартовое значение по каналу 15', 'Decimal', 0, 0, '0', NULL),
  (150, 'MeasurementDevice', 'Device.StartValueChannel16', 'Стартовое значение по каналу 16', 'Decimal', 0, 0, '0', NULL),
  (151, 'MeasurementDevice', 'Device.CurrentStartValueChannel3', 'Текущее стартовое значение по каналу 3', 'Decimal', 1, 1, '0', NULL),
  (152, 'MeasurementDevice', 'Device.CurrentStartValueChannel4', 'Текущее стартовое значение по каналу 4', 'Decimal', 1, 1, '0', NULL),
  (153, 'MeasurementDevice', 'Device.CurrentStartValueChannel5', 'Текущее стартовое значение по каналу 5', 'Decimal', 1, 1, '0', NULL),
  (154, 'MeasurementDevice', 'Device.CurrentStartValueChannel6', 'Текущее стартовое значение по каналу 6', 'Decimal', 1, 1, '0', NULL),
  (155, 'MeasurementDevice', 'Device.CurrentStartValueChannel7', 'Текущее стартовое значение по каналу 7', 'Decimal', 1, 1, '0', NULL),
  (156, 'MeasurementDevice', 'Device.CurrentStartValueChannel8', 'Текущее стартовое значение по каналу 8', 'Decimal', 1, 1, '0', NULL),
  (157, 'MeasurementDevice', 'Device.CurrentStartValueChannel9', 'Текущее стартовое значение по каналу 9', 'Decimal', 1, 1, '0', NULL),
  (158, 'MeasurementDevice', 'Device.CurrentStartValueChannel10', 'Текущее стартовое значение по каналу 10', 'Decimal', 1, 1, '0', NULL),
  (159, 'MeasurementDevice', 'Device.CurrentStartValueChannel11', 'Текущее стартовое значение по каналу 11', 'Decimal', 1, 1, '0', NULL),
  (160, 'MeasurementDevice', 'Device.CurrentStartValueChannel12', 'Текущее стартовое значение по каналу 12', 'Decimal', 1, 1, '0', NULL),
  (161, 'MeasurementDevice', 'Device.CurrentStartValueChannel13', 'Текущее стартовое значение по каналу 13', 'Decimal', 1, 1, '0', NULL),
  (162, 'MeasurementDevice', 'Device.CurrentStartValueChannel14', 'Текущее стартовое значение по каналу 14', 'Decimal', 1, 1, '0', NULL),
  (163, 'MeasurementDevice', 'Device.CurrentStartValueChannel15', 'Текущее стартовое значение по каналу 15', 'Decimal', 1, 1, '0', NULL),
  (164, 'MeasurementDevice', 'Device.CurrentStartValueChannel16', 'Текущее стартовое значение по каналу 16', 'Decimal', 1, 1, '0', NULL),
  (165, 'MeasurementDevice', 'Device.SendInstantValuesToMnemoschemeViaSignalR', 'Отправлять мгновенные данные на мнемосхему через SignalR', 'Boolean', 0, 0, 'false', NULL),
  (166, 'MeasurementDevice', 'Device.DesignFactor', 'Расчетный коэффициент', 'Int32', 1, 0, '1', NULL),
  (167, 'MeasurementDevice', 'Device.Sirius.2L5A.Version', 'Версия ПО Сириус 2-Л', 'Int32', 1, 0, '1', @sirius2L),
  (168, 'MeasurementDevice', 'Device.Sirius.2V.Version', 'Версия ПО Сириус 2-В', 'Int32', 1, 0, '1', @sirius2V),
  (169, 'MeasurementDevice', 'Device.IntegratingMachine', 'Описание параметров интеграционной машины', 'String', 1, 1, '_', NULL),
  (170, 'MeasurementDevice', 'Device.ReadHourProfilesFromNow', 'Чтение часовых профилей с текущего момента', 'Boolean', 0, 0, 'false', NULL),
  (171, 'MeasurementDevice', 'Device.GasHour', 'Начало "газового дня"', 'Int32', 0, 0, '10', NULL),
  (172, 'MeasurementDevice', 'Device.HasHourArchive1', 'Часовые архивы ТВ1 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (173, 'MeasurementDevice', 'Device.HasHourArchive2', 'Часовые архивы ТВ2 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (174, 'MeasurementDevice', 'Device.HasHourArchive3', 'Часовые архивы ТВ3 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (175, 'MeasurementDevice', 'Device.HasDayArchive1', 'Суточные архивы ТВ1 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (176, 'MeasurementDevice', 'Device.HasDayArchive2', 'Суточные архивы ТВ2 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (177, 'MeasurementDevice', 'Device.HasDayArchive3', 'Суточные архивы ТВ3 в БД есть', 'Boolean', 1, 1, 'false', NULL),
  (178, 'MeasurementDevice', 'Device.MakeDailyTimeAdjustment', 'Выполнять ежедневную корректировку времени', 'Boolean', 0, 0, 'false', NULL),
  (179, 'MeasurementDevice', 'Device.LastTimeAdjustmentDate', 'Время последней корректировки времени', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (180, 'Building', 'Building.HourlyConsumptionHeat', 'Нормативное потребление тепловой энергии, Гкал/час', 'Decimal', 0, 0, '1', NULL),
  (181, 'Building', 'Building.UseDescriptionInReports', 'Использовать поле "Наименование" в отчетах', 'Boolean', 0, 0, 'false', NULL),
  (182, 'Building', 'Building.CwsForHwsHeatingFactor', 'Коэффициент подогрева ХВС для ГВС, Гкал/м3', 'Decimal', 0, 0, '0.1', NULL),
  (183, 'Building', 'Building.UseDeductionHwsHeat', 'Учет потребления на нужды ГВС', 'Boolean', 0, 0, 'true', NULL),
  (184, 'MeasurementDevice', 'Device.InitCalendarDate', 'Дата инициализации календаря','DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (185, 'MeasurementDevice', 'Device.ContractParametersUpdateDate',  'Дата обновления договорных параметров', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (186, 'MeasurementDevice', 'Device.NotUseBaudRateChange', 'Не использовать переключение скорости', 'Boolean', 0, 0, 'false', NULL),
  (187, 'AccessPoint', 'AccessPoint.CheckWiznetStatusConnection', 'Проверять статус подключения Wiznet', 'Boolean', 0, 0, 'false', NULL),
  (188, 'MeasurementDevice', 'Device.HourArchiveAddressMap', 'Карта адресов часовых архивов', 'String', 1, 1, '_', NULL),
  (189, 'MeasurementDevice', 'Device.DayArchiveAddressMap', 'Карта адресов суточных архивов', 'String', 1, 1, '_', NULL),
  (190, 'MeasurementDevice', 'Device.ReadRealTimeData', 'Чтение данных в режиме реального времени', 'Boolean', 0, 0, 'true', NULL),
  (191, 'MeasurementDevice', 'Device.Tem.FlashType', 'Объем памяти', 'Int32', 0, 0, '1', @temFlashType),
  (192, 'AccessPoint', 'AccessPoint.WiznetCommandPort', 'Командный порт Wiznet', 'Int32', 0, 0, '50001', NULL),
  (193, 'MeasurementDevice', 'Device.DayArchiveFailures', 'Список нештаток суточных архивов', 'String', 1, 1, '_', NULL),
  (194, 'MeasurementDevice', 'Device.HourArchiveFailures', 'Список нештаток часовых архивов', 'String', 1, 1, '_', NULL),
  (195, 'MeasurementDevice', 'Device.LastDayArchiveScanAddressResetDate',  'Дата последнего сброса просканированного адреса суточного архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (196, 'MeasurementDevice', 'Device.LastHourArchiveScanAddressResetDate',  'Дата последнего сброса просканированного адреса часового архива', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (197, 'MeasurementDevice', 'Device.WebServiceProvider', 'Провайдер Web-сервиса интеграции', 'Int32', 1, 0, '1', @webServiceProvider),
  (198, 'MeasurementDevice', 'Device.IntegrationDeviceMapping', 'Сопоставление приборов, участвующих в интеграции', 'String', 1, 1, '_', NULL),
  (199, 'MeasurementDevice', 'Device.AnalogValueConvert', 'Правило преобразования аналоговой величины', 'Int32', 0, 0, '0', @analogValueConvert),
  (200, 'MeasurementDevice', 'Device.SecuriryInput1', 'Охранный вход 1', 'Boolean', 0, 0, 'false', NULL),
  (201, 'MeasurementDevice', 'Device.SecuriryInput2', 'Охранный вход 2', 'Boolean', 0, 0, 'false', NULL),
  (202, 'MeasurementDevice', 'Device.Output1', 'Выход 1', 'Boolean', 0, 0, 'false', NULL),
  (203, 'MeasurementDevice', 'Device.Output2', 'Выход 2', 'Boolean', 0, 0, 'false', NULL),
  (204, 'MeasurementDevice', 'Device.LoraWanDevEui', 'Идентификатор устройства LoraWan', 'String', 0, 0, '_', NULL),
  (205, 'MeasurementDevice', 'Device.AnalogValueArchiveType', 'Тип периода аналоговой величины', 'Int32', 0, 0, '0', @analogValueArchiveType),
  (206, 'DeviceReader', 'DeviceReader.WebSocketIpAddress', 'IP-адрес WebSocket', 'String', 0, 0, '192.168.0.1', NULL),
  (207, 'DeviceReader', 'DeviceReader.WebSocketPort', 'Порт WebSocket', 'Int32', 0, 0, '2780', NULL),
  (208, 'DeviceReader', 'DeviceReader.Login', 'Логин', 'String', 0, 0, '_', NULL),
  (209, 'DeviceReader', 'DeviceReader.Password', 'Пароль', 'String', 0, 0, '_', NULL),
  (210, 'MeasurementDevice', 'Device.CriticalAnalogValueChange', 'Критическое изменение аналог. величины', 'Decimal', 1, 0, '1', NULL),
  (211, 'MeasurementDevice', 'Device.DeviceSettingUpdateDate',  'Дата обновления настроечных параметров', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (212, 'MeasurementDevice', 'Device.RegParamsLastSyncTime',  'Дата последней синхронизации регуляционных параметров', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (213, 'MeasurementDevice', 'Device.DanfossMCX.Key', 'Ключ-приложение', 'Int32', 1, 0, '1', @danfossMcxKey),
  (214, 'MeasurementDevice', 'Device.Psch_4TM_5MK_Number', 'Номер версии прибора', 'Int32', 1, 0, '22', @psch4tm5mkNumber),
  (215, 'MeasurementDevice', 'Device.Ecl110.Key', 'Ключ-приложение', 'Int32', 1, 0, '1', @ecl110Key),
  (216, 'MeasurementDevice', 'Device.ReportHour', 'Отчетный час', 'Int32', 1, 1, '23', NULL),
  (217, 'MeasurementDevice', 'Device.ImpulseInput1', 'Импульсный вход 1', 'Boolean', 0, 0, 'false', NULL),
  (218, 'MeasurementDevice', 'Device.ImpulseInput2', 'Импульсный вход 2', 'Boolean', 0, 0, 'false', NULL),
  (219, 'MeasurementDevice', 'Device.ImpulseInput3', 'Импульсный вход 3', 'Boolean', 0, 0, 'false', NULL),
  (220, 'MeasurementDevice', 'Device.ImpulseInput4', 'Импульсный вход 4', 'Boolean', 0, 0, 'false', NULL),
  (221, 'MeasurementDevice', 'Device.ImpulseWeight1', 'Вес импульса, вход 1 (имп/м3)', 'Int32', 0, 0, '1', NULL),
  (222, 'MeasurementDevice', 'Device.ImpulseWeight2', 'Вес импульса, вход 2 (имп/м3)', 'Int32', 0, 0, '1', NULL),
  (223, 'MeasurementDevice', 'Device.ImpulseWeight3', 'Вес импульса, вход 3 (имп/м3)', 'Int32', 0, 0, '1', NULL),
  (224, 'MeasurementDevice', 'Device.ImpulseWeight4', 'Вес импульса, вход 4 (имп/м3)', 'Int32', 0, 0, '1', NULL),
  (225, 'MeasurementDevice', 'Device.ArchiveLastTimeStamp', 'Дата последнего архива', 'Int32', 1, 1, '0', NULL),
  (226, 'MeasurementDevice', 'Device.Channel1Id', 'ID канала 1', 'Int32', 1, 0, '1', NULL),
  (227, 'MeasurementDevice', 'Device.CI13Mercury206.1.Id', 'ID связанного Меркурия 206 (№1)', 'Int32', 1, 0, '0', NULL),
  (228, 'MeasurementDevice', 'Device.CI13Mercury206.2.Id', 'ID связанного Меркурия 206 (№2)', 'Int32', 1, 0, '0', NULL),
  (229, 'MeasurementDevice', 'Device.CI13Mercury206.3.Id', 'ID связанного Меркурия 206 (№3)', 'Int32', 1, 0, '0', NULL),
  (230, 'MeasurementDevice', 'Device.CI13Mercury206.4.Id', 'ID связанного Меркурия 206 (№4)', 'Int32', 1, 0, '0', NULL),
  (231, 'MeasurementDevice', 'Device.CI13Mercury206.5.Id', 'ID связанного Меркурия 206 (№5)', 'Int32', 1, 0, '0', NULL),
  (232, 'MeasurementDevice', 'Device.CI13Mercury206.6.Id', 'ID связанного Меркурия 206 (№6)', 'Int32', 1, 0, '0', NULL),
  (233, 'MeasurementDevice', 'Device.StartValuesDescription', 'Описание стартовых значений прибора', 'String', 0, 1, '_', NULL),
  (234, 'MeasurementDevice', 'Device.TimeOutBeforeSend', 'Задержка между пакетами, сек', 'Int32', 0, 0, '0', NULL),
  (235, 'MeasurementDevice', 'Device.LastSumArchiveTimeSystem1', 'Время последних тотальных архивов, теплосистема №1', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (236, 'MeasurementDevice', 'Device.LastSumArchiveTimeSystem2', 'Время последних тотальных архивов, теплосистема №2', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL),
  (237, 'MeasurementDevice', 'Device.LastSumArchiveTimeSystem3', 'Время последних тотальных архивов, теплосистема №3', 'DateTime', 1, 1, '0001-01-01T00:00:00', NULL)

  --([Id], [EntityTypeName], [Code], [Description], [Type], [IsDefault], [IsReadOnly], [DefaultValue], [Descriptor])
GO

SET IDENTITY_INSERT [Dictionaries].[DynamicParameter] OFF;
GO