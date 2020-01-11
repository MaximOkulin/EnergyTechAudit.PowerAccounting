CREATE TABLE [Business].[DeviceLinkDynamicParameter]
(
	[DeviceId] INT NOT NULL,
	[DynamicParameterId] INT NOT NULL,

	CONSTRAINT [PK_Business_DeviceLinkDynamicParameter] PRIMARY KEY ([DeviceId], [DynamicParameterId]),
	CONSTRAINT [FK_Business_DeviceLinkDynamicParameter_DeviceId_Dictionaries_Device_Id] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id]),
	CONSTRAINT [FK_Business_DeviceLinkDynamicParameter_DynamicParameterId_Dictionaries_DynamicParameter_Id] FOREIGN KEY ([DynamicParameterId]) REFERENCES [Dictionaries].[DynamicParameter]([Id])
)
GO

CREATE NONCLUSTERED INDEX [IX_Business_DeviceLinkDynamicParameter_DeviceId]
 ON [Business].[DeviceLinkDynamicParameter] ([DeviceId]);
 
GO

 CREATE NONCLUSTERED INDEX [IX_Business_DeviceLinkDynamicParameter_DynamicParameterId]
   ON [Business].[DeviceLinkDynamicParameter] ([DynamicParameterId]);

GO

