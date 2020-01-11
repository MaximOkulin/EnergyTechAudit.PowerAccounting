
SET IDENTITY_INSERT [Core].[MetaObjectType] ON;
GO

INSERT INTO [Core].[MetaObjectType] ([Id], [Code], [Description])
VALUES
   (1, 'Dictionary', 'Словарь'),
   (2, 'Query', 'Запрос'),
   (3, 'Report', 'Отчет'),
   (4, 'Pivot', 'Сводная таблица'),
   (5, 'Form', 'Форма'),
   (6, 'PivotDiagramm', 'Сводная диаграмма'),
   (7, 'Processing', 'Обработка'),
   (8, 'Diagramm', 'Диаграмма')

GO
SET IDENTITY_INSERT [Core].[MetaObjectType]  OFF;
GO