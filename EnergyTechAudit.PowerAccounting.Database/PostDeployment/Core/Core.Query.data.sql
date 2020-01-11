SET IDENTITY_INSERT [Core].[Query] ON;

:setvar xmlQuote "'"

DECLARE @crLf NVARCHAR(2) = CHAR(10) + CHAR(13);


DECLARE @measurementDeviceListForOperAdmin NVARCHAR(MAX) = $(xmlQuote)
:r ..\_Xml\Queries\MeasurementDeviceListForOperAdmin.xml
$(xmlQuote)

INSERT INTO [Core].[Query] ([Id], [Code], [Description], [ExportableOnly], [Template])
VALUES
    (2, 'MeasurementDeviceListForOperAdmin', 'Список диспетчеризируемых приборов', 0, @measurementDeviceListForOperAdmin),
    (3, 'MeasurementDeviceArchiveData', 'Архивные данные прибора', 0, NULL),
    (4, 'MeasurementDeviceCustomInfoListForOperAdmin', 'Измерительные устройства', 0, NULL),
    (5, 'GetParametersInfoByDeviceParametricDialog', 'Список параметров по типу измерительному прибора', 0, NULL),
    (6, 'GetErrorLog', 'Дамп ошибок', 0, NULL),	   
    (7, 'GetMeasurementDeviceSignalQuality', 'Показатели качества связи с приборами', 1, NULL),
    (8, 'GetAudit', 'Журнал аудита', 0, NULL),
    (9, 'GetMultipleToMultipleInfo', 'Анализ связей типа многие-ко-многим', 0, NULL),
    (10, 'GetFlatHolderAccountingParamSheet', 'Показания счетчика квартирного учета', 0, NULL),
    (11, 'Archives', 'Архивы', 0, NULL),
    (12, 'GetUserMessages', 'Сообщения пользователей', 0, NULL),
    (13, 'GetLostMeasurementDevices', 'Измерительные устройства с неверными связями', 0, NULL),
    (14, 'Tv7MeasurementDeviceJournal', 'Асинхронные архивы ТВ7', 0, NULL),
    (15, 'GetChannelsEmergencySituationParameters', 'Параметры нештатных ситуаций', 0, NULL),
    (16, 'Vzljot26MeasurementDeviceJournal', 'Журналы Взлет-26(М)', 0, NULL),
    (17, 'GetSystemProtocols', 'Протоколы системы', 0, NULL)
   GO

SET IDENTITY_INSERT [Core].[Query] OFF;
GO