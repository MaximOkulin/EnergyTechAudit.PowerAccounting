CREATE TABLE [Business].[Hub]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Description] NVARCHAR(64) NULL,
	[FactoryNumber] INT NOT NULL,
	[ExternalNetAddress] NVARCHAR(16),
	[ExternalPort] INT,
	[LocalNetAddress] NVARCHAR(16),
	[LocalPort] INT,
	[Identifier] INT NOT NULL,
	[DeviceReaderId] INT,

	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	[BuildingId] INT NOT NULL, 
   CONSTRAINT PK_Business_Hub PRIMARY KEY ([Id]),
	CONSTRAINT FK_Business_Hub_DeviceReaderId_Business_DeviceReader_Id FOREIGN KEY ([DeviceReaderId]) REFERENCES [Business].[DeviceReader]([Id]) ON DELETE SET NULL,
	CONSTRAINT FK_Business_Hub_BuildingId_Business_Building_Id FOREIGN KEY ([BuildingId]) REFERENCES [Business].[Building]([Id]) ON DELETE CASCADE
);

GO
CREATE NONCLUSTERED INDEX [IX_Business_Hub_DeviceReaderId] 
   ON [Business].[Hub] ([DeviceReaderId]);

GO
CREATE NONCLUSTERED INDEX [IX_Business_Hub_BuildingId] 
   ON [Business].[Hub] ([BuildingId]);
