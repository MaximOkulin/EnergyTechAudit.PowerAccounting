CREATE TABLE [Business].[Archive]
(
	[Id] BIGINT NOT NULL IDENTITY(1,1),
	[TimeSignatureId] INT NOT NULL,
	[PeriodTypeId] INT NOT NULL,
	[Time] DATETIME NOT NULL,
	
	[Value] DECIMAL(19, 7) NOT NULL,
	
	[IsValid] BIT NOT NULL,
		
	--переход на новую модель параметров
	[MeasurementDeviceId] INT NOT NULL,
	[DeviceParameterId] INT NOT NULL,
	
	CONSTRAINT [PK_Business_Archive] PRIMARY KEY ([Id], [PeriodTypeId]),
	CONSTRAINT [FK_Business_Archive_TimeSignatureId_Business_TimeSignature_Id] FOREIGN KEY ([TimeSignatureId]) REFERENCES [Business].[TimeSignature]([Id]),
	CONSTRAINT [FK_Business_Archive_PeriodTypeId_Dictionaries_PeriodType_Id] FOREIGN KEY ([PeriodTypeId]) REFERENCES [Dictionaries].[PeriodType]([Id]),
	
	CONSTRAINT [FK_Business_Archive_MeasurementDeviceId_Business_MeasurementDevice_Id] FOREIGN KEY ([MeasurementDeviceId]) REFERENCES [Business].[MeasurementDevice]([Id]) ON DELETE CASCADE,
	CONSTRAINT [FK_Business_Archive_DeviceParameterId_Dictionaries_DeviceParameter_Id] FOREIGN KEY ([DeviceParameterId]) REFERENCES [Dictionaries].[DeviceParameter]([Id]),

	CONSTRAINT [UQ_Business_Archive_PeriodTypeId_Time_MeasurementDeviceId_DeviceParameterId] UNIQUE ([PeriodTypeId], [Time], [MeasurementDeviceId], [DeviceParameterId])
	
) ON [ArchivePartitionSchemeByPeriodType](PeriodTypeId);

GO

CREATE NONCLUSTERED INDEX [IX_Business_Archive_TimeSignatureId] 
   ON [Business].[Archive] ([TimeSignatureId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_Archive_MeasurementDeviceId] 
   ON [Business].[Archive] ([MeasurementDeviceId]);
GO

CREATE NONCLUSTERED INDEX [IX_Business_Archive_PeriodTypeId_MeasurementDeviceId]
  ON [Business].[Archive] ([PeriodTypeId],[MeasurementDeviceId],[Time])
  INCLUDE ([Value],[DeviceParameterId])

GO

/* missing index by statistics */
CREATE NONCLUSTERED INDEX [IX_Business_Archive_PeriodTypeId_MeasurementDeviceId_DeviceParameterId]
  ON [Business].[Archive]  ([PeriodTypeId], [MeasurementDeviceId], [DeviceParameterId])
  INCLUDE ([Time]);

GO

/* missing index by statistics Index_Useful = 6749.68 */
CREATE INDEX [IX_Business_Archive_PeriodTypeId_MeasurementDeviceId_DeviceParameterId_Time]
  ON [Business].[Archive] ([PeriodTypeId], [MeasurementDeviceId], [DeviceParameterId], [Time]) 
  INCLUDE ([TimeSignatureId], [Value])

GO

/*
  Missing Index Details from ExecutionPlan1.sqlplan
  The Query Processor estimates that implementing the following index could improve the query cost by 39.3283%.
*/

/*
CREATE NONCLUSTERED INDEX [IX_Business_Archive_TimeSignatureId_MeasurementDeviceId_PeriodTypeId]
  ON [Business].[Archive] ([TimeSignatureId], [MeasurementDeviceId], [PeriodTypeId])
  INCLUDE ([Time], [Value], [DeviceParameterId])
GO
*/

/*
Missing Index Details from SQLQuery2.sql - 217.173.22.234,61433\SQLSERVER.EnergyTechAudit.PowerAccounting.Database (sa (111))
The Query Processor estimates that implementing the following index could improve the query cost by 98.965%.
*/

/*
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [Business].[Archive] ([PeriodTypeId],[MeasurementDeviceId],[Time])
INCLUDE ([Id],[Value],[IsValid],[DeviceParameterId])
GO
*/