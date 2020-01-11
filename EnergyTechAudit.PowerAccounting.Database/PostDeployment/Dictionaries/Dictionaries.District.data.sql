SET IDENTITY_INSERT [Dictionaries].[District] ON;
GO

INSERT INTO [Dictionaries].[District]
   ([Id], [CityId], [Description])
VALUES
   (1, 1, N'Приволжский район'),
   (2, 1, N'Авиастроительный район'),
   (3, 1, N'Ново-Савиновский район'),
   (4, 1, N'Вахитовский район'),
   (5, 1, N'Советский район'),
   (6, 1, N'Московский район'),
   (7, 1, N'Кировский район')
   
GO

SET IDENTITY_INSERT [Dictionaries].[District] OFF;
GO