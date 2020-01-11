SET IDENTITY_INSERT [Core].[Form] ON;
GO

:setvar xmlQuote "'"

DECLARE @placementFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\PlacementForm.xml
$(xmlQuote)

DECLARE @channelFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\ChannelForm.xml
$(xmlQuote)

DECLARE @buildingFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\BuildingForm.xml
$(xmlQuote)

DECLARE @accessPointFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\AccessPointForm.xml
$(xmlQuote)

DECLARE @measurementDeviceFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\MeasurementDeviceForm.xml
$(xmlQuote)

DECLARE @userFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\UserForm.xml
$(xmlQuote)

DECLARE @userAdditionalInfoFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\UserAdditionalInfoForm.xml
$(xmlQuote)

DECLARE @hubFormXml NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Xml\Forms\HubForm.xml
$(xmlQuote)

DECLARE @channelTemplateFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\ChannelTemplateForm.xml
$(xmlQuote)

DECLARE @measurementUnitConverterFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\MeasurementUnitConverterForm.xml
$(xmlQuote)

DECLARE @alertFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\AlertForm.xml
$(xmlQuote)

DECLARE @csdModemFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\CsdModemForm.xml
$(xmlQuote)

DECLARE @deviceReaderFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\DeviceReaderForm.xml
$(xmlQuote)

DECLARE @organizationFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\OrganizationForm.xml
$(xmlQuote)


DECLARE @newsFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\NewsForm.xml
$(xmlQuote)

DECLARE @checkingAccountFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\CheckingAccountForm.xml
$(xmlQuote)

DECLARE @faqFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\FaqForm.xml
$(xmlQuote)

DECLARE @systemSettingFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\SystemSettingForm.xml
$(xmlQuote)

DECLARE @agreementParameter NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\AgreementParameter.xml
$(xmlQuote)

DECLARE @emergencySituationParameter NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\EmergencySituationParameter.xml
$(xmlQuote)

DECLARE @scheduleItemFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\ScheduleItemForm.xml
$(xmlQuote)

DECLARE @archiveDownloaderFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\ArchiveDownloaderForm.xml
$(xmlQuote)

DECLARE @mnemoschemeFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\MnemoschemeForm.xml
$(xmlQuote)

DECLARE @userGroupFormXml NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Xml\Forms\UserGroupForm.xml
$(xmlQuote)

INSERT INTO [Core].[Form] ([Id],[Code],[Description], [LinkedEntityTypeName], [Layout], [ReadOnly])
  VALUES
  (29, 'UserGroupForm', 'Группы пользователей', 'UserGroup',  @userGroupFormXml, 0),

  (28, 'MnemoschemeForm', 'Мнемосхемы', 'Mnemoscheme', @mnemoschemeFormXml, 0),

  (27, 'ArchiveDownloaderForm', 'Оператор выгрузки', 'ArchiveDownloader', @archiveDownloaderFormXml, 0),

  (26, 'ScheduleItemForm', 'Элемент расписания', 'ScheduleItem', @scheduleItemFormXml, 0),
  
  (25, 'EmergencySituationParameter', 'Параметр нештатной ситуации', 'EmergencySituationParameter', @emergencySituationParameter, 0),

  (24, 'AgreementParameter', 'Договорной параметр', 'AgreementParameter', @agreementParameter, 0),

  (23, 'SystemSettingForm', 'Параметры системы', 'SystemSetting', @systemSettingFormXml, 0),

  (22, 'FaqForm', 'Часто задаваемые вопросы', 'Faq', @faqFormXml, 0),

  (21, 'CheckingAccountForm', 'Расчетные счета', 'CheckingAccount', @checkingAccountFormXml, 0),

  (20, 'NewsForm', 'Новости', 'News', @newsFormXml, 0),

  (19, 'OrganizationForm', 'Организации', 'Organization', @organizationFormXml, 0),

  (17, 'DeviceReaderForm', 'Считыватели устройств', 'DeviceReader', @deviceReaderFormXml, 0),

  (16, 'CsdModemForm', 'CSD-модемы', 'CsdModem', @csdModemFormXml, 0),

  (15, 'AlertForm', 'Уведомления пользователям', 'Alert', @alertFormXml, 0),

  (14, 'MeasurementUnitConverterForm', 'Правила преобразования единиц измерения', 'MeasurementUnitConverter', @measurementUnitConverterFormXml, 0),

  (13, 'ChannelTemplateForm', 'Шаблоны измерительных каналов', 'ChannelTemplate', @channelTemplateFormXml, 0),

  (11, 'Hub', 'Концентраторы', 'Hub', @hubFormXml, 0),

  (10, 'UserAdditionalInfo', 'Сведения о пользователях', 'UserAdditionalInfo', @userAdditionalInfoFormXml, 0),

  (9, 'UserForm', 'Пользователи', 'User', @userFormXml, 0),

  (5, 'PlacementForm', 'Помещения', 'Placement', @placementFormXml, 0),

  (4, 'ChannelForm', 'Каналы', 'Channel', @channelFormXml, 0),
	
  (3, 'BuildingForm', 'Строения', 'Building', @buildingFormXml, 0),
	
  (2, 'AccessPointForm', 'Точки доступа', 'AccessPoint', @accessPointFormXml, 0),

  (1, 'MeasurementDeviceForm', 'Измерительные устройства', 'MeasurementDevice', @measurementDeviceFormXml, 0)
  
GO

SET IDENTITY_INSERT [Core].[Form] OFF;
GO
