CREATE TABLE [Rules].[MeasurementUnitConverter]
(
    [Id] INT NOT NULL IDENTITY(1, 1), 
    [Description] NVARCHAR(128) NULL,
    [PhysicalParameterId] INT NOT NULL, 
    [MeasurementUnit1Id] INT NOT NULL, 
    [MeasurementUnit2Id] INT NOT NULL,
    [Expression] NVARCHAR(128) NOT NULL,

    CONSTRAINT [PK_Rules_MeasurementUnitConverter_Id] 
      PRIMARY KEY ([Id]),
    
    CONSTRAINT [FK_Rules_MeasurementUnitConverter_PhysicalParameterId_Dictionaries_PhysicalParameter_Id] 
      FOREIGN KEY ([PhysicalParameterId]) REFERENCES [Dictionaries].[PhysicalParameter] ([Id]),
    
    CONSTRAINT [FK_Rules_MeasurementUnitConverter_MeasurementUnit1Id_Dictionaries_MeasurementUnit_Id] 
      FOREIGN KEY ([MeasurementUnit1Id]) REFERENCES [Dictionaries].[MeasurementUnit] ([Id]),

    CONSTRAINT [FK_Rules_MeasurementUnitConverter_MeasurementUnit2Id_Dictionaries_MeasurementUnit_Id] 
      FOREIGN KEY ([MeasurementUnit2Id]) REFERENCES [Dictionaries].[MeasurementUnit] ([Id]),

    CONSTRAINT [UQ_Rules_MeasurementUnitConverter_PhysicalParameterId_MeasurementUnit1Id_MeasurementUnit2Id] 
      UNIQUE ([PhysicalParameterId], [MeasurementUnit1Id], [MeasurementUnit2Id]),

    CONSTRAINT [CHK_Rules_MeasurementUnitConverter_PhysicalParameter] 
      CHECK ([Programmability].[CheckMeasurementUnitConverter](PhysicalParameterId, MeasurementUnit1Id, MeasurementUnit2Id) = 1)
)
GO

CREATE NONCLUSTERED INDEX [IX_Rules_MeasurementUnitConverter_PhysicalParameterId]
  ON [Rules].[MeasurementUnitConverter] (PhysicalParameterId)
GO

CREATE NONCLUSTERED INDEX [IX_Rules_MeasurementUnitConverter_MeasurementUnit1Id]
  ON [Rules].[MeasurementUnitConverter] (MeasurementUnit1Id)
GO

CREATE NONCLUSTERED INDEX [IX_Rules_MeasurementUnitConverter_MeasurementUnit2Id]
  ON [Rules].[MeasurementUnitConverter] (MeasurementUnit2Id)
GO