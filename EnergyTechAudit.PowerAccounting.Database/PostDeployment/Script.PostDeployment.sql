
EXEC sp_configure 'show advanced options', 1
GO

RECONFIGURE WITH OVERRIDE
GO

sp_configure 'Agent XPs', 1;
GO

-- разрешаем поддержку отправки почтовых уведомлений 
EXEC  sp_configure 'Database Mail XPs', 1
GO

EXEC sp_configure filestream_access_level, 2
GO

EXEC sp_configure 'clr enabled', 1
GO

-- разрешаем поддержку CMDSHELL OS например для 
-- выполнения резервного копирования на сетевые хранилища
EXEC sp_configure 'xp_cmdshell',1
GO


RECONFIGURE
GO

SET DATEFORMAT ymd;
GO

:r CreateSystemAccount.sql
GO

:r CreateDeviceReaderAccount.sql
GO

:r Dictionaries\Dictionaries.BinaryContentType.data.sql
GO

:r Core\Core.Binary.data.sql
GO

:r Core\Core.Binary2.data.sql
GO

:r Core\Core.Binary3.data.sql
GO

:r Core\Core.Binary4.data.sql
GO

:r Core\Core.Binary5.data.sql
GO

:r Core\Core.Binary6.data.sql
GO

:r Core\Core.Binary7.data.sql
GO

:r Core\Core.Binary8.data.sql
GO

:r Core\Core.Binary9.data.sql
GO

:r Core\Core.Binary10.data.sql
GO

:r Core\Core.CommandMenuTemplate.data.sql
GO

:r Core\Core.Processing.data.sql
GO

:r Core\Core.Entity.data.sql
GO
:r Core\Core.EntityProperty.data.sql
GO

:r Core\Core.MapInfoWindow.data.sql
GO

:r Business\Business.EmergencySituationParameterTemplate.data.sql
GO

:r Dictionaries\Dictionaries.NotificationType.data.sql
GO

:r Dictionaries\Dictionaries.ScheduleType.data.sql
GO

:r Dictionaries\Dictionaries.SeasonType.data.sql
GO

:r Dictionaries\Dictionaries.TemperatureProfile.data.sql
GO

:r Dictionaries\Dictionaries.AgreementParameterType.data.sql
GO

:r Dictionaries\Dictionaries.TechnologicAdjunctionType.data.sql
GO

:r Dictionaries\Dictionaries.TransportServerModel.data.sql
GO

:r Dictionaries\Dictionaries.TransportType.data.sql
GO

:r Dictionaries\Dictionaries.DynamicParameter.data.sql
GO

:r Dictionaries\Dictionaries.StatusConnection.data.sql
GO

:r Dictionaries\Dictionaries.PeriodType.data.sql
GO

:r Dictionaries\Dictionaries.PortType.data.sql
GO

:r Dictionaries\Dictionaries.TypeConnection.data.sql
GO

:r Dictionaries\Dictionaries.ResourceSystemType.data.sql
GO

:r Dictionaries\Dictionaries.ResourceSubsystemType.data.sql
GO

:r Dictionaries\Dictionaries.PhysicalParameter.data.sql
GO

:r Dictionaries\Dictionaries.AgreementSystemParameter.data.sql
GO

:r Dictionaries\Dictionaries.Parameter.data.sql
GO

:r Dictionaries\Dictionaries.MeasurementUnit.data.sql
GO

:r Dictionaries\Dictionaries.ProtocolSubType.data.sql
GO

:r Dictionaries\Dictionaries.ErrorType.data.sql
GO

:r Dictionaries\Dictionaries.ParameterDictionary.data.sql
GO

:r Dictionaries\Dictionaries.Dimension.data.sql
GO

:r Dictionaries\Dictionaries.BuildingPurpose.data.sql
GO

:r Dictionaries\Dictionaries.PlacementPurpose.data.sql
GO

:r Dictionaries\Dictionaries.Parity.data.sql
GO

:r Dictionaries\Dictionaries.Baud.data.sql
GO

:r Dictionaries\Dictionaries.StopBit.data.sql
GO

