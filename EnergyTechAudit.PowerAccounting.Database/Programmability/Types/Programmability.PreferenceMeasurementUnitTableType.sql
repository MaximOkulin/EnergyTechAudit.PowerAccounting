CREATE TYPE [Programmability].[PreferenceMeasurementUnitTableType]
AS TABLE   
   (
      [Id] INT PRIMARY KEY,
      [PhysicalParameterId] INT,
      [DimensionId] INT,
      [MeasurementUnitId] INT
   );