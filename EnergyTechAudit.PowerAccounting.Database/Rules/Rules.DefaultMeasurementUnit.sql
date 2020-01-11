CREATE TABLE [Rules].[DefaultMeasurementUnit]
(
    [Id] INT NOT NULL IDENTITY(1, 1),     
    [Code] NVARCHAR(64) NOT NULL, 
    [Description] NVARCHAR(128) NULL,
    [PhysicalParameterId] INT NOT NULL, 
    [DimensionId] INT NOT NULL, 
    [MeasurementUnitId] INT NOT NULL 

    CONSTRAINT [PK_Rules_DefaultMeasurementUnit_Id] 
      PRIMARY KEY ([Id]),
        
    CONSTRAINT [FK_Rules_DefaultMeasurementUnit_PhysicalParameterId_Dictionaries_PhysicalParameter_Id] 
      FOREIGN KEY ([PhysicalParameterId]) REFERENCES [Dictionaries].[PhysicalParameter] ([Id]),
    
    CONSTRAINT [FK_Rules_DefaultMeasurementUnit_MeasurementUnitId_Dictionaries_MeasurementUnit_Id] 
      FOREIGN KEY ([MeasurementUnitId]) REFERENCES [Dictionaries].[MeasurementUnit] ([Id]),

    CONSTRAINT [FK_Rules_DefaultMeasurementUnit_DimentionId_Dictionaries_Dimension_Id] 
      FOREIGN KEY ([DimensionId]) REFERENCES [Dictionaries].[Dimension] ([Id])       
);

GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_Rules_DefaultMeasurementUnit_Id]
  ON [Rules].[DefaultMeasurementUnit] ([Id])
  INCLUDE ([DimensionId], [MeasurementUnitId], [PhysicalParameterId]);

GO
