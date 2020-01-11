CREATE TABLE [Admin].[ErrorLogEntry]
(
	[Id] INT NOT NULL IDENTITY(1,1),
    [UserName] NVARCHAR(64) NULL, 
    [UserAgent] NVARCHAR(256) NULL,
	[Time] DATETIME NOT NULL,
	[Exception] NVARCHAR(MAX) NULL,
	[Message] NVARCHAR(MAX) NULL,
	[StackTrace] NVARCHAR(MAX) NULL,	
  [RequestParams] NVARCHAR(MAX) NULL,
   CONSTRAINT PK_Admin_ErrorLogEntry PRIMARY KEY (Id)
)
GO

CREATE NONCLUSTERED INDEX  [IX_Admin_ErrorLogEntry_UserName] 
  ON [Admin].[ErrorLogEntry]([UserName]);