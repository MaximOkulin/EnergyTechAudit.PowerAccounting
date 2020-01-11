-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20141010
-- Description: Указывает, что метаобъект связан с конкретным типом устройств
-- ===================================================================================================

CREATE TABLE [Core].[MetaObjectLinkDevice]
(
	[MetaObjectId] INT NOT NULL, 
   [DeviceId] INT NOT NULL,

	CONSTRAINT PK_Core_MetaObjectLinkDevice PRIMARY KEY([MetaObjectId], [DeviceId]),

	CONSTRAINT [FK_Core_MetaObjectLinkDevice_MetaObjectId_Core_MetaObject_Id] FOREIGN KEY ([MetaObjectId]) REFERENCES [Core].[MetaObject]([Id]),

	CONSTRAINT [FK_Core_MetaObjectLinkDevice_DeviceId_Dictionaries_Device_Id] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObjectLinkDevice_MetaObjectId] 
   ON [Core].[MetaObjectLinkDevice] ([MetaObjectId]);

GO
CREATE NONCLUSTERED INDEX [IX_Core_MetaObjectLinkDevice_DeviceId] 
   ON [Core].[MetaObjectLinkDevice] ([DeviceId]);
