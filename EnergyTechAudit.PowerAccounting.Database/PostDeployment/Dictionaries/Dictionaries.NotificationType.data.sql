SET IDENTITY_INSERT [Dictionaries].[NotificationType] ON;
GO

INSERT INTO [Dictionaries].[NotificationType] ([Id],[Code],[Description], [IsActive])
VALUES  
  (1, 'Web', 'Браузер', 1),
  (2, 'Email', 'Электронная почта', 1),
  (3, 'MobileApp', 'Мобильное приложение ETAGram', 1),
  (4, 'WebMobile', 'Браузерное мобильное приложение', 1)
GO

SET IDENTITY_INSERT [Dictionaries].[NotificationType] OFF;
