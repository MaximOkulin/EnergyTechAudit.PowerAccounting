CREATE TABLE [Business].[Building]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(64) NULL, 
	[FullAddress] NVARCHAR(256) NOT NULL,
	[Square] FLOAT,
	[BuildingPurposeId] INT NOT NULL,
	[CountFlats] INT,
	[Location] GEOGRAPHY NOT NULL,
  [OrganizationId] INT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,
	[DistrictId] INT NOT NULL,    

  [UserAdditionalInfoId] INT NULL,

  CONSTRAINT PK_Business_Building PRIMARY KEY (Id),
	CONSTRAINT [FK_Business_Building_DistrictId_Dictionaries_District_Id] FOREIGN KEY ([DistrictId]) REFERENCES [Dictionaries].[District]([Id]),
	CONSTRAINT [FK_Business_Building_BuildingPurposeId_Dictionaries_BuildingPurpose_Id] FOREIGN KEY ([BuildingPurposeId]) REFERENCES [Dictionaries].[BuildingPurpose]([Id]),
  CONSTRAINT [FK_Business_Building_OrganizationId_Business_Organization_Id] FOREIGN KEY ([OrganizationId]) REFERENCES [Business].[Organization]([Id]) ON DELETE SET NULL,

  CONSTRAINT [FK_Business_Building_UserAdditionalInfoId_Business_UserAdditionalInfo_Id] FOREIGN KEY ([UserAdditionalInfoId]) REFERENCES [Business].[UserAdditionalInfo]([Id]) ON DELETE SET NULL
);

GO
ALTER TABLE [Business].[Building]
  ADD CONSTRAINT [DF_Business_Building_Square] DEFAULT 0 FOR [Square];
GO



ALTER TABLE [Business].[Building]
  ADD CONSTRAINT [DF_Business_Building_CountFlats] DEFAULT 0 FOR [CountFlats];
GO

CREATE NONCLUSTERED INDEX [IX_FK_Business_Building_DistrictId] 
   ON [Business].[Building] ([DistrictId]);

GO

CREATE NONCLUSTERED INDEX [IX_FK_Business_Building_OrganizationId]
  ON [Business].[Building] ([OrganizationId]);

GO

CREATE NONCLUSTERED INDEX [IX_FK_Business_Building_BuildingPurposeId] 
   ON [Business].[Building] ([BuildingPurposeId]);

GO

CREATE NONCLUSTERED INDEX [IX_FK_Business_Building_Id] 
   ON [Business].[Building] ([Id]) INCLUDE([Description], [DistrictId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_Building_UserAdditionalInfoId]
  ON [Business].[Building] ([UserAdditionalInfoId]);