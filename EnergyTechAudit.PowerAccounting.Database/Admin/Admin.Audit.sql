CREATE TABLE [Admin].[Audit]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	
  [Area]NVARCHAR(128) NULL,  
  [Controller] NVARCHAR(128) NULL,
  [Action] NVARCHAR(128) NULL,

	[UserId] INT NOT NULL,
	[Time]  DATETIME NOT NULL,
	[Elapsed] BIGINT NULL, 
  [ActionParams] NVARCHAR(MAX) NULL, 

  CONSTRAINT [PK_Admin_Audit_Id] PRIMARY KEY ([Id]),
  CONSTRAINT [FK_Admin_Audit_UserId_Admin_User_Id] FOREIGN KEY ([UserId]) REFERENCES [Admin].[User] ([Id]) ON DELETE CASCADE
)

GO

CREATE NONCLUSTERED INDEX [IX_Admin_Audit_UserId] 
ON [Admin].[Audit] ([UserId], [Time]) 
INCLUDE ([Id], [Action], [Elapsed], [ActionParams]);