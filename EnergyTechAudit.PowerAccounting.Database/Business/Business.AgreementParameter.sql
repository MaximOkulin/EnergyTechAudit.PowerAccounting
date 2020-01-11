CREATE TABLE [Business].[AgreementParameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(128) NULL,
	[AgreementParameterTypeId] INT NOT NULL,
	[Value] NVARCHAR(MAX) NOT NULL,

	CONSTRAINT [PK_Business_AgreementParameter] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_AgreementParameter_AgreementParameterTypeId_Dictionaries_AgreementParameterType_Id] FOREIGN KEY ([AgreementParameterTypeId]) REFERENCES [Dictionaries].[AgreementParameterType]([Id])
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_AgreementParameter_AgreementParameterTypeId]
  ON [Business].[AgreementParameter] ([AgreementParameterTypeId])

GO