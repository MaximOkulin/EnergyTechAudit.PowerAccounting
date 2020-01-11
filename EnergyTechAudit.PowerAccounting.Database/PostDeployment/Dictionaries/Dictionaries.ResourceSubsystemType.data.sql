SET IDENTITY_INSERT [Dictionaries].[ResourceSubsystemType] ON;
GO

INSERT INTO [Dictionaries].[ResourceSubsystemType]([Id],[Code],[Description],[ResourceSystemTypeId],[ShortName])
VALUES
     (1, 'Hwsc', 'С циркуляцией', 3, 'ГВСЦ'),
	 (2, 'HwscOpened', 'С циркуляцией (открытый водоразбор)', 3, 'ГВСЦо'),
	 (3, 'HwscClosed', 'С циркуляцией (закрытый водоразбор)', 3, 'ГВСЦз'),
	 (4, 'HwsLockup', 'Тупиковая схема', 3, 'ГВС'),
	 (5, 'InsideHouse', 'Внутридомовое теплоснабжение', 4, 'ЦО внутр.дом'),
	 (6, 'CwsForHws', 'ХВС для ГВС', 2, 'ХВС для ГВС'),
	 (7, 'HeatSysMakeup', 'Подпитка ЦО', 4, 'подпитка ЦО'),
	 (8, 'HeatSysBlock', 'Блок ЦО', 4, 'Блок ЦО'),
	 (9, 'Sewage', 'Сточные воды', 2, 'Сточные воды'),
     (10, 'HeatSysWithHwsClosed', 'ЦО+ГВС (закр.)', 4, 'ЦО+ГВС (закр.)')
GO

SET IDENTITY_INSERT [Dictionaries].[ResourceSubsystemType] OFF;