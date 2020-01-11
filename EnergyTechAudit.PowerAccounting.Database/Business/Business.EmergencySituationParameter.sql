CREATE TABLE [Business].[EmergencySituationParameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(MAX) NULL,
	[SeasonTypeId] INT NOT NULL,
	[EmergencySituationParameterTemplateId] INT NOT NULL,
	[PredicateExpression] NVARCHAR(MAX) NOT NULL,
	[TurnOn] BIT NOT NULL,
	[ChannelId] INT NOT NULL,
	[EntityTypeName] NVARCHAR(64) NOT NULL,

  [CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	CONSTRAINT [PK_Business_EmergencySituationParameter] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_EmergencySituationParameter_SeasonTypeId_Dictionaries_SeasonType_Id] FOREIGN KEY ([SeasonTypeId]) REFERENCES [Dictionaries].[SeasonType]([Id]),
	CONSTRAINT [FK_Business_EmergencySituationParameter_EmergencySituationParameterTemplateId_Business_EmergencySituationParameterTemplate_Id] 
    FOREIGN KEY ([EmergencySituationParameterTemplateId]) REFERENCES [Business].[EmergencySituationParameterTemplate]([Id]),
	CONSTRAINT [FK_Business_EmergencySituationParameter_ChannelId_Business_Channel_Id] FOREIGN KEY ([ChannelId]) REFERENCES [Business].[Channel]([Id]) ON DELETE CASCADE	
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_SeasonTypeId]
   ON [Business].[EmergencySituationParameter]([SeasonTypeId])
GO

CREATE NONCLUSTERED INDEX [IX_Business_EmergencySituationParameterTemplateId]
   ON [Business].[EmergencySituationParameter]([EmergencySituationParameterTemplateId])
GO

CREATE NONCLUSTERED INDEX [IX_Business_EmergencySituationParameter_ChannelId]
   ON [Business].[EmergencySituationParameter]([ChannelId])
GO

CREATE INDEX [IX_Business_EmergencySituationParameter_CreatedDate] 
  ON [Business].[EmergencySituationParameter] ([CreatedDate]) 
  INCLUDE 
  (
    [Id], [Description], [CreatedBy]
  );
GO

