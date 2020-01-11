

SET IDENTITY_INSERT [Core].[MetaObject] ON;

GO

 INSERT INTO [Core].[MetaObject] ([Id], [MetaObjectTypeId], 
								  [DictionaryId], [PivotId], [QueryId], [ReportId], [FormId], [PivotDiagrammId], [ProcessingId], [DiagrammId],
								  [ParametricId], [SourceId], [IsNotInlineParametric])

 VALUES	
	
		  		
	(7, 4, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 2, 2, 1),			  -- пивник "Распределение каналов измерительных устройств"	

	/* Словари */
	(1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0), 
	(2, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(3, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(4, 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(54, 1, 29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(10, 1, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),		
	(11, 1, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),		
	(12, 1, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),	  -- словарь Населенные пункты  
	(13, 1, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),	  
	(14, 1, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),				   
	(16, 1, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),				   
	(17, 1, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),				   
	(18, 1, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),				   
	(19, 1, 15, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),				   
	(20, 1, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(31, 1, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
	(57, 1, 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),	
	(88, 1, 37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),   -- словарь Источники метеоданных
	(93, 1, 36, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),   -- словарь Районы населенного пункта
	(94, 1, 38, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),   -- словарь Тип технологического присоединения
	/**/

	/* Формы */
	(23, 5, NULL, NULL, NULL, NULL,  1, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Измерительныеу стройства
	(24, 5, NULL, NULL, NULL, NULL,  2, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Точки доступа 	 
	(25, 5, NULL, NULL, NULL, NULL,  3, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Строения 	 
	(26, 5, NULL, NULL, NULL, NULL,  4, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Канальи 	 
	(50, 5, NULL, NULL, NULL, NULL,  13, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Шаблон Канальев
	(27, 5, NULL, NULL, NULL, NULL,  5, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Помещения 
	(32, 5, NULL, NULL, NULL, NULL,  9, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Пользователи
	(33, 5, NULL, NULL, NULL, NULL,  10, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Пользователи
	(35, 5, NULL, NULL, NULL, NULL,  11, NULL, NULL, NULL, NULL, NULL, 0),	-- форма Концентраторы
	(53, 5, NULL, NULL, NULL, NULL,  14, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Правила преобразования единиц измерения
	(55, 5, NULL, NULL, NULL, NULL,  15, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Правила преобразования единиц измерения
	(56, 5, NULL, NULL, NULL, NULL,  16, NULL, NULL, NULL, NULL, NULL, 0),  -- форма CSD-модемы
	(58, 5, NULL, NULL, NULL, NULL,  17, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Считыватели устройств
	(66, 5, NULL, NULL, NULL, NULL,  19, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Организации
	(69, 5, NULL, NULL, NULL, NULL,  20, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Новости
	(70, 5, NULL, NULL, NULL, NULL,  21, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Расчетные счета
	(73, 5, NULL, NULL, NULL, NULL,  22, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Часто задаваемые вопросы
	(75, 5, NULL, NULL, NULL, NULL,  23, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Параметры системы
	(87, 5, NULL, NULL, NULL, NULL,  26, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Элемент расписания
	(89, 5, NULL, NULL, NULL, NULL,  27, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Оператор выгрузки    
	(90, 5, NULL, NULL, NULL, NULL,  28, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Мнемосхемы
	(92, 5, NULL, NULL, NULL, NULL,  29, NULL, NULL, NULL, NULL, NULL, 0),  -- форма Группы пользователей
	(79, 5, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL, NULL, 0),   -- форма "Договорной параметр"
	(80, 5, NULL, NULL, NULL, NULL, 25, NULL, NULL, NULL, NULL, NULL, 0),   -- форма "Параметр нештатной ситуации"
	/**/

	(37, 3, NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, 5, 6, 0),			-- ролевой отчет "Список диспетчеризируемых приборов"	
	(38, 2, NULL, NULL, 2, NULL,  NULL, NULL, NULL, NULL, NULL, 6, 0),		-- ролевая решетка "Список диспетчеризируемых приборов"	
	(39, 2, NULL, NULL, 3, NULL,  NULL, NULL, NULL, NULL, 6, 7, 1),		    -- ролевая решетка "Архивные данные измерительного прибора",	
	(40, 6, NULL, NULL, NULL, NULL,  NULL, 1, NULL, NULL, 19, 17, 1),		-- ролевая диаграмма "Распределение  по типу устройств",	
	(41, 2, NULL, NULL, 4, NULL,  NULL, NULL, NULL, NULL, 9, 8, 0),		    -- Список измерительных приборов для супергрида КОА,
	(42, 3, NULL, NULL, NULL, 7,  NULL, NULL, NULL, NULL, 11, 10, 1),		-- девайсовый отчет "Ведомость учета параметров"
	(43, 2, NULL, NULL, 5, NULL, NULL, NULL, NULL, NULL, 10, 9, 1),		    -- запрос "список соотвествия параметров типу изм. устройства"
	


	/* Обработки */	
	(46, 7, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 14, 13, 1),        -- обработка "Присоединить каналы к пользователю"
	(96, 7, NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 39, 35, 1),		-- обработка "Изменить интервал опроса устройств"
	(49, 7, NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, 11, NULL, 0),       
	/**/

	(47, 2, NULL, NULL, 7, NULL, NULL, NULL, NULL, NULL, 17, 14, 1),        -- запрос "Показатери качества связи с приборами"
	(48, 3, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, 17, 14, 1),        -- отчет "Показатери качества связи с приборами"
	
	(52, 2, NULL, NULL, 9, NULL, NULL, NULL, NULL, NULL, 16, 16, 1),        -- запрос "Анализ связей многие-ко-многим"       

	(60, 6, NULL, NULL, NULL, NULL,  NULL, 2, NULL, NULL, 20, 18, 1),		-- ролевая диаграмма "Распределение  по району",	
	(61, 6, NULL, NULL, NULL, NULL,  NULL, 3, NULL, NULL, 21, 19, 1),		-- ролевая диаграмма "Распределение  по району",

	(62, 2, NULL, NULL, 10, NULL,  NULL, NULL,  NULL,  NULL, 22, 20, 1),	
	(63, 3, NULL, NULL, NULL, 16, NULL, NULL, NULL, NULL, 22, 20, 1), 
	(64, 8, NULL, NULL, NULL, NULL,  NULL, NULL, NULL, 1, 22, 21, 0),

	(65, 2, NULL, NULL, 11, NULL, NULL, NULL, NULL, NULL, 23, 22, 1),       -- запрос "Архивы" в консоли администратора

	(67, 3, NULL, NULL, NULL, 17, NULL, NULL, NULL, NULL, 24, 23, 1),       -- отчет "Ведомость учетных данных пользователей квартирного учета"

	(68, 2, NULL, NULL, 12, NULL, NULL, NULL, NULL, NULL, NULL, 24, 0),

	(71, 3, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, 28, 25, 1),        -- отчет "Качество связи с приборами квартирного учета"

	(72, 4, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, 29, 26, 1),        -- пивник "Распределение измерительных устройств"
    	
	(74, 2, NULL, NULL, 13, NULL, NULL, NULL, NULL, NULL, NULL, 27, 0),     -- запрос "Измерительные устройства без связей"
	
	(76, 3, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL, 31, 28, 1),       -- отчет "Асинхронные архивы ТВ7"

	(77, 2, NULL, NULL, 14, NULL, NULL, NULL, NULL, NULL, 31, 28, 1),       -- запрос "Асинхронные архивы ТВ7"

	(78, 3, NULL, NULL, NULL, 24, NULL, NULL, NULL, NULL, 32, 29, 1),       -- отчет-селектор сводных отчетов по по вводным приборам учета
	
	(81, 3, NULL, NULL, NULL, 29, NULL, NULL, NULL, NULL, 33, 30, 1),       -- отчет "Параметры нештатных ситуаций"
	(82, 2, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 33, 31, 1),       -- запрос "Параметры нештатных ситуаций"
	(83, 3, NULL, NULL, NULL, 30, NULL, NULL, NULL, NULL, 33, 30, 1),       -- отчет "Подключенные оповешения нештатных ситуаций"
	(84, 2, NULL, NULL, 15, NULL, NULL, NULL, NULL, NULL, 33, 31, 1),       -- запрос "Подключенные оповешения нештатных ситуаций"

	(85, 3, NULL, NULL, NULL, 23, NULL, NULL, NULL, NULL, 34, 32, 1),       -- отчет "Журналы Взлет-26(М)"
	(86, 2, NULL, NULL, 16, NULL, NULL, NULL, NULL, NULL, 34, 32, 1),       -- запрос "Журналы Взлет-26(м)"
    
	(91, 3, NULL, NULL, NULL, 31, NULL, NULL, NULL, NULL, 35, 33, 1),       -- сводный отчет о НС

	(95, 2, NULL, NULL, 17, NULL, NULL, NULL, NULL, NULL, 38, 34, 1),		-- запрос Протоколы системы

	(97, 3, NULL, NULL, NULL, 32, NULL, NULL, NULL, NULL, 40, 36, 1),		-- отчет Объединенная ведомость учета параметров 
	(98, 3, NULL, NULL, NULL, 33, NULL, NULL, NULL, NULL, 41, 37, 1),       -- отчет Ведомость баланса отпуска ресурсов
	(99, 3, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, 43, 38, 1),
	(100, 3, NULL, NULL, NULL, 34, NULL, NULL, NULL, NULL, 44, 39, 1),		-- отчет Временной срез по показаниям контроллеров погодозависимого регулирования
	(101, 3, NULL, NULL, NULL, 35, NULL, NULL, NULL, NULL, 45, 40, 1),		-- отчет Анализ потребления тепловой энергии на нужны отопления

    (102, 3, NULL, NULL, NULL, 36, NULL, NULL, NULL, NULL, 46, 47, 1),       -- отчет "Нештатные ситуации отчетных ведомостей"
    (103, 3, NULL, NULL, NULL, 37, NULL, NULL, NULL, NULL, 47, 48, 0),        -- отчет "Настройки прибора"
    (104, 3, NULL, NULL, NULL, 122, NULL, NULL, NULL, NULL, 48, 49, 1),		 -- отчет "Почасовые мониторинговые показания ПРАМЕР-710" 

    (105, 3, NULL, NULL, NULL, 38, NULL, NULL, NULL, NULL, 49, 50, 1),		 -- IndividualAccountingBalanceSheet report 
	(106, 3, NULL, NULL, NULL, 39, NULL, NULL, NULL, NULL, 47, 48, 0)      -- отчет "Настройки ТВ7"
GO

/*(
  [Id], [MetaObjectTypeId], 
  [DictionaryId], [PivotId], [QueryId], [ReportId], [FormId], [ChartId], [ProcessingId], [DiagrammId], 
  [ParametricId], [SourceId], [IsNotInlineParametric]
)*/

/* 
	MetaObjectType
	(1, 'Dictionary', 'Словарь', 1),
	(2, 'Query', 'Запрос', 1),
	(3, 'Report', 'Отчет', 1),
	(4, 'Pivot', 'Сводная таблица', 1),
	(5, 'Form', 'Форма', 1),
	(6, 'PivotDiagramm', 'Сводная диаграмма')
*/

SET IDENTITY_INSERT [Core].[MetaObject] OFF;

GO
