SET IDENTITY_INSERT [Dictionaries].[TransportType] ON;
GO

INSERT INTO [Dictionaries].[TransportType] ([Id],[Code],[Description])
VALUES (1, 'Direct', 'Прямое'),
       (2, 'CSD', 'CSD'),
	   (3, 'Ethernet', 'GPRS/Ethernet (TCP/IP)'),
	   (4, 'Http', 'Http')
GO

SET IDENTITY_INSERT [Dictionaries].[TransportType] OFF;
GO