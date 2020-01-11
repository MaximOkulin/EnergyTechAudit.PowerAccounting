CREATE TABLE [Business].[MeasurementDevice]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(64),
	[DeviceId] INT NOT NULL,
	[SubModel] NVARCHAR(16) NULL,
	[AccessPointId] INT,
	[AutoDefTimeoutAnswer] INT NOT NULL,
	[AmountAttempt] INT NOT NULL,
	[NetworkAddress] INT NOT NULL,
	[ComPortId] INT NOT NULL,
	[BaudId] INT NOT NULL,
	[DataBitId] INT NOT NULL,
	[StopBitId] INT NOT NULL,
	[ParityId] INT NOT NULL,	
	[Priority] INT NOT NULL,
	[LastStatusConnectionId] INT NOT NULL,
	[SuccessConnectionPercent] FLOAT NOT NULL,
	[LastConnectionTime] DATETIME NOT NULL,
	[PollingInterval] INT NOT NULL,
	[StartReadArchiveDate] DATETIME NOT NULL,
	[CurrentAccreditationDate] DATE NOT NULL,
	[NextAccreditationDate] DATE NOT NULL,
	[ManufacturingDate] DATE NOT NULL,
	[PortTypeId] INT NOT NULL,

	[FactoryNumber] BIGINT NOT NULL,
	[Firmware] NVARCHAR(16),
	[HubId] INT NULL,
	[TurnOn] BIT NOT NULL,

	[GiveCurrData] BIT NOT NULL,
	[GiveHArcData] BIT NOT NULL,
	[GiveDArcData] BIT NOT NULL,
	[GiveMArcData] BIT NOT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	[ProtocolSubTypeId] INT NOT NULL,
    [LastTimeSignatureId] INT,
	[LastSuccessConnectionTime] DATETIME NULL,

  CONSTRAINT PK_Business_MeasurementDevice PRIMARY KEY (Id),
	CONSTRAINT [FK_Business_MeasurementDevice_DeviceId_Dictionaries_Device_Id] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_AccessPointId_Business_AccessPointId] FOREIGN KEY ([AccessPointId]) REFERENCES [Business].[AccessPoint]([Id]) ON DELETE SET NULL,
	CONSTRAINT [FK_Business_MeasurementDevice_LastStatusConnectionId_Dictionaries_StatusConnection_Id] FOREIGN KEY ([LastStatusConnectionId]) REFERENCES [Dictionaries].[StatusConnection]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_ParityId_Dictionaries_Parity_Id] FOREIGN KEY ([ParityId]) REFERENCES [Dictionaries].[Parity]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_BaudId_Dictionaries_Baud_Id] FOREIGN KEY ([BaudId]) REFERENCES [Dictionaries].[Baud]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_ComPortId_Dictionaries_ComPort_Id] FOREIGN KEY ([ComPortId]) REFERENCES [Dictionaries].[ComPort]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_StopBitId_Dictionaries_StopBit_Id] FOREIGN KEY ([StopBitId]) REFERENCES [Dictionaries].[StopBit]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_DataId_Dictionaries_DataBit_Id] FOREIGN KEY ([DataBitId]) REFERENCES [Dictionaries].[DataBit]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_PortTypeId_Dictionaries_PortType_Id] FOREIGN KEY ([PortTypeId]) REFERENCES [Dictionaries].[PortType]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_ProtocolSubTypeId_Dictionaries_ProtocolSubType_Id] FOREIGN KEY ([ProtocolSubTypeId]) REFERENCES [Dictionaries].[ProtocolSubType]([Id]),
	CONSTRAINT [FK_Business_MeasurementDevice_HubId_Business_Hub_Id] FOREIGN KEY ([HubId]) REFERENCES [Business].[Hub]([Id]) ON DELETE SET NULL,
	
	CONSTRAINT [UQ_DeviceId_FactoryNumber] UNIQUE (DeviceId, FactoryNumber)
);

GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_PortTypeId] DEFAULT 3 FOR [PortTypeId];
GO


ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_AutoDefTimeoutAnswer] DEFAULT 5000 FOR [AutoDefTimeoutAnswer];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_AmountAttempt] DEFAULT 3 FOR [AmountAttempt];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_NetworkAddress] DEFAULT 1 FOR [NetworkAddress];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_ComPortId] DEFAULT 1 FOR [ComPortId];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_BaudId] DEFAULT 3 FOR [BaudId];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_DataBitId] DEFAULT 2 FOR [DataBitId];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_StopBitId] DEFAULT 0 FOR [StopBitId];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_ParityId] DEFAULT 0 FOR [ParityId];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_Priority] DEFAULT 0 FOR [Priority];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_LastStatusConnectionId] DEFAULT 1 FOR [LastStatusConnectionId];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_SuccessConnectionPercent] DEFAULT 0 FOR [SuccessConnectionPercent];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_LastConnectionTime] DEFAULT '1900-01-01' FOR [LastConnectionTime];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_PollingInterval] DEFAULT 60 FOR [PollingInterval];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_StartReadArchiveDate] DEFAULT '1900-01-01' FOR [StartReadArchiveDate];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_CurrentAccreditationDate] DEFAULT '1900-01-01' FOR [CurrentAccreditationDate];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_NextAccreditationDate] DEFAULT '1900-01-01' FOR [NextAccreditationDate];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_ManufacturingDate] DEFAULT '1900-01-01' FOR [ManufacturingDate];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_TurnOn] DEFAULT 1 FOR [TurnOn];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_GiveCurrData] DEFAULT 1 FOR [GiveCurrData];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_GiveHArcData] DEFAULT 1 FOR [GiveHArcData];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_GiveDArcData] DEFAULT 1 FOR [GiveDArcData];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_GiveMArcData] DEFAULT 1 FOR [GiveMArcData];
GO

ALTER TABLE [Business].[MeasurementDevice]
   ADD CONSTRAINT [DF_Business_MeasurementDevice_ProtocolSubTypeId] DEFAULT 1 FOR [ProtocolSubTypeId];
GO


CREATE NONCLUSTERED INDEX [IX_Business_MeasurementDevice_DeviceId] 
   ON [Business].[MeasurementDevice] ([DeviceId]);

GO

CREATE NONCLUSTERED INDEX [IX_Business_MeasurementDevice_ProtocolSubTypeId]
   ON [Business].[MeasurementDevice] ([ProtocolSubTypeId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_MeasurementDevice_AccessPointId] 
  ON [Business].[MeasurementDevice] ([AccessPointId])
  INCLUDE ([LastStatusConnectionId]) ;

GO

CREATE NONCLUSTERED INDEX [IX_Business_MeasurementDevice_HubId] 
   ON [Business].[MeasurementDevice] ([HubId]);
