CREATE TABLE [Dictionaries].[MeasurementUnit]
(
	[Id] INT NOT NULL IDENTITY(1,1),
	Code NVARCHAR(64) NOT NULL,
	[Description] NVARCHAR(32) NOT NULL,
	[PhysicalParameterId] INT NOT NULL,

	CONSTRAINT PK_Dictionaries_MeasurementUnit PRIMARY KEY(Id),
	CONSTRAINT [FK_Dictionaries_MeasurementUnit_PhysicalParameterId_Dictionaries_PhysicalParameter_Id] FOREIGN KEY ([PhysicalParameterId]) REFERENCES [Dictionaries].[PhysicalParameter]([Id])
);

GO
CREATE NONCLUSTERED INDEX [IX_Dictionaries_MeasurementUnit_PhysicalParameterId] 
   ON [Dictionaries].[MeasurementUnit] ([PhysicalParameterId]);
