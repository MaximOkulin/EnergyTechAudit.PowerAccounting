CREATE TABLE [Business].[CheckingAccount]
(
  [Id] INT NOT NULL IDENTITY(1, 1),
  [Description] NVARCHAR(128) NULL,  
  [AccountNumber] BIGINT NOT NULL, 
  [OrganizationId] INT NOT NULL,  

  [CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

  CONSTRAINT [PK_Business_CheckingAccount_Id] 
    PRIMARY KEY ([Id]),
  CONSTRAINT [FK_Business_CheckingAccount_OrganizationId_Business_Organization_Id] 
    FOREIGN KEY ([OrganizationId]) REFERENCES [Business].[Organization] ([Id]) ON  DELETE CASCADE
)
