SET IDENTITY_INSERT [Core].[DashboardExtentionTemplate] ON;
GO

:setvar xmlQuote "'"

DECLARE @crLf NVARCHAR(2) = CHAR(10) + CHAR(13);
DECLARE @empty NVARCHAR(1) = '';

DECLARE @vkt7TestExtention NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\DashboardExtentions\VKT7TestExtention.xml
$(xmlQuote)
SET @vkt7TestExtention = REPLACE (@vkt7TestExtention, @crLf, @empty);

DECLARE @km5TestExtention NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\DashboardExtentions\KM5TestExtention.xml
$(xmlQuote)
SET @km5TestExtention = REPLACE (@km5TestExtention, @crLf, @empty);


DECLARE @etaRelayTestExtention NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\DashboardExtentions\ETARelayExtention.xml
$(xmlQuote)
SET @etaRelayTestExtention = REPLACE (@etaRelayTestExtention, @crLf, @empty);

DECLARE @irvisExtention NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\DashboardExtentions\IrvisExtention.xml
$(xmlQuote)
SET @irvisExtention = REPLACE (@irvisExtention, @crLf, @empty);

DECLARE @ecl310Extention NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\DashboardExtentions\ECL310Extention.xml
$(xmlQuote)
SET @ecl310Extention = REPLACE (@ecl310Extention, @crLf, @empty);

DECLARE @vegaTP11Extention NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\DashboardExtentions\VegaTP11Extention.xml
$(xmlQuote)
SET @vegaTP11Extention = REPLACE (@vegaTP11Extention, @crLf, @empty);


INSERT INTO [Core].[DashboardExtentionTemplate] (Id, [Code], [Description], [PredicateExpression], [Template])
VALUES
	(
		1, 'VKT7', 'Плагин расширения дашборда VKT7',
		'None is not None and EntityInfoProvider.MeasurementDeviceInfo.DeviceInfo.Code == "VKT7"',
		@vkt7TestExtention
	),
	(
		2, 'KM5', 'Плагин расширения дашборда KM5',
		'None is not None and EntityInfoProvider.MeasurementDeviceInfo.DeviceInfo.Code == "KM5"',
		@km5TestExtention
	),
	(
		3, 
		'Regulator', 'Плагин расширения дашборда регуляторов ECL110, ECL300, ECL 310, Прамер-710, Danfoss MCX и ПР-200', 
		'None is None and EntityInfoProvider.ResourceSystemTypeId == 6 and EntityInfoProvider.MeasurementDeviceInfo.DeviceInfo.Code in ["ECL300","ECL310","DanfossMCX","ECL110","Pramer710","PR200"]',
		@ecl310Extention
	),
	(
		4, 
		'ETARelay', 'Плагин расширения дашборда ETARelay', 
		'None is None and EntityInfoProvider.ResourceSystemTypeId == 6 and EntityInfoProvider.MeasurementDeviceInfo.DeviceInfo.Code in ["EtaRelay"]',
		@etaRelayTestExtention
	),
	(
		5, 
		'Irvis', 'Плагин расширения дашборда газовых счетчиков Ирвис', 
		'None is None and EntityInfoProvider.ResourceSystemTypeId == 1 and EntityInfoProvider.MeasurementDeviceInfo.DeviceInfo.Code in ["Irvis"]',
		@irvisExtention
	),
    (
		6, 
		'VegaTP11', 'Плагин расширения дашборда устройств LoraWan ВЕГА ТП-11', 
		'None is None and EntityInfoProvider.ResourceSystemTypeId == 6 and EntityInfoProvider.MeasurementDeviceInfo.DeviceInfo.Code in ["VegaTP11"]',
		@vegaTP11Extention
	)
GO

SET IDENTITY_INSERT [Core].[DashboardExtentionTemplate] OFF;
GO