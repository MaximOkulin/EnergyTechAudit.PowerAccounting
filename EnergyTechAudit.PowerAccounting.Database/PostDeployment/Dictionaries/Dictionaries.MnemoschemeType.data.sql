SET IDENTITY_INSERT [Dictionaries].[MnemoschemeType] ON;

INSERT INTO [Dictionaries].[MnemoschemeType] ([Id],[Code],[Description])
VALUES
  (1, 'ChannelLevel', 'Уровень канала'),
	(2, 'PlacementLevel', 'Уровень помещения')
	
GO

SET IDENTITY_INSERT [Dictionaries].[MnemoschemeType] OFF;
