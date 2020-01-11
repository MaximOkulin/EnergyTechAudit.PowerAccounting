SET IDENTITY_INSERT [Core].[Parametric] ON;

:setvar xmlQuote "'"

DECLARE @channelDistributionParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\ChannelDistributionParametricDialog.xml
$(xmlQuote)

DECLARE @measurementDeviceDistributionParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\MeasurementDeviceDistributionParametricDialog.xml
$(xmlQuote)

DECLARE @measurementDeviceListForOperAdminParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\MeasurementDeviceListForOperAdminParametricDialog.xml
$(xmlQuote)

DECLARE @measurementDeviceArchiveDataParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\MeasurementDeviceArchiveDataParametricDialog.xml
$(xmlQuote)

DECLARE @measurementDeviceArchiveDataWithoutAllParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\MeasurementDeviceArchiveDataWithoutAllParametricDialog.xml
$(xmlQuote)

DECLARE @buildingAddressDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\BuildingAddressDialog.xml
$(xmlQuote)

DECLARE @measurementDeviceCustomInfoListForOperAdmin NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\MeasurementDeviceCustomInfoListForOperAdmin.xml
$(xmlQuote)

DECLARE @getParametersInfoByDeviceParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetParametersInfoByDeviceParametricDialog.xml
$(xmlQuote)

DECLARE @getAccountingParamSheetPramer710ParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetAccountingParamSheetPramer710ParametricDialog.xml
$(xmlQuote)

DECLARE @getAccountingParamSheetParametricDialog NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetAccountingParamSheetParametricDialog.xml
$(xmlQuote)

DECLARE @doUserLinkChannelParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Processings\DoUserLinkChannelParametricDialog.xml
$(xmlQuote)

DECLARE @parameterMapDeviceParameterParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Maps\ParameterMapDeviceParameterParametricDialog.xml
$(xmlQuote)

DECLARE @multipleToMultipleInfoParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetMultipleToMultipleInfoParametricDialog.xml
$(xmlQuote)

DECLARE @measurementDeviceSignalQualityParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\MeasurementDeviceSignalQualityParametricDialog.xml
$(xmlQuote)

DECLARE @dashboardIntervalSettingsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\DashboardIntervalSettingsParametricDialog.xml
$(xmlQuote)

DECLARE @pivotDiagrammByDeviceParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetPivotDiagrammByDeviceParametricDialog.xml
$(xmlQuote)

DECLARE @pivotDiagrammByDistrictParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetPivotDiagrammByDistrictParametricDialog.xml
$(xmlQuote)

DECLARE @pivotDiagrammByConnectionQualityParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetPivotDiagrammByConnectionQualityParametricDialog.xml
$(xmlQuote)

DECLARE @flatHolderAccountingParamSheetParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetFlatHolderAccountingParamSheetParametricDialog.xml
$(xmlQuote)

DECLARE @archivesParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\ArchivesParametricDialog.xml
$(xmlQuote)

DECLARE @getFlatHolderAccountsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetFlatHolderAccountsParametricDialog.xml
$(xmlQuote)

DECLARE @operAdminMapOptionsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\OperAdminMapOptionsParametricDialog.xml
$(xmlQuote)

DECLARE @usersParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\UsersParametricDialog.xml
$(xmlQuote)

DECLARE @selectDynamicParameterParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\SelectDynamicParameterParametricDialog.xml
$(xmlQuote)

DECLARE @flatDevicesConnectionQualityParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\FlatDevicesConnectionQualityParametricDialog.xml
$(xmlQuote)

DECLARE @deleteArchiveParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\DeleteArchiveParametricDialog.xml
$(xmlQuote)

DECLARE @getTv7MeasurementDeviceJournal NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetTv7MeasurementDeviceJournal.xml
$(xmlQuote)

DECLARE @getSummaryAccountingSheetParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetSummaryAccountingSheetParametricDialog.xml
$(xmlQuote)

DECLARE @emergencySituationDistributionParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\EmergencySituationDistributionParametricDialog.xml
$(xmlQuote)

DECLARE @getVzljot26MeasurementDeviceJournal NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetVzljot26MeasurementDeviceJournal.xml
$(xmlQuote)

DECLARE @emergencySituationSummaryParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\EmergencySituationSummaryParametricDialog.xml
$(xmlQuote)

DECLARE @dashboardDiagrammSettingsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\DashboardDiagrammSettingsParametricDialog.xml
$(xmlQuote)

DECLARE @binaryParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\EntitiesParametricDialogs\Binary.xml
$(xmlQuote)

