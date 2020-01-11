SET IDENTITY_INSERT [Dictionaries].[PeriodType] ON;
GO

INSERT INTO [Dictionaries].[PeriodType] ([Id],[Code],[Description])
VALUES
   (1, 'Instant', 'Мгновенное значение'),
   (2, 'Hour', 'Часовое архивное значение'),
	(3, 'Day', 'Дневное архивное значение'),
	(4, 'Month', 'Месячное архивное значение'),
	(5, 'FinalInstant','Текущее итоговое значение'),
	(6, 'Final','Итоговое значение'),
	(7, 'No', 'Без периода')
GO

SET IDENTITY_INSERT [Dictionaries].[PeriodType] OFF;
GO