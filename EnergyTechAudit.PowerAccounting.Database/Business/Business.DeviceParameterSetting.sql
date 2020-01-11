CREATE TABLE [Business].[DeviceParameterSetting]
(
	[Id] INT NOT NULL,
	[Min] DECIMAL(9,3) NOT NULL,
	[Max] DECIMAL(9,3) NOT NULL,
	[WriteMethodName] NVARCHAR(64) NULL,
	[ValueTypeCode] NVARCHAR(16) NOT NULL,
	
	CONSTRAINT [PK_Business_DeviceParameterSetting] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Business_DeviceParameterSetting_Id_Dictionaries_DeviceParameter_Id] FOREIGN KEY ([Id]) REFERENCES [Dictionaries].[DeviceParameter]([Id]) ON DELETE CASCADE
)






