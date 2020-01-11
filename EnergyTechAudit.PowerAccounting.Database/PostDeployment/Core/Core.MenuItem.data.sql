

SET IDENTITY_INSERT [Core].[MenuItem] ON;

GO

INSERT INTO [Core].[MenuItem] ([Id], [MenuId], [MetaObjectId], [Order], [Title], [IconClass], [Visible])
VALUES 	

    /* Словари */
	(1, 1, 1, 10,'Типы соединений', 'font-icon-type-connection font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(2, 1, 2, 20, 'Статусы соединений', 'font-icon-status-connection font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(3, 1, 3, 30, 'Физические величины', 'font-icon-physical-parameter font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(7, 1, 4, 40, 'Единицы измерения', 'font-icon-measurement-unit font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(54, 1, 54, 50, 'Единицы измерения по умолчанию', 'font-icon-default-measurement-unit font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(13, 1, 10, 70, 'Тип договорного параметра', 'font-icon-agreement-parameter-type font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(14, 1, 11, 80, 'Размерности', 'font-icon-dimension font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(15, 1, 12, 90, 'Населенные пункты', 'font-icon-city font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(90, 1, 93, 95, 'Районы населенных пунктов', 'font-icon-district2 font-icon-darkslateblue font-icon-x1_3 indent-right-10px', 1),
	(16, 1, 13, 100, 'Назначения строений', 'font-icon-building-purpose font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(17, 1, 14, 110, 'Модели измерительных устройств', 'font-icon-device font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(19, 1, 16, 130, 'Параметры событий', 'font-icon-device-event-parameter font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(20, 1, 17, 140, 'Величины', 'font-icon-parameter font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(21, 1, 18, 150, 'Тип периода', 'font-icon-period-type font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(22, 1, 19, 160, 'Назначения помещений', 'font-icon-placement-purpose font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(23, 1, 20, 170, 'Типы ресурсных систем', 'font-icon-resource-system-type font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),		
	(91, 1, 94, 175, 'Типы присоединений', 'font-icon-technologic-adjunction-type font-icon-darkslateblue font-icon-x1_3 indent-right-10px', 1),		
	(57, 1, 57, 190, 'Бинарные данные', 'font-icon-binary font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
	(86, 1, 88, 200, 'Источники метеоданных', 'font-icon-meteo-data-source-type font-icon-darkslateblue font-icon-x1_1 indent-right-10px', 1),
		
    /* Формы */
	(66, 5, 66, 10, 'Организации', 'font-icon-organization font-icon-x1_1 font-icon-darkslateblue indent-right-10px', 1),		
	(6, 5, 25, 20,  'Строения', 'font-icon-building font-icon-x1_1 font-icon-color-metrohover indent-right-10px', 1),		
	(28, 5, 27, 30, 'Помещения', 'font-icon-placement font-icon-x1_1 font-icon-darkred indent-right-10px', 1),
	(4, 5, 24, 40,  'Точки доступа', 'font-icon-access-point font-icon-x1_1 font-icon-darkred indent-right-10px', 1),
	(5, 5, 23, 50,  'Измерительные устройства', 'font-icon-measurement-device font-icon-x1_1 font-icon-darkslateblue indent-right-10px', 1),		
	(27, 5, 26, 60, 'Каналы', 'font-icon-channel font-icon-x1_1 font-icon-darkgreen indent-right-10px', 1),				
	(50, 5, 50, 70, 'Шаблоны измерительных каналов', 'font-icon-channel-template font-icon-x1_1 font-icon-limegreen indent-right-10px', 1),					
	(87, 5, 90, 80, 'Мнемосхемы', 'font-icon-mnemoscheme font-icon-x1_1 font-icon-red indent-right-10px', 1),				
	(53, 5, 53, 90, 'Преобразования единиц измерения', 'font-icon-measurement-unit-converter font-icon-x1_1 font-icon-black indent-right-10px', 1),				
	(70, 5, 70, 95, 'Расчетные счета', 'font-icon-checking-account font-icon-x1_1 font-icon-color-tomato indent-right-10px', 1),
	(36, 5, 35, 100, 'Концентраторы', 'font-icon-form2 font-icon-x1_1 font-icon-darkred indent-right-10px', 1),
	(56, 5, 56, 110, 'CSD-модемы', 'font-icon-csd-modem font-icon-x1_1 font-icon-darkred indent-right-10px', 1),			
    
    /* Системные формы */    
	(33, 9, 32, 10, 'Пользователи', 'font-icon-user font-icon-x1_1 font-icon-darkblue  indent-right-10px', 1),
	(89, 9, 92, 20, 'Группы пользователей', 'font-icon-user-group font-icon-black indent-right-10px', 0),
	(34, 9, 33, 30, 'Сведения о пользователях', 'font-icon-user-additional-info font-icon-x1_1 font-icon-darkgreen indent-right-10px', 1),
	(85, 9, 89, 40, 'Операторы выгрузки', 'font-icon-archive-downloader font-icon-x1_1 font-icon-color-default indent-right-10px', 1),
	(55, 9, 55, 50, 'Уведомления пользователям', 'font-icon-alert font-icon-x1_1 font-icon-color-default indent-right-10px', 1),			
	(58, 9, 58, 60, 'Считыватели устройств', 'font-icon-device-reader font-icon-x1_1 font-icon-darkblue indent-right-10px', 1),	
	(69, 9, 69, 70, 'Новости', 'font-icon-news font-icon-x1_1  indent-right-10px', 1),
	(73, 9, 73, 80, 'Часто задаваемые вопросы', 'font-icon-faq font-icon-x1_1 font-icon-color-tomato indent-right-10px', 1),    
	(75, 9, 75, 90, 'Параметры системы', 'font-icon-system-setting font-icon-x1_1 font-icon-color-marine indent-right-10px', 1),

	/* Сводные таблицы */
	(10, 2, 7, 5, 'Распределение каналов измерительных устройств', 'font-icon-pivot font-icon-x1_1 indent-right-10px', 1),
	(72, 2, 72, 4, 'Распределение измерительных устройств', 'font-icon-pivot font-icon-x1_1 indent-right-10px', 1),		

	/* Сводные диаграммы */
	(41, 6, 40, 10, 'Распределение по типу устройства', 'font-icon-pivot-diagramm font-icon-x1_1 indent-right-10px', 1),
	(60, 6, 60, 20, 'Распределение по районам', 'font-icon-pivot-diagramm font-icon-x1_1  indent-right-10px', 1),
	(61, 6, 61, 30, 'Распределение по качеству связи', 'font-icon-pivot-diagramm font-icon-x1_1  indent-right-10px', 1),

	/* Отчеты  */
	(38, 3, 37, 10, 'Диспетчеризируемые приборы', 'font-icon-dispatch-devices font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),    
	(48, 3, 48, 20, 'Показатели качества связи', 'font-icon-signal-quality font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
	(71, 3, 71, 30, 'Показатели качества связи с квартирными приборами', 'font-icon-signal-quality font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 0),
	(79, 3, 81, 40, 'Параметры нештатных ситуаций', 'font-icon-emergency-parameters font-icon-darkslategrey font-icon-x1_3 indent-right-10px', 1),		
	(81, 3, 83, 45, 'Оповещения нештатных ситуаций', 'font-icon-emergency-notification font-icon-darkslategrey font-icon-x1_3 indent-right-10px', 1),		
	(63, 3, 63, 50, 'Ведомость прибора квартирного учета', 'font-icon-apartment-building font-icon-darkslategrey indent-right-10px', 1),
	(67, 3, 67, 55, 'Ведомость учетных данных квартирного учета', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
	(76, 3, 76, 60, 'Журналы ТВ7', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
	(83, 3, 85, 70, 'Журналы Взлёт-026', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),	  	
	(94, 3, 97, 75, 'Объединенная ведомость учета', 'font-icon-united-accounting-sheet-chp font-icon-indigo font-icon-x1_3 indent-right-10px', 1),		
	(42, 3, 42, 80, 'Ведомость учета параметров', 'font-icon-accounting-sheet font-icon-tomato font-icon-x1_3 indent-right-10px', 1),		
	(95, 3, 98, 77, 'Баланс отпуска ресурсов', 'font-icon-resource-release-balance font-icon-darkgreen font-icon-x1_3 indent-right-10px', 1),
	(96, 3, 99, 78, 'Потребление в рабочий день', 'font-icon-accounting-sheet font-icon-tomato font-icon-x1_3 indent-right-10px', 1),		
    (98, 3, 101, 79, 'Анализ потребления тепловой энергии', 'font-icon-consumption-analysis font-icon-indigo font-icon-x1_2 indent-right-10px', 1),
    (99, 3, 102, 79, 'Нештатные ситуации ведомости учета ресурсов', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
    (100, 3, 103, 78, 'Настройки прибора', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
	(101, 3, 104, 78, 'Почасовые мониторинговые показания', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
    (102, 3, 105, 77, 'Балансовая ведомость ИПУ', 'font-icon-balance font-icon-orangered font-icon-x1_4 indent-right-10px', 1),
	(103, 3, 106, 61, 'Настройки ТВ7', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),

	/* Сводные отчеты */
	(78, 10, 78, 10, 'По вводным приборам учета', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),	  
	(88, 10, 91, 20, 'По нештатных ситуациям за период', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 0),
	(97, 10, 100, 25, 'Временной срез контроллеров регулирования', 'font-icon-report2 font-icon-darkslategrey font-icon-x1_2 indent-right-10px', 1),
	

	/* Запросы */
	(92, 4, 95, 5, 'Протоколы системы', 'font-icon-protocol font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(47, 4, 47, 10, 'Показатели качества связи', 'font-icon-signal-quality font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(39, 4, 38, 15, 'Диспетчеризируемые приборы', 'font-icon-dispatch-devices font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(40, 4, 39, 20, 'Архивные данные прибора', 'font-icon-archive font-icon-night font-icon-x1_1 indent-right-10px', 1),    
	(65, 4, 65, 21, 'Архивы', 'font-icon-archive font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(43, 4, 43, 25, 'Параметры по типу прибора', 'font-icon-abstract-parameter font-icon-night font-icon-x1_1 indent-right-10px', 1),					
	(80, 4, 82, 30, 'Параметры нештатных ситуаций', 'font-icon-emergency-parameters font-icon-night font-icon-x1_3 indent-right-10px', 1),
	(82, 4, 84, 35, 'Оповещения нештатных ситуаций', 'font-icon-emergency-notification font-icon-night font-icon-x1_3 indent-right-10px', 1),
	(62, 4, 62, 40, 'Показания прибора квартирного учета', 'font-icon-apartment-building font-icon-slateblue indent-right-10px', 1),    
	(77, 4, 77, 45, 'Журналы ТВ7', 'font-icon-query font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(84, 4, 86, 50, 'Журналы Взлёт-026', 'font-icon-query font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(52, 4, 52, 55, 'Связи многие-ко-многим', 'font-icon-many-to-many font-icon-night font-icon-x1_1 indent-right-10px', 1),
	(74, 4, 74, 60, 'Устройства с неверными связями', 'font-icon-wrong-relation font-icon-darkred font-icon-x1_1 indent-right-10px', 1),
	(68, 4, 68, 65, 'Сообщения пользователей', 'font-icon-user-message font-icon-night font-icon-x1_2 indent-right-10px', 1),

	/* Обработки */
	(46, 7, 46, 10, 'Присоединить каналы к пользователю', 'font-icon-processing font-icon-x1_3 indent-right-10px', 1),				
	(49, 7, 49, 20, 'Выгрузить XML-пакет архива устройства', 'font-icon-processing font-icon-x1_3 indent-right-10px', 0),   
	(93, 7, 96, 30, 'Изменить интервал опроса устройств', 'font-icon-processing font-icon-x1_3 indent-right-10px', 1)   
	     

	/*([Id], [MenuId], [MetaObjectId], [Order], [Title], [IconClass])*/			
GO

SET IDENTITY_INSERT [Core].[MenuItem] OFF;

GO