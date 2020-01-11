SET IDENTITY_INSERT [Dictionaries].[City] ON;
GO

INSERT INTO [Dictionaries].[City]
   ([Id], [Code], [Description], [MinimalTemperature])
VALUES
   (1, 'Казань', 'Казань', -31),
   (2, 'Набережные Челны', 'Набережные Челны', -31),
   (3, 'Зеленодольск', 'Зеленодольск', -31)
GO

SET IDENTITY_INSERT [Dictionaries].[City] OFF;
GO