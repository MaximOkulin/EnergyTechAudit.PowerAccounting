CREATE TABLE [Business].[MobileEmergencyMessage]
(
	[Id] BIGINT NOT NULL IDENTITY(1, 1),
    [Time] DATETIME NOT NULL,
    [MobileDeviceId] INT NOT NULL,
    [Address] NVARCHAR(MAX) NOT NULL,
    [EmergencyDescription] NVARCHAR(MAX) NOT NULL,
    [EmergencyValue] NVARCHAR(MAX) NOT NULL,
    [EmergencySituationParameterId] INT NOT NULL,
    [Delivered] BIT NOT NULL,
    [DeliveredTime] DATETIME NOT NULL,
	[ChannelId] INT NOT NULL,
	[MeasurementDeviceId] INT NOT NULL,

    CONSTRAINT [PK_Business_MobileEmergencyMessage] PRIMARY KEY ([Id]),

    CONSTRAINT [FK_Business_MobileEmergencyMessage_MobileDeviceId_Business_MobileDevice_Id]
              FOREIGN KEY ([MobileDeviceId]) REFERENCES [Business].[MobileDevice]([Id]) ON DELETE CASCADE,

    CONSTRAINT [FK_Business_MobileEmergencyMessage_EmergencySituationParameterId_Business_EmergencySituationParameter_Id]
              FOREIGN KEY ([EmergencySituationParameterId]) REFERENCES [Business].[EmergencySituationParameter]([Id]) ON DELETE CASCADE
)
GO

CREATE NONCLUSTERED INDEX [IX_Business_MobileEmergencyMessage_MobileDeviceId]
     ON [Business].[MobileEmergencyMessage]([MobileDeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_MobileEmergencyMessage_EmergencySituationParameterId]
     ON [Business].[MobileEmergencyMessage]([EmergencySituationParameterId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_MobileEmergencyMessage_ChannelId]
	ON [Business].[MobileEmergencyMessage]([ChannelId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_MobileEmergencyMessage_MeasurementDeviceId]
	ON [Business].[MobileEmergencyMessage]([MeasurementDeviceId]);
GO

