


SET IDENTITY_INSERT [Core].[Menu] ON;

GO

INSERT INTO [Core].[Menu] 
	([Id], [Order], [Title], [IconClass], [DisplayInMainMenu], [DisplayInNavbar])
VALUES	
	(1, 10, 'Словари', 'font-icon-dictionaries font-icon-x1_5 font-icon-darkslateblue', 1, 1)
	,(2, 60, 'Сводные таблицы', 'font-icon-pivots font-icon-x1_5 font-icon-night', 1, 1)
	,(3, 30, 'Отчеты', 'font-icon-report font-icon-x1_5 font-icon-darkslategrey', 1, 1)
	,(4, 40, 'Запросы', 'font-icon-query font-icon-x1_5 font-icon-slateblue', 1, 1)
	,(5, 1, 'Формы', 'font-icon-form font-icon-x1_5 font-icon-color-darkred', 1, 1)
	,(6, 50, 'Сводные диаграммы', 'font-icon-charts font-icon-x1_5 font-icon-darkslateblue', 1, 1)
	,(7, 70, 'Обработки', 'font-icon-processing font-icon-x1_5 font-icon-darkslateblue', 1, 1)
	,(8, 55, 'Диаграммы', 'font-icon-charts font-icon-x1_5 font-icon-darkslateblue', 1, 1)
	,(9, 2, 'Формы (служебные)', 'font-icon-form font-icon-x1_5 font-icon-color-navy', 0, 1)

	,(10, 41, 'Сводные отчеты', 'font-icon-report font-icon-x1_5 font-icon-darkslategrey', 1, 1)
	;

GO

SET IDENTITY_INSERT [Core].[Menu] OFF;
GO