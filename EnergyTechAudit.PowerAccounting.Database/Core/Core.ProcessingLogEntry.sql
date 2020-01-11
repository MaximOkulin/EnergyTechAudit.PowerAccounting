CREATE TABLE [Core].[ProcessingLogEntry]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[ProcessingId] INT NOT NULL,
    [ProcessingStatusId] INT NOT NULL,
	[Parameters] NVARCHAR(MAX) NULL,
	
	[CreatedBy]  NVARCHAR(32) NOT NULL,
	[UpdatedBy]  NVARCHAR(32) NOT NULL,
	[CreatedDate] DATETIME NOT NULL,
	[UpdatedDate] DATETIME NOT NULL,

	CONSTRAINT PK_Core_ProcessingLogEntry_Id PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Core_ProcessingLogEntry_ProcessingId_Core_Processing_Id] FOREIGN KEY ([ProcessingId]) REFERENCES [Core].[Processing]([Id]),
	CONSTRAINT [FK_Core_ProcessingLogEntry_ProcessingStatusId_Dictionaries_ProcessingStatus_Id] FOREIGN KEY ([ProcessingStatusId]) REFERENCES [Dictionaries].[ProcessingStatus]([Id])	
)
GO

CREATE NONCLUSTERED INDEX [IX_Business_ProcessingLogEntry_ProcessingId]
  ON [Core].[ProcessingLogEntry] ([ProcessingId])
GO

CREATE NONCLUSTERED INDEX [IX_Business_ProcessingLogEntry_ProcessingLogStatusId]
  ON [Core].[ProcessingLogEntry] ([ProcessingStatusId])
GO

ALTER TABLE [Core].[ProcessingLogEntry]
   ADD CONSTRAINT [DF_Business_ProcessingLogEntry_ProcessingStatusId] DEFAULT 1 FOR [ProcessingStatusId];
GO
