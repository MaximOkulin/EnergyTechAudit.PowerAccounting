CREATE TABLE [Business].[EmergencyTimeSignature]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	[Time] DATETIME NOT NULL,

	CONSTRAINT [PK_Business_EmergencyTimeSignature] PRIMARY KEY ([Id])
);
GO

CREATE NONCLUSTERED INDEX [IX_Business_EmergencyTimeSignature_Time]
  ON [Business].[EmergencyTimeSignature] ([Time])
INCLUDE ([Id])


