SET IDENTITY_INSERT [Dictionaries].[DeviceReaderType] ON;
GO

INSERT INTO [Dictionaries].[DeviceReaderType] ([Id], [Code], [Description])
VALUES
    (1, 'Client', 'Служба клиентского опроса'),
	(2, 'Bars', 'Служба опроса модемов БАРС'),
	(3, 'Sbt', 'Служба опроса модемов Solaris-SBT'),
	(4, 'Control', 'Служба управления сервисами'),
	(5, 'Delivery', 'Служба рассылки сообщений'),
	(6, 'Meteo', 'Служба сбора метеоданных'),
	(7, 'LersGsm', 'Служба опроса модемов ЛЭРС GSM'),
	(8, 'MultiPortServer', 'Мультипортовая служба опроса'),
	(9, 'EtaGsm', 'Служба опроса GSM-модемов "ЭнергоТехАудит"'),
	(10, 'Tbn', 'Служба опроса модемов ТБН'),
	(11, 'Sirius', 'Служба опроса приборов РЗА "Сириус"'),
	(12, 'PulsarGsm', 'Служба опроса GSM-модемов Пульсар'),
    (13, 'RealTime', 'Служба опроса приборов в реальном времени'),
    (14, 'LoraWAN', 'Служба опроса приборов LoraWAN'),
    (15, 'MobileMessage', 'Служба рассылки сообщений мобильным клиентам')


GO

SET IDENTITY_INSERT [Dictionaries].[DeviceReaderType] OFF;
GO