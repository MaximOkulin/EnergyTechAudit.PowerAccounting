SET IDENTITY_INSERT [Dictionaries].[ProcessingStatus] ON;

INSERT INTO [Dictionaries].[ProcessingStatus] ([Id], [Code], [Description])
VALUES 
	(1, 'Created', 'Создана'),
	(2, 'Process', 'В процессе'),
	(3, 'Completed', 'Завершена')

SET IDENTITY_INSERT [Dictionaries].[ProcessingStatus] OFF;
