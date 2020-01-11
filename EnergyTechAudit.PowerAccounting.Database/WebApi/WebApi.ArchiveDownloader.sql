CREATE TABLE [WebApi].[ArchiveDownloader]
(
  [Id] INT NOT NULL,
  [Description] NVARCHAR(128) NULL, 
  [OrganizationId] INT NULL,

  [CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

  CONSTRAINT [PK_WebApi_ArchiveDownloader_Id] PRIMARY KEY ([Id]),
  
  CONSTRAINT FK_WebApi_ArchiveDownloader_Id_Admin_User_Id FOREIGN KEY (Id) REFERENCES [Admin].[User]([Id]) ON DELETE CASCADE,

  CONSTRAINT [FK_WebApi_ArchiveDownloader_OrganizationId] 
    FOREIGN KEY ([OrganizationId]) REFERENCES [Business].[Organization] ([Id]) ON DELETE SET NULL   
)