:r Dictionaries\Dictionaries.ComPort.data.sql
GO

:r Dictionaries\Dictionaries.DataBit.data.sql
GO

:r Dictionaries\Dictionaries.OrganizationType.data.sql
GO

:r Dictionaries\Dictionaries.Gender.data.sql
GO

:r Dictionaries\Dictionaries.ProcessingStatus.data.sql
GO

:r Dictionaries\Dictionaries.SubsystemType.data.sql
GO

:r Dictionaries\Dictionaries.City.data.sql
GO

:r Dictionaries\Dictionaries.District.data.sql
GO

:r Dictionaries\Dictionaries.MeteoDataSourceType.data.sql
GO

--создаем структуру для цепочки вокруг конкретного прибора, установленного на объекте
--создаем в словаре приборов запись марки прибора
:r Dictionaries\Dictionaries.Device.data.sql
GO

:r Dictionaries\Dictionaries.Device2.data.sql
GO

:r Dictionaries\Dictionaries.InternalDeviceEvent.data.sql
GO


:r Dictionaries\Dictionaries.ParameterDictionaryValue.data.sql
GO

:r Rules\Rules.DeviceArchiveTimeConverter.data.sql
GO

:r Dictionaries\Dictionaries.DeviceParameter.data.sql
GO

:r Business\Business.DeviceParameterSetting.data.sql
GO

:r Dictionaries\Dictionaries.DeviceEventParameter.data.sql
GO

:r Dictionaries\Dictionaries.DeviceReaderType.data.sql
GO

:r Dictionaries\Dictionaries.MnemoschemeType.data.sql
GO

:r Admin\Admin.Role.data.sql
GO

:r Business\Business.Mnemoscheme.data.sql
GO

:r Business\Business.DeviceLinkDynamicParameter.data.sql
GO

-- шаблоны ГВС
:r Business\ChannelTemplate\Hws\HwsChannelTemplates.data.sql
GO
:r Business\ChannelTemplate\Hws\ParameterMapDeviceParameter.data.sql
GO

-- шаблоны ХВС
:r Business\ChannelTemplate\Cws\CwsChannelTemplates.data.sql
GO

:r Business\ChannelTemplate\Cws\ParameterMapDeviceParameter.data.sql
GO

-- шаблоны ЦО
:r Business\ChannelTemplate\HeatSys\HeatSysChannelTemplates.data.sql
GO
:r Business\ChannelTemplate\HeatSys\ParameterMapDeviceParameter.data.sql
GO

-- Регуляторные шаблоны
:r Business\ChannelTemplate\Regulator\RegulatorChannelTemplates.data.sql
GO
:r Business\ChannelTemplate\Regulator\ParameterMapDeviceParameter.data.sql
GO
-- настройка календарей Реле "ЭнергоТехАудит"
:r Business\ChannelTemplate\Regulator\EtaRelayCalendarParameterMapDeviceParameter.data.sql
GO

-- Шаблоны мониторинга
:r Business\ChannelTemplate\Monitoring\MonitoringChannelTemplates.data.sql
GO
:r Business\ChannelTemplate\Monitoring\ParameterMapDeviceParameter.data.sql
GO

-- шаблоны электро

:r Business\ChannelTemplate\Electro\ElectroChannelTemplates.data.sql
GO

:r Business\ChannelTemplate\Electro\ParameterMapDeviceParameter.data.sql
GO

-- шаблоны газоснабжения

:r Business\ChannelTemplate\Gas\GasChannelTemplates.data.sql
GO

:r Business\ChannelTemplate\Gas\ParameterMapDeviceParameter.data.sql
GO

-- шаблоны метеостанций
:r Business\ChannelTemplate\MeteoStation\MeteoStationChannelTemplates.data.sql
GO

:r Business\ChannelTemplate\MeteoStation\ParameterMapDeviceParameter.data.sql
GO

--создаем шаблон канала прибора ChannelTemplate
:r Business\Business.ChannelTemplate.data.sql
GO