DECLARE @getSystemProtocolsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\GetSystemProtocolsParametricDialog.xml
$(xmlQuote)

DECLARE @doMeasurementDevicePollingIntervalParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Processings\DoMeasurementDevicePollingIntervalParametricDialog.xml
$(xmlQuote)

DECLARE @unitedAccountingParamSheetParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\UnitedAccountingParamSheetParametricDialog.xml
$(xmlQuote)

DECLARE @getResourceReleaseBalanceParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetResourceReleaseBalanceParametricDialog.xml
$(xmlQuote)

DECLARE @buildingMapResourceBuildingParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Maps\BuildingMapResourceBuildingParametricDialog.xml
$(xmlQuote)

DECLARE @getElectroPowerWorkingDayParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetElectroPowerWorkingDayParametricDialog.xml
$(xmlQuote)

DECLARE @getRegulatorsTimeSlicesParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetRegulatorsTimeSlicesParametricDialog.xml
$(xmlQuote)

DECLARE @getHeatEnergyConsumptionAnalysisParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetHeatEnergyConsumptionAnalysisParametricDialog.xml
$(xmlQuote)

DECLARE @getAccountingParamSheetEmergencySituationsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetAccountingParamSheetEmergencySituations.xml
$(xmlQuote)

DECLARE @getDeviceSettingsParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetDeviceSettingsParametricDialog.xml
$(xmlQuote)

DECLARE @getIndividualAccountingBalanceSheetParametricDialog NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\ParametricDialogs\Reports\GetIndividualAccountingBalanceSheetParametricDialog.xml
$(xmlQuote)

