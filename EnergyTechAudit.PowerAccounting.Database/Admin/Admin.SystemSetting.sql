CREATE TABLE [Admin].[SystemSetting]
(
  [Id] INT NOT NULL IDENTITY (1, 1),

  [SystemName] NVARCHAR(128),

  [EmailAdminAddress] NVARCHAR(128),

  [EmailAddress] NVARCHAR(128),
  [EmailSmtpServer] NVARCHAR(64),
  [EmailSmtpPort] INT, 
  [EmailUserName] NVARCHAR(64),
  [EmailPassword] NVARCHAR(32),
  [EmailEnableSsl] BIT,

  [CustomData] NVARCHAR(MAX),

  [CreatedBy] NVARCHAR(32) NOT NULL , 
  [UpdatedBy] NVARCHAR(32) NOT NULL , 
  [CreatedDate] DATETIME NOT NULL , 
  [UpdatedDate] DATETIME NOT NULL , 

  CONSTRAINT [PK_Admin_System_Id] PRIMARY KEY  ([Id])
)
