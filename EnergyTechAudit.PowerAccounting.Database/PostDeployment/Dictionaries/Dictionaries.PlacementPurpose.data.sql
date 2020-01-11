SET IDENTITY_INSERT [Dictionaries].[PlacementPurpose] ON;
GO

INSERT INTO [Dictionaries].[PlacementPurpose]
    ([Id], Code, [Description])
VALUES
  (1,'Flat', 'Квартира'),
	(2,'Metering', 'Узел учета'),
	(3,'Empty', 'Нежилое помещение'),
  (4, 'BoilerRoom', 'Котельная')
GO

SET IDENTITY_INSERT [Dictionaries].[PlacementPurpose] OFF;
GO