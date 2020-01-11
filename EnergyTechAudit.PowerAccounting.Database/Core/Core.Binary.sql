CREATE TABLE [Core].[Binary]
(
  [Id] INT NOT NULL IDENTITY(1, 1),
  [ItemId] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
  [Code] NVARCHAR(64) NULL,
  [Description] NVARCHAR(128) NOT NULL,
  [BinaryContentTypeId] INT NOT NULL,
  [Data] VARBINARY(MAX) NULL,
  [Category] NVARCHAR(32) NULL, 
  
  CONSTRAINT [PK_Core_Binary_Id] PRIMARY KEY ([Id]),
  
  CONSTRAINT [FK_Core_Binary_ContentTypeId_Dictionaries_BinaryContentType_Id]   
    FOREIGN KEY ([BinaryContentTypeId]) REFERENCES [Dictionaries].[BinaryContentType] ([Id]),

  CONSTRAINT [UQ_Core_Binary_ItemId] UNIQUE ([ItemId])
);
GO

ALTER TABLE [Core].[Binary] ADD CONSTRAINT [DF_Core_Binary_ItemId]
  DEFAULT NEWID() FOR [ItemId];

GO

ALTER TABLE [Core].[Binary] ADD CONSTRAINT [DF_Core_Binary_Category]
  DEFAULT 'Uncategorized' FOR [Category];
