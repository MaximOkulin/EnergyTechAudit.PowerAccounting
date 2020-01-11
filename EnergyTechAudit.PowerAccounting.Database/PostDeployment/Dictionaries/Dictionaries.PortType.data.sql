SET IDENTITY_INSERT [Dictionaries].[PortType] ON;
GO

INSERT INTO [Dictionaries].[PortType] ([Id],[Code],[Description])
VALUES (1, 'RS232', 'Recommended Standard 232'),
       (2, 'RS232Power', 'Recommended Standard 232 с питанием'),
	   (3, 'RS485_2Wire', 'Recommended Standard 485 2-проводной'),
	   (4, 'RS485_4Wire', 'Recommended Standard 485 4-проводной'),
	   (5, 'RS422', 'Recommended Standard 422')
GO

SET IDENTITY_INSERT [Dictionaries].[PortType] OFF;
GO