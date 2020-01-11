CREATE TABLE [Business].[ChannelTemplate]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(128),
	[ResourceSystemTypeId] INT NOT NULL,
	[DeviceId] INT NOT NULL,
    [MnemoschemeId] INT NULL, 
	[Comment] NVARCHAR(128) NULL,
	[ResourceSubsystemTypeId] INT NULL,

  [CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

   CONSTRAINT PK_Business_ChannelTemplate PRIMARY KEY (Id),

	CONSTRAINT [FK_Business_ChannelTemplate_ResourceSystemTypeId_Dictionaries_SystemType_Id] 
      FOREIGN KEY ([ResourceSystemTypeId]) REFERENCES [Dictionaries].[ResourceSystemType]([Id]),
	
   CONSTRAINT [FK_Business_ChannelTemplate_DeviceId_Dictionaries_Device_Id] 
      FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id]),

   CONSTRAINT [FK_Business_ChannelTemplate_MnemoschemeId]
      FOREIGN KEY ([MnemoschemeId]) REFERENCES [Business].[Mnemoscheme] ([Id]),

   CONSTRAINT [FK_Business_ChannelTemplate_ResourceSubsystemTypeId_Dictionaries_ResourceSubsystemType_Id]
      FOREIGN KEY ([ResourceSubsystemTypeId]) REFERENCES [Dictionaries].[ResourceSubsystemType]([Id])   
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_ChannelTemplate_ResourceSubsystemTypeId]
     ON [Business].[ChannelTemplate]([ResourceSubsystemTypeId]);

