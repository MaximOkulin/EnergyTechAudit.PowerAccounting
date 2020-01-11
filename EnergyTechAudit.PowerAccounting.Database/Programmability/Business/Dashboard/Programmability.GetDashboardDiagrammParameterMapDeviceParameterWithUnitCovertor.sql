CREATE FUNCTION [Programmability].[GetDashboardDiagrammParameterMapDeviceParameterWithUnitCovertor]
(  
  @parameterMapDeviceParameterId INT
)
RETURNS TABLE AS
RETURN
(
  SELECT 
        [ParameterMapDeviceParameter].[Id],
        [ParameterMapDeviceParameter].[ParameterId],
        [ParameterMapDeviceParameter].[DeviceParameterId],
        [ParameterMapDeviceParameter].[PeriodTypeId],
        [Dimension].[Value] [DimensionValue],
        
        COALESCE([Muc].[MeasurementUnitDescription2], [MeasurementUnit].[Description]) [MeasurementUnitDescription],
        COALESCE([Muc].[DimensionPrefix2], [Dimension].[Prefix]) [DimensionPrefix],

        [Muc].[DimensionValue2],        
        [Muc].[Expression]

      FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]

      INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit]
        ON [MeasurementUnit].[Id] = [ParameterMapDeviceParameter].[MeasurementUnitId]

      INNER JOIN [Dictionaries].[Dimension] [Dimension]
        ON [Dimension].[Id] = [ParameterMapDeviceParameter].[DimensionId] 

      /* конвертация единиц измерения */
      LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc] 
      /* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
      ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 
      /**/ 
     
     WHERE
       [ParameterMapDeviceParameter].[Id] = @parameterMapDeviceParameterId

)

