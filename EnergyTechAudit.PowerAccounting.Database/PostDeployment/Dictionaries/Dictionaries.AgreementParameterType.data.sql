SET IDENTITY_INSERT [Dictionaries].[AgreementParameterType] ON;
GO

INSERT INTO [Dictionaries].[AgreementParameterType] ([Id], [Code], [Description])
VALUES
     (1, 'TemperatureProfile', 'Температурный график'),
	 (2, 'StandardDHWTemp', 'Нормативная температура ГВС')
GO

SET IDENTITY_INSERT [Dictionaries].[AgreementParameterType] OFF;
GO
