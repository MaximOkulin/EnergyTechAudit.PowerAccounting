-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2014-11-30
-- Description: Отбираем из конвертора записи, для которых есть выходная единица измерения из списка предпочитаемых
-- ===================================================================================================

CREATE VIEW [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView]
WITH SCHEMABINDING
AS 

SELECT
  [DefaultMeasurementUnit].[PhysicalParameterId], 
  [Dimension].[Value] [DimensionValue2],
  [Dimension].[Prefix] [DimensionPrefix2],
  [DefaultMeasurementUnit].[MeasurementUnitId] [PreferenceMeasurementUnitId],              
  [MeasurementUnitConverter].[MeasurementUnit1Id], 
  [MeasurementUnitConverter].[MeasurementUnit2Id],        
  [MeasurementUnit].[Description] [MeasurementUnitDescription2],
  [MeasurementUnitConverter].[Expression] [Expression]

FROM [Rules].[MeasurementUnitConverter] [MeasurementUnitConverter] 
              
INNER JOIN [Rules].[DefaultMeasurementUnit] [DefaultMeasurementUnit] 
    -- по физ вечичине
  ON [MeasurementUnitConverter].[PhysicalParameterId] = [DefaultMeasurementUnit].[PhysicalParameterId] AND 
    -- есть правило с предпочитаемой выходная единица измерения
    [MeasurementUnitConverter].[MeasurementUnit2Id] = [DefaultMeasurementUnit].[MeasurementUnitId]

INNER JOIN [Dictionaries].[Dimension] [Dimension]
    ON [Dimension].[Id] = [DefaultMeasurementUnit].[DimensionId]

INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] 
  ON [MeasurementUnit].[Id] = [MeasurementUnitConverter].[MeasurementUnit2Id]
