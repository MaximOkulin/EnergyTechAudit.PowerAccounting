CREATE TABLE [Business].[AccessPointStatusConnectionLog]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[ConnectionTime] DATETIME NOT NULL,
	[StatusConnectionId] INT  NOT NULL,
	[AccessPointId] INT NOT NULL,

	CONSTRAINT [PK_Business_AccessPointStatusConnectionLog] PRIMARY KEY(Id),
	CONSTRAINT [FK_Business_AccessPointStatusConnectionLog_ConnectionStatusId_Dictionaries_StatusConnection_Id] FOREIGN KEY ([StatusConnectionId]) REFERENCES [Dictionaries].[StatusConnection]([Id]),
	CONSTRAINT [FK_Business_AccessPointStatusConnectionLog_AccessPointId_Business_AccessPoint_Id] FOREIGN KEY ([AccessPointId]) REFERENCES [Business].[AccessPoint]([Id]) ON DELETE CASCADE,

);
GO

ALTER TABLE [Business].[AccessPointStatusConnectionLog]
  ADD CONSTRAINT [DF_Business_AccessPointStatusConnectionLog_ConnectionTime] 
  DEFAULT '1900-01-01' FOR [ConnectionTime];
GO

ALTER TABLE [Business].[AccessPointStatusConnectionLog]
  ADD CONSTRAINT [DF_Business_AccessPointStatusConnectionLog_StatusConnectionId]
  DEFAULT 1 FOR [StatusConnectionId]
GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPointConnectionStatus_ConnectionTime] 
   ON [Business].[AccessPointStatusConnectionLog] ([ConnectionTime] DESC);
GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPointConnectionStatus_ConnectionStatusId] 
   ON [Business].[AccessPointStatusConnectionLog] ([StatusConnectionId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPointConnectionStatus_AccessPointId] 
   ON [Business].[AccessPointStatusConnectionLog] ([AccessPointId]);

