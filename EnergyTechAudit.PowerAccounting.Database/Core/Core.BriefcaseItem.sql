CREATE TABLE [Core].[BriefcaseItem]
(
  [Id] INT NOT NULL IDENTITY(1, 1),

  [Description] NVARCHAR(128) NOT NULL,
  [EntityId] INT NOT NULL,
  [EntityTypeName] NVARCHAR(64) NOT NULL,
  [BriefcaseId] INT NOT NULL,
  [Comments] NVARCHAR(512) NULL, 

  CONSTRAINT [PK_Core_BriefcaseItem] PRIMARY KEY CLUSTERED ([Id]),
  CONSTRAINT [FK_Core_BriefcaseItem_BriefcaseId_Core_Briefcase_Id] FOREIGN KEY ([BriefcaseId]) REFERENCES [Core].[Briefcase] ON DELETE CASCADE ,
  CONSTRAINT [UQ_Core_BriefcaseItem_BriefcaseId_EntityId_EntityTypeName] UNIQUE ([BriefcaseId], [EntityId], [EntityTypeName])
)
