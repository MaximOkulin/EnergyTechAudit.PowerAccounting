﻿SET IDENTITY_INSERT [Core].[ReportPluginSelector] ON;
GO

INSERT INTO [Core].[ReportPluginSelector] ([Id], [ReportId], [PredicateExpression], [TypeName])
VALUES
	(1, 32, '1 == 1', 'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.UnitedAccountingParamSheetPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(2, 33, '1 == 1', 'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ResourceReleaseBalanceSheetPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(3, 35, 'None is None', 'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.HeatEnergyConsumptionAnalysisPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

    --плагины для новых обобщенных отчетов
    (33, 105, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(35, 106, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(37, 103, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(38, 104, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(45, 101, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(46, 102, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(53, 107, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (105, 109, N'(IsIntegralArchiveValue in ["1"])',
     N'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(56, 22, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(32, 109, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(108, 110,'(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(110, 111,'(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(114, 113, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(116, 115, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(119, 116, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(122, 117,  '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(125, 119,'(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(127, 120,'(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(132, 98,'(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(134, 121, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(136, 18, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(140, 100, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(171, 123, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- Добавление поля ErrorInfo для отчетов приборов с дифференциальными архивами
	(62, 101, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(66, 102, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(67, 105, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(69, 106, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(71, 103, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(73, 104, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(75, 107, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(96, 109, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(111, 111,  '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(117, 115, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(120, 116, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(123, 117, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(135, 121, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(137, 18,  '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(172, 123, '(IsIntegralArchiveValue in ["0"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ErrorInfoSupportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- приборный отчет по электрической энергии
	(59, 108, '(IsIntegralArchiveValue in ["1"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.DiffCalculatorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- плагины КМ5/РМ5
	(34, 105, '(DeviceCode in ["KM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(36, 106, '(DeviceCode in ["KM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(39, 103, '(DeviceCode in ["KM5"] and (ChannelTemplateId not in ["102","103"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(40, 104, '(DeviceCode in ["KM5"] and (ChannelTemplateId not in ["102","103"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(47, 101, '(DeviceCode in ["KM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(48, 102, '(DeviceCode in ["KM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(54, 107, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(97, 109,  '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(138, 18,  '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

    -- островной плагин для ТЭМов
    (158, 101, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (159, 102, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (156, 103, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (157, 104, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (154, 105, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (155, 106, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (160, 107, '(DeviceCode in ["Tem104","Tem104_Tesmart","Tem106","Tesma106","Tem116"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IslandDataSourceReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),    

	-- обработчик ошибок для КМ5/РМ5
	(60, 101, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(61, 102, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(68, 105, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(70, 106, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(72, 103, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(74, 104, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(76, 107, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(98, 109,  '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(139, 18, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- прибавка стартового значения для импульсного входа (ХВС)
	(118, 107, '(DeviceCode in ["KM5","RM5"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Km5ImpulseCwsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- обработчики ошибок для ВКТ-7
	(77, 101, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(78, 102, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(79, 105, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(80, 106, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(81, 103, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(82, 104, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(83, 107, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(99, 109, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(168, 115, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(173, 123, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ErrorsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(84, 101, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(85, 102, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(86, 105, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(87, 106, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(88, 103, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(89, 104, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(90, 107, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(100, 109, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(169, 115, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(174, 123, '(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7InfoPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- плагины ТВ7
	(41,105,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["Hws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(42,106,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["Hws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(49, 101,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["HeatSys"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(50, 102,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["HeatSys"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(101, 109,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["HeatSys"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(10, 22,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["HeatSysMix"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(109, 107,
	'(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["Cws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- плагины Взлет-33/34/22/23 (нарастающим итогом - нужно добавлять одну секунду к времени)
	(43, 105,
	'(DeviceCode in ["VZLJOT_022-023","VZLJOT_033-034"]) and (ResourceSystemTypeCode in ["Hws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VzljotReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(44, 106,
	'(DeviceCode in ["VZLJOT_022-023","VZLJOT_033-034"]) and (ResourceSystemTypeCode in ["Hws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VzljotReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- ЦО с объемом и без (101, 102) + ХВС (107) + Подпитка ЦО (109)
	(51, 101,
	'(DeviceCode in ["VZLJOT_033-034","VZLJOT_022-023","VZLJOT_043","VZLJOT_025"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VzljotReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(52, 102,
	'(DeviceCode in ["VZLJOT_033-034","VZLJOT_022-023","VZLJOT_043","VZLJOT_025"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VzljotReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(55, 107,
	'(DeviceCode in ["VZLJOT_033-034","VZLJOT_022-023","IVK102"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VzljotReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(102, 109,
	'(DeviceCode in ["VZLJOT_033-034","VZLJOT_022-023","IVK102","VZLJOT_043","VZLJOT_025"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VzljotReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- плагины для Взлетов-24/24М/26М (дифференсами - нужно вычитать часовую, минутную и секундную компоненты, т.к. дифференс за текущий день)
	--ГВС с объемом и без
	(57, 105,
	'(DeviceCode in ["VZLJOT_024","VZLJOT_024M","VZLJOT_026M"]) and (ResourceSystemTypeCode in ["Hws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot26MReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(58, 106,
	'(DeviceCode in ["VZLJOT_024","VZLJOT_024M","VZLJOT_026M"]) and (ResourceSystemTypeCode in ["Hws"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot26MReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- ЦО с объемом и без
	(63, 101,
	'(DeviceCode in ["VZLJOT_024","VZLJOT_024M","VZLJOT_026M"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot26MReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(64, 102,
	'(DeviceCode in ["VZLJOT_024","VZLJOT_024M","VZLJOT_026M"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot26MReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- ХВС
	(65, 107,
	'(DeviceCode in ["VZLJOT_024","VZLJOT_024M","VZLJOT_026M"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot26MReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- Подпитка ЦО
	(103, 109,
	'(DeviceCode in ["VZLJOT_024","VZLJOT_024M","VZLJOT_026M"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot26MReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- плагины СПТ943 (941.10(11))
	-- ЦО
	(91, 101, '(DeviceCode in ["Spt943","Spt941_10_11","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(92, 102, '(DeviceCode in ["Spt943","Spt941_10_11","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- ГВСЦ
	(93, 105, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(94, 106, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- ГВС тупиковая
	(106, 103, '(DeviceCode in ["Spt943","Spt941_10_11","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(107, 104, '(DeviceCode in ["Spt943","Spt941_10_11","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- ХВС
	(95, 107, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	-- Подпитка ЦО
	(104, 109, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(121, 116, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(124, 117, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Spt94xPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- Учет сточных вод (V1-V2)
	(113, 107, '(DeviceCode in ["Spt941_10_11","Spt943","Spt941_20"]) and (ChannelTemplateId in ["2024"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VolumeDifferencePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- EK 270
	-- Газовая система
	(112, 111,
	'(DeviceCode in ["EK270"]) and (ResourceSystemTypeCode in ["Gas"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.RemoveHourInDayArchivePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(129, 8,
	'(DeviceCode in ["EK270"]) and (ResourceSystemTypeCode in ["Gas"]) and (ChannelTemplateId in ["5003","5004","5005"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Ek270DaySheetViaHourPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- Часовые профили
	-- Электричество
	(115, 114, 
	'(DeviceCode in ["CET_4TM_03M","Mercury230","Mercury234","PSCH_4TM_05MK"]) and (PeriodTypeCode in ["Hour"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ElectroSysPowerProfilePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(131, 99, 
	'(DeviceCode in ["CE301"]) and (PeriodTypeCode in ["Hour"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.EnergomeraPowerProfilePlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(133, 98,
	'(DeviceCode in ["CE301"]) and (PeriodTypeCode in ["Day"]) and (ChannelTemplateId in ["88"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ElectroSysCalculateWithDesignFactorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(126, 119,
	'(DeviceCode in ["Mercury230","Mercury234"]) and (PeriodTypeCode in ["Day"]) and (ChannelTemplateId in ["31","65"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ElectroSysCalculateWithDesignFactorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	(128, 120,
	'(DeviceCode in ["CET_4TM_03M","PSCH_4TM_05MK"]) and (PeriodTypeCode in ["Day"]) and (ChannelTemplateId in ["10","193"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ElectroSysCalculateWithDesignFactorPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),


	(130, 9,
	'(DeviceCode in ["Mercury230","CET_4TM_03M","Mercury234"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ElectroSysWorkingDayGraphPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),


	-- ИРВИС (заводской отчет)
	(142, 10,
	'(DeviceCode in ["Irvis"]) and (ChannelTemplateId in ["96"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IrvisFactoryReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    -- ИРВИС УЛЬТРА (заводской отчет)
	(163, 11,
	'(DeviceCode in ["Irvis"]) and (ChannelTemplateId in ["96"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.IrvisFactoryReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

	-- Формирование SummaryDataTable для отчетов ВКТ
	(143, 105, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(144, 106, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(148, 103, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(149, 104, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(150, 101, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(151, 102, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(152, 109, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(153, 107, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (165, 100, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(170, 115, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(175, 123, 
	'(DeviceCode in ["VKT7"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7SummaryDataPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),


	(145, 25, '1 == 1',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ForSummaryParamSheetsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(146, 26, '1 == 1',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ForSummaryParamSheetsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(147, 27, '1 == 1',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vkt7ForSummaryParamSheetsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

--  Нештатные ситуации в ведомости учета ресурсов
    (161, 36, '(DeviceCode in ["Elf"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.ElfEmergencySituationsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
    (162, 36, '(DeviceCode in ["VZLJOT_025"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Vzljot25EmergencySituationsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
-- Прамер-710 (Почасовые мониторинговые показания)
    (164, 122, '(DeviceCode in ["Pramer710"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.Pramer710ReportPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

-- ВИС.Т (ЦО)
	(166, 101, '(DeviceCode in ["VIST"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VistSheetViaHourPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
	(167, 102, '(DeviceCode in ["VIST"])',
	'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.VistSheetViaHourPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),

-- ТВ7 (Настройки прибора)
   (176, 39, '(DeviceCode in ["TV7"])',
   'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.UniversalDeviceSettingsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport'),
   (177, 40, '(DeviceCode in ["TV7"])',
   'EnergyTechAudit.PowerAccounting.ReportSupport.Plugin.UniversalDeviceSettingsPlugin, EnergyTechAudit.PowerAccounting.ReportSupport')

	
GO
SET IDENTITY_INSERT [Core].[ReportPluginSelector] OFF;
GO