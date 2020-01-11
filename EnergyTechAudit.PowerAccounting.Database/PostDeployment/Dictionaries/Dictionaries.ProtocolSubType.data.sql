SET IDENTITY_INSERT [Dictionaries].[ProtocolSubType] ON;
GO

INSERT INTO [Dictionaries].[ProtocolSubType]([Id],[Code],[Description])
VALUES 
   (1, 'Empty', 'Отсутствует'),
   (2, 'ModbusRtu', 'Modbus RTU'),
   (3, 'ModbusAscii', 'Modbus ASCII'),
   (4, 'IEC61107_2001', 'IEC 61107-2001 (МЭК)')
GO

SET IDENTITY_INSERT [Dictionaries].[ProtocolSubType] OFF;