-- 
EXEC [sys].[sp_executesql] @statement =
    
	N'UPDATE [ParameterMapDeviceParameter] 
	SET 
        [ParameterMapDeviceParameter].[CreatedBy] = N''sys'', 
        [ParameterMapDeviceParameter].[UpdatedBy] = N''sys'', 
        [ParameterMapDeviceParameter].[CreatedDate] = ''20140421'',
        [ParameterMapDeviceParameter].[UpdatedDate] = ''20140421''
    FROM [Business].[ParameterMapDeviceParameter];
        
    ALTER TABLE [Business].[ParameterMapDeviceParameter]
        ALTER COLUMN [CreatedBy] NVARCHAR(32) NOT NULL;
    
    ALTER TABLE [Business].[ParameterMapDeviceParameter]
        ALTER COLUMN [UpdatedBy] NVARCHAR(32) NOT NULL;
    
    ALTER TABLE [Business].[ParameterMapDeviceParameter]
        ALTER COLUMN [CreatedDate] DATETIME NOT NULL;
    
    ALTER TABLE [Business].[ParameterMapDeviceParameter]
        ALTER COLUMN [UpdatedDate] DATETIME NOT NULL;';

:r Admin\Admin.UserGroup.data.sql

IF $(DeployTestData) = 1
BEGIN
	:r Admin\Admin.User.data.sql
END

GO
IF $(ClearDeploy) = 1
BEGIN
  :r Admin\Admin.User.data.sql
END
GO

:r Admin\Admin.SystemSetting.data.sql
GO

:r Core\Core.EntityTree.data.sql
GO

:r Core\Core.EntityTreeLinkRole.data.sql
GO

:r Admin\Admin.News.data.sql
GO

:r Admin\Admin.NewsLinkRole.data.sql
GO

:r Admin\Admin.Faq.data.sql
GO

:r Admin\Admin.FaqLinkRole.data.sql
GO


:r Core\Core.MetaObjectType.data.sql
GO

:r Core\Core.Dictionary.data.sql
GO

:r Core\Core.PivotDiagramm.data.sql
GO

:r Core\Core.Diagramm.data.sql
GO

:r Core\Core.ReportType.data.sql
GO

:r Core\Core.Report.data.sql
GO

:r Core\Core.ReportSelector.data.sql
GO

:r Core\Core.ReportPluginSelector.data.sql
GO

:r Core\Core.Pivot.data.sql
GO

:r Core\Core.Query.data.sql
GO

:r Core\Core.Form.data.sql
GO

:r Core\Core.Source.data.sql
GO

:r Core\Core.Parametric.data.sql
GO


:r Core\Core.MetaObject.data.sql
GO

:r Core\Core.MetaObjectLinkDevice.data.sql
GO

:r Core\Core.MetaObjectLinkRole.data.sql
GO

:r Core\Core.MetaObjectReferenceMeasurementDevice.data.sql

GO

:r Core\Core.Menu.data.sql
GO

:r Core\Core.MenuItem.data.sql
GO

:r Core\Core.DashboardExtentionTemplate.data.sql
GO

:r Help\Help.Article.data.sql

GO

:r Help\Help.Picture.data.sql

GO

:r Core\Core.GoogleMapsStyle.data.sql

GO
:r Rules\Rules.MeasurementUnitConverter.data.sql

GO

:r Admin\Admin.Alert.data.sql

GO

:r Rules\Rules.DefaultMeasurementUnit.data.sql

GO

:r Core\Core.Script.data.sql

GO

:r CreateDatabaseMail.sql
GO

:r CreateJobsOperator.sql
GO

:r CreateHourlyJobs.sql
GO

:r CreateDailyJobs.sql
GO

:r CreateWeeklyJobs.sql
GO

:r CreateMonthlyJobs.sql
GO

:r CreateSystemBackup.sql
GO

ALTER DATABASE [EnergyTechAudit.PowerAccounting.Database]
  SET 
	ALLOW_SNAPSHOT_ISOLATION ON,
	COMPATIBILITY_LEVEL = 130;
GO

:r CreateDeadlockMonitor.sql
GO

:r CreateSystemStartup.sql
GO

