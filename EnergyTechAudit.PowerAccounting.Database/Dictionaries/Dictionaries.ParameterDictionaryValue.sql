CREATE TABLE [Dictionaries].[ParameterDictionaryValue]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Code] NVARCHAR(64) NULL,
	[Description] NVARCHAR(128) NULL,
	[Value] DECIMAL(19, 7) NOT NULL,
	[DeviceId] INT NOT NULL,
	[ParameterDictionaryId] INT NOT NULL,

	CONSTRAINT [PK_Dictionaries_ParameterDictionaryValue] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Dictionaries_ParameterDictionaryValue_DeviceId_Dictionaries_Device_Id] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device]([Id]),
	CONSTRAINT [FK_Dictionaries_ParameterDictionaryValue_DictionaryId_Dictionaries_ParameterDictionary_Id] FOREIGN KEY ([ParameterDictionaryId]) REFERENCES [Dictionaries].[ParameterDictionary]([Id])
)
GO

CREATE NONCLUSTERED INDEX [IX_Dictionaries_ParameterDictionaryValue_DeviceId]
     ON [Dictionaries].[ParameterDictionaryValue] ([DeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Dictionaries_ParameterDictionaryValue_ParameterDictionaryId]
    ON [Dictionaries].[ParameterDictionaryValue] ([ParameterDictionaryId]);
GO
