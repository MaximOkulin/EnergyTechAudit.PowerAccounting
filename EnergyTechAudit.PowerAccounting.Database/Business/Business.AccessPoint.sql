CREATE TABLE [Business].[AccessPoint]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(64) NULL,
	[Identifier] NVARCHAR(128) NULL,
	[NetAddress] NVARCHAR(16) NOT NULL,
	[Port] INT NOT NULL,
	[NetPhone] NVARCHAR(16),	
	[TransportTypeId] INT NOT NULL,
	[TransportServerModelId] INT NOT NULL,
	[DeviceReaderId] INT,
	[LastConnectionTime] DATETIME  NOT NULL,
	[LastStatusConnectionId] INT NOT NULL,
	[SuccessConnectionPercent] FLOAT NOT NULL,
	[ControllerAddress] INT NOT NULL,
	[IsNeedToReconfigure] BIT NOT NULL,

	[CsdModemId] INT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,
		
    CONSTRAINT PK_Business_AccessPoint PRIMARY KEY (Id),	
	CONSTRAINT [FK_Business_AccessPoint_TransportTypeId_Dictionaries_TransportType_Id] FOREIGN KEY ([TransportTypeId])	REFERENCES [Dictionaries].[TransportType]([Id]),
	CONSTRAINT [FK_Business_AccessPoint_TransportServerModelId_Dictionaries_TransportServerModel_Id] FOREIGN KEY ([TransportServerModelId]) REFERENCES [Dictionaries].[TransportServerModel]([Id]),
	CONSTRAINT [FK_Business_AccessPoint_DeviceReaderId_Business_DeviceReader_Id] FOREIGN KEY ([DeviceReaderId]) REFERENCES [Business].[DeviceReader]([Id]) ON DELETE SET NULL,
	CONSTRAINT [FK_Business_AccessPoint_LastStatusConnectionId_Dictionaries_StatusConnection_Id] FOREIGN KEY ([LastStatusConnectionId]) REFERENCES [Dictionaries].[StatusConnection]([Id]),
	CONSTRAINT [FK_Business_AccessPoint_CsdModemId_Business_CsdModed_Id] FOREIGN KEY ([CsdModemId]) REFERENCES [Business].[CsdModem]([Id]),
	CONSTRAINT [UQ_NetAddress_Port_Identifier_NetPhone] UNIQUE ([NetAddress],[Port],[Identifier],[NetPhone])
)
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_NetAddress] DEFAULT '10.135.64.1' FOR [NetAddress];
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_Port] DEFAULT 5010 FOR [Port];
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_TransportTypeId] DEFAULT 3 FOR [TransportTypeId];   
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_TransportServerModelId] DEFAULT 3 FOR [TransportServerModelId];
GO


ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_LastConnectionTime] DEFAULT '1900-01-01' FOR [LastConnectionTime];
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_LastStatusConnectionId] DEFAULT 1 FOR [LastStatusConnectionId];
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_SuccessConnectionPercent] DEFAULT 0 FOR [SuccessConnectionPercent];
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_ControllerAddress] DEFAULT 255 FOR [ControllerAddress];
GO

ALTER TABLE [Business].[AccessPoint]
   ADD CONSTRAINT [DF_Business_AccessPoint_IsNeedToReconfigure] DEFAULT 0 FOR [IsNeedToReconfigure];
GO

/**/
CREATE NONCLUSTERED INDEX [IX_Business_AccessPoint_TransportTypeId]
   ON [Business].[AccessPoint] ([TransportTypeId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPoint_TransportServerModelId] 
   ON [Business].[AccessPoint] ([TransportServerModelId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPoint_DeviceReaderId] 
   ON [Business].[AccessPoint] ([DeviceReaderId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPoint_LastStatusConnectionId] 
   ON [Business].[AccessPoint] ([LastStatusConnectionId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_AccessPoint_CsdModemId] 
   ON [Business].[AccessPoint] ([CsdModemId]);
GO

CREATE INDEX [IX_Business_AccessPoint_TransportTypeId_DeviceReaderId_TransportServerModelId] 
ON [Business].[AccessPoint] 
(
  [TransportTypeId], 
  [DeviceReaderId],
  [TransportServerModelId]
) INCLUDE 
(
  [Id], 
  [Description], 
  [Identifier], 
  [LastConnectionTime], 
  [CsdModemId]
);

GO
CREATE INDEX [IX_Business_AccessPoint_DeviceReaderId2] ON 
[Business].[AccessPoint] ([DeviceReaderId]) INCLUDE 
(
	[Description], 
	[Identifier], 
	[TransportTypeId], 
	[TransportServerModelId], 
	[LastConnectionTime], 
	[CsdModemId]
)

GO