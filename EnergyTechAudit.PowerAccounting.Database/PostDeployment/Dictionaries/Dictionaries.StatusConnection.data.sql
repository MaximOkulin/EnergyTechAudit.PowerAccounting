SET IDENTITY_INSERT [Dictionaries].[StatusConnection]  ON;
GO


INSERT INTO [Dictionaries].[StatusConnection] 
	([Id], Code, [Description])
VALUES
	(1, 'Unknown', 'Неизвестен'),
	(2, 'Sucсess', 'ОК'),
	(3, 'Fail', 'Нет связи'),
	(4, 'Loss', 'Ошибка передачи'),
	(5, 'WrongSettings', 'Неверные настройки'),
	(6, 'EmptyArchives', 'Архив отсутствует в памяти контроллера')

GO

SET IDENTITY_INSERT [Dictionaries].[StatusConnection]  OFF;