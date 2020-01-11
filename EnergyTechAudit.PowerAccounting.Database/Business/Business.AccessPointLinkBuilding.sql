CREATE TABLE [Business].[AccessPointLinkBuilding]
(
	[AccessPointId] INT NOT NULL,
	[BuildingId] INT NOT NULL,

	CONSTRAINT PK_Business_AccessPointLinkBuilding PRIMARY KEY (AccessPointId, BuildingId),
	CONSTRAINT [FK_Business_AccessPointLinkBuilding_AccessPointId_Business_AccessPoint_Id] FOREIGN KEY ([AccessPointId]) REFERENCES [Business].[AccessPoint]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_AccessPointLinkBuilding_BuildingId_Business_Building_Id] FOREIGN KEY ([BuildingId]) REFERENCES [Business].[Building]([Id]) ON DELETE CASCADE
);

GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPointLinkBuilding_AccessPointId] 
   ON [Business].[AccessPointLinkBuilding] ([AccessPointId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPointLinkBuilding_BuildingId] 
   ON [Business].[AccessPointLinkBuilding] ([BuildingId]);
