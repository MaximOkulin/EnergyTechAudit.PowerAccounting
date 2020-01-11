CREATE TABLE [Business].[UserAdditionalInfo]
(
	[Id] INT NOT NULL,
	[Description] NVARCHAR(64) NULL,

	[FirstName] NVARCHAR(32) NULL,
	[LastName] NVARCHAR(32) NOT NULL,
	[Patronimic] NVARCHAR(32) NULL,
	[BirthDay] DATE NULL,
	[GenderId] INT NULL, 

	[Phone] NVARCHAR(16) NULL,
	[Email] NVARCHAR(128) NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	CONSTRAINT PK_Business_UserAdditionalInfo PRIMARY KEY (Id),	
  CONSTRAINT FK_Business_UserAdditionalInfo_Id_Admin_User_Id FOREIGN KEY (Id) REFERENCES [Admin].[User]([Id]) ON DELETE CASCADE,
  CONSTRAINT FK_Business_UserAdditionalInfo_Id_Dictionaries_Gender_Id FOREIGN KEY (GenderId) REFERENCES [Dictionaries].[Gender]([Id])
);
GO

ALTER TABLE [Business].[UserAdditionalInfo]
  ADD CONSTRAINT [DF_Business_UserAdditionalInfo_BirthDay] DEFAULT '1900-01-01' FOR [BirthDay];

GO
ALTER TABLE [Business].[UserAdditionalInfo]
  ADD CONSTRAINT [DF_Business_UserAdditionalInfo_GenderId] DEFAULT 3 FOR [GenderId];



