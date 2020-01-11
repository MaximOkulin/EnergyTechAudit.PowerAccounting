CREATE TABLE [Dictionaries].[DeviceParameter]
(
   [Id] INT NOT NULL IDENTITY(1, 1),
   [Code] NVARCHAR(64) NOT NULL, 
   [Description] NVARCHAR(128) NOT NULL, 
   [DeviceId] INT NOT NULL, 
   CONSTRAINT [PK_Dictionaries_DeviceParameter_Id] PRIMARY KEY ([Id]),
   CONSTRAINT [FK_Dictionaries_DeviceParameter_DeviceId] FOREIGN KEY ([DeviceId]) REFERENCES [Dictionaries].[Device] ([Id])
)
GO

CREATE NONCLUSTERED INDEX [IX_Dictionaries_DeviceParameter_DeviceIdId]
  ON [Dictionaries].[DeviceParameter] ( [DeviceId] )  
  INCLUDE ([Id], [Code], [Description]);
GO
  
CREATE NONCLUSTERED INDEX [IX_Dictionaries_DeviceParameter_Code] 
  ON [Dictionaries].[DeviceParameter] ([Code])
