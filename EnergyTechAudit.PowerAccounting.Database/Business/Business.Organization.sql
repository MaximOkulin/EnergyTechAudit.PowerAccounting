CREATE TABLE [Business].[Organization]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(256) NULL, 	
	[FullAddress] NVARCHAR(256) NOT NULL,	
	[OrganizationTypeId] INT NOT NULL,
	[Location] GEOGRAPHY NOT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,
	
	
  CONSTRAINT PK_Business_Organization PRIMARY KEY (Id),		
	CONSTRAINT [FK_Business_Organization_OrganizationTypeId_Dictionaries_OrganizationType_Id] FOREIGN KEY ([OrganizationTypeId]) REFERENCES [Dictionaries].[OrganizationType]([Id])
);
GO

CREATE NONCLUSTERED INDEX IX_Business_Organization_OrganizationTypeId 
ON [Business].[Organization]
(
	[OrganizationTypeId]
);

GO