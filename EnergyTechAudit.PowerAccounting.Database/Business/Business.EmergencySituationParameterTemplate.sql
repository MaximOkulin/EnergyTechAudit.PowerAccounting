CREATE TABLE [Business].[EmergencySituationParameterTemplate]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(MAX) NOT NULL,
	[PredicateExpression] NVARCHAR(MAX) NOT NULL,
	[EntityTypeName] NVARCHAR(64) NOT NULL,

	CONSTRAINT [PK_Business_EmergencySituationParameterTemplate] PRIMARY KEY ([Id])
)
