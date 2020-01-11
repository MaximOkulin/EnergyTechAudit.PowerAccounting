CREATE TABLE [Business].[CsdModem]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(64) NULL,
	[NetPhone] NVARCHAR(16) NOT NULL,

	[ComPortId] INT NOT NULL,
	[DeviceId] INT NOT NULL,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	CONSTRAINT [PK_Business_CsdModem] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_CsdModem_ComPortId_Dictionaries_ComPort_Id] FOREIGN KEY ([ComPortId]) REFERENCES [Dictionaries].[ComPort]([Id]),
	CONSTRAINT [FK_Business_CsdModem_DeviceId_Dictionaries_Device_Id] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id])
)
GO

ALTER TABLE [Business].[CsdModem]
   ADD CONSTRAINT [DF_Business_CsdModem_ComPortId] DEFAULT 1 FOR [ComPortId];
GO

CREATE NONCLUSTERED INDEX [IX_Business_CsdModem_DeviceId] 
   ON [Business].[CsdModem] ([DeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_CsdModem_ComPortId] 
   ON [Business].[CsdModem] ([ComPortId]);
GO