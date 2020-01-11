CREATE TABLE [Business].[DeviceReader]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[MaxThreadCount] INT NOT NULL,
	[UpdateConfigInterval] INT NOT NULL,
	[QueuePollingInterval] INT NOT NULL,
	[HoveringTaskRemoveTime] INT NOT NULL, 	
    [DeviceReaderTypeId] INT NOT NULL,

	[SignalRNetAddress] NVARCHAR(16) NOT NULL,
	[SignalRPort] INT NOT NULL,
    [SignalRHub] NVARCHAR(64) NULL,

	[ServerCommunicatorNetAddress] NVARCHAR(128) NOT NULL,
	[UserId] INT NOT NULL,
	[ServerCommunicatorController] NVARCHAR(64) NOT NULL,
    [ServerCommunicatorReceiveAction] NVARCHAR(64) NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,
  	
  CONSTRAINT PK_Business_DeviceReader PRIMARY KEY (Id),
  CONSTRAINT [FK_Business_DeviceReader_DeviceReaderTypeId_Dictionaries_DeviceReaderType_Id] 
    FOREIGN KEY ([DeviceReaderTypeId]) REFERENCES [Dictionaries].[DeviceReaderType] ([Id]),
  CONSTRAINT [FK_Business_DeviceReader_UserId_Admin_User_Id]
    FOREIGN KEY ([UserId]) REFERENCES [Admin].[User]([Id])
)
GO

ALTER TABLE [Business].[DeviceReader]
   ADD CONSTRAINT [DF_Business_DeviceReader_MaxThreadCount] DEFAULT 50 FOR [MaxThreadCount];
GO   

ALTER TABLE [Business].[DeviceReader]
   ADD CONSTRAINT [DF_Business_DeviceReader_UpdateConfigInterval] DEFAULT 60 FOR [UpdateConfigInterval];
GO 

ALTER TABLE [Business].[DeviceReader]
   ADD CONSTRAINT [DF_Business_DeviceReader_QueuePollingInterval] DEFAULT 45 FOR [QueuePollingInterval];
GO 

ALTER TABLE [Business].[DeviceReader]
   ADD CONSTRAINT [DF_Business_DeviceReader_HoveringTaskRemoveTime] DEFAULT 5 FOR [HoveringTaskRemoveTime];
GO 

CREATE NONCLUSTERED INDEX [IX_Business_DeviceReader_UserId]
   ON [Business].[DeviceReader] ([UserId]);
GO






  
