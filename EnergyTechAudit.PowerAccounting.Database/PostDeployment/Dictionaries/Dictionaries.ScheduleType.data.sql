SET IDENTITY_INSERT [Dictionaries].[ScheduleType] ON;
GO

INSERT INTO [Dictionaries].[ScheduleType] ([Id],[Code],[Description])
VALUES  
	(1, 'ByDayOfWeek','По дню недели'),
	(2, 'ByWorkingDaysOfWeek','По рабочим дням недели'),
	(3, 'ByHolydaysOfWeek','По выходным дням недели'),
	(4, 'ByDayOfMonth','По дню месяца')

SET IDENTITY_INSERT [Dictionaries].[ScheduleType] OFF;
GO
       
