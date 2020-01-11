CREATE TABLE [Dictionaries].[InternalDeviceEvent]
(
	[Id] INT NOT NULL IDENTITY(1, 1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(128) NOT NULL,
	[DeviceId] INT NOT NULL,

	CONSTRAINT [PK_Dictionaries_InternalDeviceEvent_Id] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Dictionaries_InternalDeviceEvent_DeviceId_Dictionaries_Device_Id] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id])
)
