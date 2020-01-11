SET IDENTITY_INSERT [Core].[ReportType] ON;
GO

INSERT INTO [Core].[ReportType] (Id, Code, [Description])
VALUES
	(1, 'Report', 'Отчет'),
	(2, 'ReportSelector', 'Селектор отчета')
	
GO
SET IDENTITY_INSERT [Core].[ReportType] OFF;
GO