INSERT INTO [Core].[Parametric] ([Id], [Code], [Description], [Template])
VALUES       
	  	
   (2, NULL, 'Распределение каналов измерительных приборов', @channelDistributionParametricDialog)
	
   ,(5, NULL, NULL, @measurementDeviceListForOperAdminParametricDialog)
	
   ,(6, NULL, NULL, @measurementDeviceArchiveDataParametricDialog)
	
   ,(7, NULL, NULL, @measurementDeviceArchiveDataWithoutAllParametricDialog)
	
   ,(8, 'BuildingAddressDialog', 'Шаблон параметрика для ручного редактирования адресных данных', @buildingAddressDialog)
	
   ,(9, NULL, 'Шаблон параметрика для супергрида КОА',  @measurementDeviceCustomInfoListForOperAdmin)
	
   ,(10, NULL, 'Парамерик для выбора типа измерительного прибора', @getParametersInfoByDeviceParametricDialog) 
	
   ,(11, 'GetAccountingParamSheetParametricDialog', 'Ведомость учета параметров', @getAccountingParamSheetParametricDialog)
	   
   ,(14, 'DoUserLinkChannelParametricDialog', 'Обработка назначения пользователям каналов', @doUserLinkChannelParametricDialog)

   ,(15, 'ParameterMapDeviceParameterParametricDialog', 'Параметрик для создания ассоциации параметров', @parameterMapDeviceParameterParametricDialog)

	,(16, 'MultipleToMultipleInfoParametricDialog', 'Анализ связей мноние-ко-многим', @multipleToMultipleInfoParametricDialog)

   ,(17, 'MeasurementDeviceSignalQualityParametricDialog', 'Параметрик для выбора параметров отчета Качество связи', @measurementDeviceSignalQualityParametricDialog)
   
   ,(18, 'DashboardIntervalSettingsParametricDialog', 'Параметрик для выбора временного диапазона дашборда', @dashboardIntervalSettingsParametricDialog)

   ,(19, 'PivotDiagrammByDeviceParametricDialog', 'Параметрик для выбора района для сводной диаграммы', @pivotDiagrammByDeviceParametricDialog)

   ,(20, 'PivotDiagrammByDistrictParametricDialog', 'Параметрик для выбора типа устройства для сводной диаграммы', @pivotDiagrammByDistrictParametricDialog)

   ,(21, 'PivotDiagrammByConnectionQualityParametricDialog', 'Параметрик для выбора типа района и устройства для сводной диаграммы', @pivotDiagrammByConnectionQualityParametricDialog)
   
   ,(22, 'GetFlatHolderAccountingParamSheetParametricDialog', 'Параметрик для выбора канала прибора квартирного учета', @flatHolderAccountingParamSheetParametricDialog)

   ,(23, 'ArchivesParametricDialog', 'Параметрик для сводной таблицы Архивы', @archivesParametricDialog)
   
   ,(24, 'GetFlatHolderAccountsParametricDialog', 'Параметрик для сводной таблицы Архивы', @getFlatHolderAccountsParametricDialog)

   ,(25, 'OperAdminMapOptionsParametricDialog', 'Параметрик настроек для карт операционного администратора', @operAdminMapOptionsParametricDialog)

   ,(26, 'UsersParametricDialog', 'Список пользователей системы', @usersParametricDialog)

   ,(27, 'SelectDynamicParameterParametricDialog', 'Выбор динамического параметров', @selectDynamicParameterParametricDialog)

   ,(28, 'FlatDevicesConnectionQualityParametricDialog', 'Параметрик для выбора параметров отчета Качество связи квартирных приборов', @flatDevicesConnectionQualityParametricDialog)
   
   ,(29, NULL, 'Распределение измерительных приборов', @measurementDeviceDistributionParametricDialog)

   ,(30, 'DeleteArchiveParametricDialog', 'Критериальное удаление архивов', @deleteArchiveParametricDialog)

   ,(31, 'GetTv7MeasurementDeviceJournal', 'Асинхронные архивы ТВ7', @getTv7MeasurementDeviceJournal)

   ,(32, 'GetSummaryAccountingSheetParametricDialog', 'Сводный отчет по вводным приборам учета', @getSummaryAccountingSheetParametricDialog)

   ,(33, 'EmergencySituationDistributionParametricDialog', 'Параметры нештатных ситуаций', @emergencySituationDistributionParametricDialog)

   ,(34, 'GetVzljot26MeasurementDeviceJournal', 'Журналы Взлет-26(М)', @getVzljot26MeasurementDeviceJournal)

   ,(35, 'EmergencySituationSummaryParametricDialog', 'Сводный отчет о нештатных ситуациях', @emergencySituationSummaryParametricDialog)

   ,(36, 'DashboardDiagrammSettingsParametricDialog', 'Настройки диаграмм дашборда', @dashboardDiagrammSettingsParametricDialog)

   ,(37, 'EnergyTechAudit.PowerAccounting.Domain.Models.Core.Binary', 'Бинуарий', @binaryParametricDialog)

   ,(38, 'GetSystemProtocolsParametricDialog', 'Протоколы системы', @getSystemProtocolsParametricDialog)

   ,(39, 'DoMeasurementDevicePollingIntervalParametricDialog', 'Обработка изменения интервала опроса устройств', @doMeasurementDevicePollingIntervalParametricDialog)
   
   ,(40, 'UnitedAccountingParamSheetParametricDialog', 'Объединенная ведомость учета параметров', @unitedAccountingParamSheetParametricDialog)

   ,(41, 'GetResourceReleaseBalanceParametricDialog', 'Ведомость баланса отпуска ресурсов', @getResourceReleaseBalanceParametricDialog)

   ,(42, 'BuildingMapResourceBuildingParametricDialog', 'Параметрик создания ассоциации строения', @buildingMapResourceBuildingParametricDialog)

   ,(43, 'GetElectroPowerWorkingDayParametricDialog', 'Параметрик выбора даты и диапазон часов, в которых необходимо анализировать максимальное потребление мощности', @getElectroPowerWorkingDayParametricDialog)

   ,(44, 'GetRegulatorsTimeSlicesParametricDialog', 'Параметрик  отчета временных срезов по показаниям контроллеров регулирования', @getRegulatorsTimeSlicesParametricDialog)

   ,(45, 'GetHeatEnergyConsumptionAnalysisParametricDialog', 'Параметрик  отчета анализ потребления тепловой энергии', @getHeatEnergyConsumptionAnalysisParametricDialog)

   ,(46, 'GetAccountingParamSheetEmergencySituationsParametricDialog', 'Параметрик отчета "Нештатные ситуации ведомостей учета ресурсов"', @getAccountingParamSheetEmergencySituationsParametricDialog)

   ,(47, 'GetDeviceSettingsParametricDialog', 'Параметрик отчета "Настроечные параметры прибора"', @getDeviceSettingsParametricDialog)

   ,(48, 'GetAccountingParamSheetPramer710ParametricDialog', 'Почасовые мониторинговые показания Прамер-710', @getAccountingParamSheetPramer710ParametricDialog)
   
   ,(49, 'GetIndividualAccountingBalanceSheetParametricDialog', 'Балансовая ведомость индивидуальных приборов учета', @getIndividualAccountingBalanceSheetParametricDialog)
GO

SET IDENTITY_INSERT [Core].[Parametric] OFF;
GO