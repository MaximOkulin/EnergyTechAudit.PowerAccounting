CREATE TABLE [Core].[Briefcase]
(
  [Id] INT NOT NULL IDENTITY(1, 1),
  [Code] NVARCHAR(32) NOT NULL,
  [Description] NVARCHAR(128) NOT NULL,
  [Comments] NVARCHAR(512) NULL, 

  [UserId] INT NOT NULL,

  CONSTRAINT [PK_Core_Brieface] PRIMARY KEY CLUSTERED ([Id]),
  CONSTRAINT [FK_Core_Brieface_UserId_Admin_User_Id] FOREIGN KEY ([UserId]) REFERENCES [Admin].[User] ON DELETE CASCADE
)
