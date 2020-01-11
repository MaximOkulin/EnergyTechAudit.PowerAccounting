CREATE TABLE [Dictionaries].[Device]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[ItemId] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL CONSTRAINT [DF_Dictionaries_Device_ItemId] DEFAULT NEWID(),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128),
	[ArchiveDepthHour] INT NOT NULL CONSTRAINT [DF_Dictionaries_Device_ArchiveDepthHour] DEFAULT 0,
	[ArchiveDepthDay] INT NOT NULL CONSTRAINT [DF_Dictionaries_Device_ArchiveDepthDay] DEFAULT 0,
	[ArchiveDepthMonth] INT NOT NULL CONSTRAINT [DF_Dictionaries_Device_ArchiveDepthMonth] DEFAULT 0,
	[ShortName] NVARCHAR(128) NOT NULL,
	[Image] VARBINARY(max) NULL,
	[HasDigitalInterface] BIT NOT NULL,
	[CalibrationInterval] INT NOT NULL CONSTRAINT [DF_Dictionaries_Device_CalibrationInterval] DEFAULT 0,
	[BaudId] INT NOT NULL, 
    [DataBitId] INT NOT NULL, 
    [StopBitId] INT NOT NULL, 
    [ParityId] INT NOT NULL, 
    [ChannelsCount] INT NOT NULL CONSTRAINT [DF_Dictionaries_Device_ChannelsCount] DEFAULT 1,
	[IsIntegralArchiveValue] BIT NOT NULL,
   
  CONSTRAINT PK_Dictionaries_Device PRIMARY KEY(Id),

	CONSTRAINT [FK_Dictionaries_Device_BaudId_Dictionaries_Baud_Id] FOREIGN KEY ([BaudId]) REFERENCES [Dictionaries].[Baud]([Id]),	
	CONSTRAINT [FK_Dictionaries_Device_DataId_Dictionaries_DataBit_Id] FOREIGN KEY ([DataBitId]) REFERENCES [Dictionaries].[DataBit]([Id]),	
	CONSTRAINT [FK_Dictionaries_Device_ParityId_Dictionaries_Parity_Id] FOREIGN KEY ([ParityId]) REFERENCES [Dictionaries].[Parity]([Id]),	
	CONSTRAINT [FK_Dictionaries_Device_StopBitId_Dictionaries_StopBit_Id] FOREIGN KEY ([StopBitId]) REFERENCES [Dictionaries].[StopBit]([Id]),

  CONSTRAINT [UQ_Dictionaries_Device_ItemId] UNIQUE ([ItemId])

);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_Device_BaudId] 
   ON [Dictionaries].[Device] ([BaudId]);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_Device_DataId] 
   ON [Dictionaries].[Device] ([DataBitId]);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_Device_ParityId] 
   ON [Dictionaries].[Device] ([ParityId]);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_Device_StopBitId] 
   ON [Dictionaries].[Device] ([StopBitId]);
