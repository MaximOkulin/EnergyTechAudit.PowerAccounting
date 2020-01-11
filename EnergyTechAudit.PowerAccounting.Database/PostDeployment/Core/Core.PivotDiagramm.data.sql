SET IDENTITY_INSERT [Core].[PivotDiagramm] ON;
GO

INSERT INTO [Core].[PivotDiagramm] (Id, Code, [Description])
VALUES 
	(1, 'ByDevice', 'Распределение по типу устройств'),
	(2, 'ByDistrict', 'Распределение по районам'),
	(3, 'ByConnectionQuality', 'Распределение по качеству связи')	
	
GO
SET IDENTITY_INSERT [Core].[PivotDiagramm] OFF;
GO