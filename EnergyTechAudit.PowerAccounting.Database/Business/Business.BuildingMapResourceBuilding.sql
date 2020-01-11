
CREATE TABLE [Business].[BuildingMapResourceBuilding]
(
    [Id] INT NOT NULL IDENTITY(1, 1),     
    [BuildingId] INT NOT NULL, 
    [ResourceBuildingId] INT NOT NULL, 
    [ResourceSystemTypeId] INT NOT NULL, 
    
    CONSTRAINT [PK_Business_BuildingMapResourceBuilding_Id] PRIMARY KEY ([Id]),

    CONSTRAINT [FK_Business_BuildingMapResourceBuilding_BuildingId_Business_Building_Id] 
      FOREIGN KEY ([BuildingId]) REFERENCES [Business].[Building] ([Id]),

	CONSTRAINT [FK_Business_BuildingMapResourceBuilding_ResourceBuildingId_Business_Building_Id] 
      FOREIGN KEY ([ResourceBuildingId]) REFERENCES [Business].[Building] ([Id]),
    
	CONSTRAINT [FK_Business_BuildingMapResourceBuilding_ResourceSystemTypeId_Dictionaries_ResourceSystemType_Id] 
      FOREIGN KEY ([ResourceSystemTypeId]) REFERENCES [Dictionaries].[ResourceSystemType] ([Id]),

   CONSTRAINT [UQ_Business_BuildingMapResourceBuilding_BuildingId_ResourceSystemTypeId]  
      UNIQUE ([BuildingId], [ResourceSystemTypeId])
)
GO

CREATE NONCLUSTERED INDEX [IX_Business_BuildingMapResourceBuilding_BuildingId] 
  ON [Business].[BuildingMapResourceBuilding] ([BuildingId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_BuildingMapResourceBuilding_ResourceBuildingId] 
  ON [Business].[BuildingMapResourceBuilding] ([ResourceBuildingId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_BuildingMapResourceBuilding_ResourceSystemTypeId] 
  ON [Business].[BuildingMapResourceBuilding] ([ResourceSystemTypeId]);
GO
