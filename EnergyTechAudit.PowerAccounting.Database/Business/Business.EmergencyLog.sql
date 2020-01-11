CREATE TABLE [Business].[EmergencyLog]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[EmergencySituationParameterId] INT NOT NULL,
	[Value] NVARCHAR(256) NULL,
	[EmergencyTimeSignatureId] INT NOT NULL,
	[RecoveryTime] DATETIME NULL,

	[IsAcknowledgement] BIT NOT NULL, 
    [AcknowledgementUserName] NVARCHAR(32) NULL, 
    [AcknowledgementDate] DATETIME NULL, 
	[ShortTitle] NVARCHAR(256) NULL,

  CONSTRAINT [PK_Business_EmergencyLog] PRIMARY KEY ([Id]),

	CONSTRAINT [FK_Business_EmergencyLog_EmergencySituationParameterId_Business_EmergencySituationParameter_Id] 
	    FOREIGN KEY ([EmergencySituationParameterId]) REFERENCES [Business].[EmergencySituationParameter]([Id]) ON DELETE CASCADE,

  CONSTRAINT [FK_Business_EmergencyLog_EmergencyTimeSignatureId_Business_EmergencyTimeSignature_Id]
	    FOREIGN KEY ([EmergencyTimeSignatureId]) REFERENCES [Business].[EmergencyTimeSignature]([Id]),  
);
GO

ALTER TABLE [Business].[EmergencyLog]
   ADD CONSTRAINT [DF_Business_EmergencyLog_IsAcknowledgement] DEFAULT 0 FOR [IsAcknowledgement];
GO

/* Напрашивается объединение индексов */
CREATE NONCLUSTERED INDEX [IX_Business_EmergencyLog_EmergencySituationParameterId]
  ON [Business].[EmergencyLog]([EmergencySituationParameterId])
  INCLUDE ([EmergencyTimeSignatureId], [IsAcknowledgement],[AcknowledgementUserName],[AcknowledgementDate]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_EmergencyLog_EmergencySituationParameterId2]
  ON [Business].[EmergencyLog]([EmergencySituationParameterId])
  INCLUDE ([Value], [IsAcknowledgement], [AcknowledgementUserName], [AcknowledgementDate]);
/**/

GO
CREATE NONCLUSTERED INDEX [IX_Business_EmergencyLog_EmergencyTimeSignatureId]
      ON [Business].[EmergencyLog]([EmergencyTimeSignatureId]);
GO

/* By statistics */
CREATE INDEX [IX_Business_EmergencyLog_EmergencySituationParameterId3] 
ON [Business].[EmergencyLog] 
(
  [EmergencySituationParameterId]
) 
INCLUDE 
(
  [Id], [Value], [EmergencyTimeSignatureId], 
  [RecoveryTime], [IsAcknowledgement], 
  [AcknowledgementUserName], [AcknowledgementDate]
);