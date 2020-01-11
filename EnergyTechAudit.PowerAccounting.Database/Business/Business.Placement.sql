CREATE TABLE [Business].[Placement]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(128) NULL, 
	[PlacementPurposeId] INT NOT NULL,
	[BuildingId] INT NOT NULL,
	[Number] NVARCHAR(10),
	[AmountRooms] INT,
	[AmountPeople] INT,
	[FrontNumber] INT NULL,
	[Comment] NVARCHAR(64) NULL,
	[Area] FLOAT,
	[UserAdditionalInfoId] INT NULL,
	[OrganizationId] INT NULL,
	[HasIndividualAccounting] BIT NOT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

  [MnemoschemeId] INT NULL,
	
  CONSTRAINT PK_Business_Placement PRIMARY KEY (Id),
	CONSTRAINT [FK_Business_Placement_PlacementPurposeId_Dictionaries_PlacementPurpose_Id] FOREIGN KEY ([PlacementPurposeId]) REFERENCES [Dictionaries].[PlacementPurpose]([Id]),
	CONSTRAINT [FK_Business_Placement_BuildingId_Business_Building_Id] FOREIGN KEY ([BuildingId]) REFERENCES [Business].[Building]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_Placement_UserAdditionalInfoId_Business_UserAdditionalInfo_Id] FOREIGN KEY ([UserAdditionalInfoId]) REFERENCES [Business].[UserAdditionalInfo]([Id]) ON DELETE SET NULL,
	CONSTRAINT [FK_Business_Placement_OrganizationId_Business_Organization_Id] FOREIGN KEY ([OrganizationId]) REFERENCES [Business].[Organization]([Id]) ON DELETE SET NULL,
	CONSTRAINT [FK_Business_Placement_MnemoschemeId_Business_Mnemoscheme_Id] FOREIGN KEY ([MnemoschemeId]) REFERENCES [Business].[Mnemoscheme]([Id]) ON DELETE SET NULL,
	)   
  GO

  ALTER TABLE [Business].[Placement] 
    ADD CONSTRAINT [DF_Business_Placement_PlacementPurposeId] DEFAULT 2 FOR [PlacementPurposeId];
  GO

  ALTER TABLE [Business].[Placement] 
    ADD CONSTRAINT [DF_Business_Placement_AmountRooms] DEFAULT 0 FOR [AmountRooms];
  GO

  ALTER TABLE [Business].[Placement] 
    ADD CONSTRAINT [DF_Business_Placement_AmountPeople] DEFAULT 0 FOR [AmountPeople];
  GO

  ALTER TABLE [Business].[Placement] 
    ADD CONSTRAINT [DF_Business_Placement_FrontNumber] DEFAULT 0 FOR [FrontNumber];
  GO
  
  ALTER TABLE [Business].[Placement] 
    ADD CONSTRAINT [DF_Business_Placement_Area] DEFAULT 0 FOR [Area];
  GO

  ALTER TABLE [Business].[Placement]
    ADD CONSTRAINT [DF_Business_Placement_HasIndividualAccounting] DEFAULT 0 FOR [HasIndividualAccounting];   
  GO

   CREATE NONCLUSTERED INDEX [IX_Business_Placement_PlacementPurposeId]
      ON [Business].[Placement] ([PlacementPurposeId]);

  GO

   CREATE NONCLUSTERED INDEX [IX_Business_Placement_BuildingId]
      ON [Business].[Placement] ([BuildingId]);

   GO

   CREATE NONCLUSTERED INDEX [IX_Business_Placement_UserAdditionalInfoId]
      ON [Business].[Placement] ([UserAdditionalInfoId]);

   GO

   CREATE NONCLUSTERED INDEX [IX_Business_Placement_OrganizationId]
     ON [Business].[Placement] ([OrganizationId]);
   GO

   /* By statistic */
   
   CREATE INDEX [IX_Business_Placement_HasIndividualAccounting] ON [Business].[Placement] 
   (
      [HasIndividualAccounting]
   )
   INCLUDE 
   (
      [Id], [BuildingId]
   );
