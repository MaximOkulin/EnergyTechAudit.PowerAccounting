SET IDENTITY_INSERT [Dictionaries].[TechnologicAdjunctionType] ON;
GO

INSERT INTO [Dictionaries].[TechnologicAdjunctionType] ([Id],[Code],[Description])
VALUES
  (1, 'Empty', 'Отсутствует'),
	(2, 'DependentMonotube', 'Зависимое однотрубное'),
	(3, 'DependentTwinTube', 'Зависимое двухтрубное'),
	(4, 'IndependentSingleStage', 'Независимое с одноступенчатым ТОА'),
	(5, 'IndependentTwoStage', 'Независимое с двухступенчатым ТОА'),
	(6, 'DependentDirect', 'Зависимое прямое'),
	(7, 'DependentRegulator', 'Зависимое с регулятором'),
  (8, 'DependentDirectBoiler', 'Зависимое прямое (бойлер)'),
  (9, 'DependentRegulatorBoiler', 'Зависимое с регулятором (бойлер)'),
  (10, 'IndependentSingleStageBoiler', 'Независимое с одноступенчатым ТОА (бойлер)'),
  (11, 'IndependentTwoStageBoiler', 'Независимое с двухступенчатым ТОА (бойлер)')

GO

SET IDENTITY_INSERT [Dictionaries].[TechnologicAdjunctionType] OFF;