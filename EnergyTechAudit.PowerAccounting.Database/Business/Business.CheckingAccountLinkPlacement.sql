CREATE TABLE [Business].[CheckingAccountLinkPlacement]
(
  [CheckingAccountId] INT NOT NULL,
  [PlacementId] INT NOT NULL,

  CONSTRAINT [PK_Business_CheckingAccountLinkPlacement] 
    PRIMARY KEY ([CheckingAccountId], [PlacementId]),

  CONSTRAINT [FK_Business_CheckingAccountLinkPlacement_CheckingAccountId_Businnee_CheckingAccount_Id] 
    FOREIGN KEY ([CheckingAccountId]) REFERENCES [Business].[CheckingAccount]([Id]) ON DELETE CASCADE,

	CONSTRAINT [FK_Business_CheckingAccountLinkPlacement_PlacementId_Business_Placement_Id] 
    FOREIGN KEY ([PlacementId]) REFERENCES [Business].[Placement]([Id]) ON DELETE CASCADE
)
