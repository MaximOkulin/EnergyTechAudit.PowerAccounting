SET IDENTITY_INSERT [Dictionaries].[TypeConnection] ON;
GO

INSERT INTO [Dictionaries].[TypeConnection] 
	([Id], Code, [Description])
VALUES
	(1, 'Client', 'Клиент'),
	(2, 'Server', 'Сервер');

GO

SET IDENTITY_INSERT [Dictionaries].[TypeConnection]  OFF;
GO