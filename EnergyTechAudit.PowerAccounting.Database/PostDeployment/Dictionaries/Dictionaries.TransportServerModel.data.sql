SET IDENTITY_INSERT [Dictionaries].[TransportServerModel] ON;
GO

INSERT INTO [Dictionaries].[TransportServerModel] ([Id],[Code],[Description])
VALUES (1, 'None', 'Отсутствует'),
       (2, 'Moxa5110','Moxa NPort 5110'),
	   (3, 'Maestro', 'Maestro'),
	   (4, 'Gammy', 'Гамми (Maestro)'),
	   (5, 'MoxaOnCellG2111', 'Moxa OnCell G2111 (промышленный GSM/GPRS-модем)'),
	   (6, 'Bars02', 'БАРС-02, беспроводной'),
	   (7, 'SbtEthernet', 'Solaris-SBT Ethernet-коммуникатор'),
	   (8, 'Moxa5150A', 'Moxa NPort 5150A'),
	   (9, 'WIZ107SR', 'Wiznet WIZ107SR шлюз между RS232 и Ethernet'),
	   (10, 'WIZ108SR', 'Wiznet WIZ108SR шлюз между RS485 и Ethernet'),
	   (11, 'Bars02PXM', 'БАРС-02-П-Х-М, проводной'),
	   (12, 'Moxa5150', 'Moxa NPort 5150'),
	   (13, 'Bars02WXM', 'БАРС-02-Р-X-M, беспроводной'),
	   (14, 'I7188', 'Контроллер I-7188'),
	   (15, 'Moxa5250A', 'Moxa NPort 5250A'),
	   (16, 'iRZATM2_232', 'iRZ ATM2-232'),
	   (17, 'iRZATM2_485', 'iRZ ATM2-485'),
	   (18, 'LersGsmPlus', 'ЛЭРС GSM Plus'),
	   (19, 'LersGsmLite', 'ЛЭРС GSM Lite'),
	   (20, 'Moxa5650_8', 'Moxa NPort 5650-8'),
	   (21, 'LogikaAds99', 'ЛОГИКА АДС 99'),
	   (22, 'EtaModem', 'GPRS-модем "ЭнергоТехАудит"'),
	   (23, 'iRZ_MC52iT', 'GPRS-модем iRZ MC52iT'),
	   (24, 'Tbn_KSPD5G_old', 'ТБН КСПД-5-G (старая прошивка)'),
	   (25, 'Tbn_KSPD5G_new', 'ТБН КСПД-5-G (новая прошивка)'),
	   (26, 'Virtual', 'Виртуальная точка доступа'),
	   (27, 'PulsarGsmModem', 'GSM/GPRS модем "Пульсар"'),
	   (28, 'Bars02_Old', 'БАРС-02 (старая прошивка)'),
       (29, 'LoraNetServer', 'Lora Net Server'),
	   (30, 'Strij', 'СТРИЖ')

GO
SET IDENTITY_INSERT [Dictionaries].[TransportServerModel] OFF;