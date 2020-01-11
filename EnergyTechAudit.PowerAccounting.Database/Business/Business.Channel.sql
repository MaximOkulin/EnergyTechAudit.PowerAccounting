CREATE TABLE [Business].[Channel]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(64) NULL,
	[ChannelTemplateId] INT NOT NULL,
	[ResourceSystemTypeId] INT NOT NULL,
	[MeasurementDeviceId] INT NOT NULL,
	[PlacementId] INT NOT NULL,
	[TechnologicAdjunctionTypeId] INT NOT NULL,
	
	[MnemoschemeId] INT NULL, 
	[OrganizationId] INT NULL,
	[ResourceSubsystemTypeId] INT NULL,
	[LastEmergencyTimeSignatureId] INT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,
	[Activated] BIT NOT NULL,
	[Order] INT NULL,

	CONSTRAINT PK_Business_Channel PRIMARY KEY (Id),
	CONSTRAINT [FK_Business_Channel_ChannelTemplateId_Business_ChannelTemplate_Id] FOREIGN KEY ([ChannelTemplateId]) REFERENCES [Business].[ChannelTemplate]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_Channel_ResourceSystemTypeId_Dictionaries_SystemType_Id] FOREIGN KEY ([ResourceSystemTypeId]) REFERENCES [Dictionaries].[ResourceSystemType]([Id]),
	CONSTRAINT [FK_Business_Channel_MeasurementDeviceId_Business_MeasurementDevice_Id] FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_Channel_PlacementId_Business_Placement_Id] FOREIGN KEY ([PlacementId]) REFERENCES [Business].[Placement]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_Channel_MnemoschemeId_Business_Mnemoscheme_Id] FOREIGN KEY ([MnemoschemeId]) REFERENCES [Business].[Mnemoscheme]([Id]),
	CONSTRAINT [FK_Business_Channel_OrganizationId_Business_Organization_Id] FOREIGN KEY ([OrganizationId])	REFERENCES [Business].[Organization]([Id]),
	CONSTRAINT [FK_Business_Channel_TechnologicAdjunctionTypeId_Dictionaries_TechnologicAdjunctionType_Id] FOREIGN KEY ([TechnologicAdjunctionTypeId]) REFERENCES [Dictionaries].[TechnologicAdjunctionType]([Id]),
	CONSTRAINT [FK_Business_Channel_ResourceSubsystemTypeId_Dictionaries_ResourceSubsystemType_Id] FOREIGN KEY ([ResourceSubsystemTypeId]) REFERENCES [Dictionaries].[ResourceSubsystemType]([Id])
);
GO

ALTER TABLE [Business].[Channel] 
  ADD CONSTRAINT [DF_Business_Channel_ResourceSystemTypeId] DEFAULT 4 FOR [ResourceSystemTypeId];
GO

ALTER TABLE [Business].[Channel] 
  ADD CONSTRAINT [DF_Business_Channel_Activated] DEFAULT 1 FOR [Activated];
GO

CREATE NONCLUSTERED INDEX [IX_Business_Channel_MeasurementDeviceId] 
   ON [Business].[Channel] ([MeasurementDeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_Channel_PlacementId] 
   ON [Business].[Channel] ([PlacementId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_Channel_ChannelTemplateId] 
   ON [Business].[Channel] ([ChannelTemplateId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_Channel_ResourceSystemTypeId] 
   ON [Business].[Channel] ([ResourceSystemTypeId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_Channel_OrganizationId]
   ON [Business].[Channel] ([OrganizationId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_Channel_TechnologicAdjunctionTypeId]
   ON [Business].[Channel] ([TechnologicAdjunctionTypeId]);
GO

CREATE INDEX [IX_Business_Channel_ResourceSystemTypeId2] 
  ON [Business].[Channel] ([ResourceSystemTypeId]) 
  INCLUDE ([Id], [PlacementId])
GO

CREATE INDEX [IX_Business_Channel_ResourceSystemTypeId3]
  ON [Business].[Channel] ([ResourceSystemTypeId]) 
  INCLUDE ([Id], [TechnologicAdjunctionTypeId], [OrganizationId])
GO

CREATE NONCLUSTERED INDEX [IX_Channel_ResourceSystemTypeId4] 
ON [Business].[Channel] ([ResourceSystemTypeId]) 
INCLUDE ([Id], [Description], [PlacementId]);

GO

CREATE INDEX [IX_Business_Channel_ResourceSubsystemTypeId]
  ON [Business].[Channel] (ResourceSubsystemTypeId)
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Business_Channel_Id] 
	ON [Business].[Channel] ([Id])
	INCLUDE([MeasurementDeviceId], [PlacementId]);
GO

/* By statistic */
CREATE INDEX [IX_Business_Channel_Activated] 
ON [Business].[Channel] 
(
  [Activated]
) 
INCLUDE 
(
  [ResourceSystemTypeId]
);

GO
CREATE INDEX [IX_Business_Channel_ResourceSystemTypeId_Activated] 
ON [Business].[Channel] ([ResourceSystemTypeId], [Activated]) 
INCLUDE 
(
	[Description], 
	[ChannelTemplateId], 
	[MeasurementDeviceId],
	[PlacementId],
	[TechnologicAdjunctionTypeId], 
	[MnemoschemeId], 
	[OrganizationId], 
	[ResourceSubsystemTypeId], 
	[LastEmergencyTimeSignatureId], 
	[CreatedBy], 
	[UpdatedBy], 
	[CreatedDate], 
	[UpdatedDate], 
	[Order]
)
GO
