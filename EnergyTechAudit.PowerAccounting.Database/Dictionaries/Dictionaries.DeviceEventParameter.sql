CREATE TABLE [Dictionaries].[DeviceEventParameter]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(256) NOT NULL,
	[DeviceId] INT NOT NULL,

	CONSTRAINT PK_Dictionaries_DeviceEventParameter PRIMARY KEY(Id),
	CONSTRAINT FK_Dictionaries_DeviceEventParameter_DeviceId_Dictionaries_Device_Id FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id])
);

GO

CREATE NONCLUSTERED INDEX [IX_Dictionaries_DeviceEventParameter_DeviceId]
  ON [Dictionaries].[DeviceEventParameter] ([DeviceId])
