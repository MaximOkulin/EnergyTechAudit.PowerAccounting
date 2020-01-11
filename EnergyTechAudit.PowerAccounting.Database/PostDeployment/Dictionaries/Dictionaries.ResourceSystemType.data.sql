SET IDENTITY_INSERT [Dictionaries].[ResourceSystemType] ON;
GO

INSERT INTO [Dictionaries].[ResourceSystemType]
     ([Id], Code, [Description], [ShortName])
VALUES
     (1, 'Gas', 'Система газоснабжения', 'ГАЗ'),
	 (2, 'Cws', 'Система холодного водоснабжения', 'ХВС'),
	 (3, 'Hws', 'Система горячего водоснабжения', 'ГВС'),
	 (4, 'HeatSys', 'Система теплоснабжения', 'ЦО'),
	 (5, 'ElectroSys', 'Система электроснабжения', 'ЭЛ'),
	 (6, 'Regulator', 'Система регулирования', 'РЕГ'),
	 (8, 'Monitoring', 'Система мониторинга', 'МОН'),
	 (10, 'HeatSysMix', 'Система теплоснабжения смешанная', 'ТС')


GO

SET IDENTITY_INSERT [Dictionaries].[ResourceSystemType] OFF;
GO
