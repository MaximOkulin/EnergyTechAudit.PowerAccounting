-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2016-09-05
-- Description: Выборка архивов для мнемосхемы уровня помещения
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetMnemoschemeArchives]
  @placementId INT,  
  @measurementDeviceId INT,
  @channelId INT,
  @periodTypeId INT
AS
BEGIN
   SET NOCOUNT ON;
   SET XACT_ABORT ON;

  BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    BEGIN TRANSACTION;

    /* 1. Формирование имен резалтсетов */   	 
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName
    OUTPUT inserted.[Order], inserted.[Name]
    VALUES 
         (1, 'MainData');  
  
    /*2. Основная выборка */
   
    WITH [MeasurementDevices] AS
    (
      SELECT 
        [MeasurementDevice].[Id] [MeasurementDeviceId], 
        [MeasurementDevice].[LastTimeSignatureId],
        [Channel].[Id] [ChannelId],
        [Channel].[ChannelTemplateId],
        [MeasurementDevice].[DeviceId] [DeviceId]

      FROM [Business].[Placement] [Placement] 

      INNER JOIN [Business].[Channel] [Channel] 
        ON [Channel].[PlacementId] = [Placement].[Id]

      INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] 
        ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

        WHERE         
          [Placement].[Id] = @placementId 
          OR [Channel].[Id] = @channelId 
          OR [MeasurementDevice].[Id] = @measurementDeviceId
    ), 
      
    /* Матрица сопоставления в соответствии с шаблоном канала */
    [ParameterMapDeviceParameter]
    AS
    (
      SELECT 
        [ParameterMapDeviceParameter].[Id], 
        [ParameterMapDeviceParameter].[DeviceParameterId],       
        [ParameterMapDeviceParameter].[ParameterId], 
        [ParameterMapDeviceParameter].[ParameterDictionaryId], 
        
                
        [MeasurementDevices].[MeasurementDeviceId],
        [MeasurementDevices].[LastTimeSignatureId],
        [MeasurementDevices].[ChannelId],
        [MeasurementDevices].[ChannelTemplateId],
        [MeasurementDevices].[DeviceId],

        [Parameter].[Description] [ParameterDescription], 
        [Parameter].[Code] [ParameterCode], 

        COALESCE([Muc].[DimensionPrefix2], [Dimension].[Prefix]) [DimensionPrefix],
      
        COALESCE([Muc].[MeasurementUnitDescription2], [MeasurementUnit].[Description]) [MeasurementUnitDescription],

        [PhysicalParameter].[Id] [PhysicalParameterId],
        [PhysicalParameter].[Code] [PhysicalParameterCode],
        [PhysicalParameter].[Description] [PhysicalParameterDescription],
        [PhysicalParameter].[Order] [PhysicalParameterOrder],

        [Muc].[DimensionValue2] [DimensionValue2],
        [Dimension].[Value] [DimensionValue],
        [Muc].[Expression] [Expression]
    
      FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]
    
      
      INNER JOIN [Dictionaries].[Parameter] [Parameter] 
        ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId]
  
      INNER JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter]
        ON [PhysicalParameter].[Id] = [Parameter].[PhysicalParameterId]
    
      INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] 
        ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]
  
      INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] 
        ON [MeasurementUnit].[Id] = [ParameterMapDeviceParameter].[MeasurementUnitId]
  
      /* конвертация единиц измерения */
      LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc]     
        /* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
        ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 
      /**/

      INNER JOIN [Dictionaries].[Dimension] [Dimension]
        ON [Dimension].[Id] = [ParameterMapDeviceParameter].[DimensionId]
      
       INNER JOIN [MeasurementDevices] 
        ON [MeasurementDevices].[ChannelTemplateId] = [ParameterMapDeviceParameter].[ChannelTemplateId]
    
      WHERE         
        [ParameterMapDeviceParameter].[PeriodTypeId] IN (1, 5)
    )
   
      /* Выборка из архива */
      SELECT 
        [ParameterMapDeviceParameter].[Id],

        [ParameterMapDeviceParameter].[ParameterCode],
        [ParameterMapDeviceParameter].[ParameterDescription],
        [ParameterMapDeviceParameter].[DimensionPrefix],
        [ParameterMapDeviceParameter].[MeasurementUnitDescription],                 
        [Archive].[MeasurementDeviceId],
        [Archive].[Time],        
        [dbo].[ConvertMeasurementUnit]
        (
                [DimensionValue], 
                [DimensionValue2], 
                [Archive].[Value], 
                [Expression]
        ) [Value]
       
       ,[ParameterMapDeviceParameter].[ChannelId] [ChannelId]
       ,[ParameterMapDeviceParameter].[ChannelTemplateId] [ChannelTemplateId]
       ,[ParameterMapDeviceParameter].[DeviceId] [DeviceId]
         
       ,[PhysicalParameter].[Code] [PhysicalParameterCode]

       ,[ParameterDictionaryValue].[Description] [DictionaryValueDescription]
       ,[ParameterDictionaryValue].[Code] [DictionaryValueCode]
                  
      FROM [Business].[Archive] [Archive]
  
      INNER JOIN [ParameterMapDeviceParameter] 
        ON [ParameterMapDeviceParameter].[DeviceParameterId] = [Archive].[DeviceParameterId] 
        AND [ParameterMapDeviceParameter].[MeasurementDeviceId] = [Archive].[MeasurementDeviceId] 
        AND [ParameterMapDeviceParameter].[LastTimeSignatureId] = [Archive].[TimeSignatureId]        
      INNER JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter]

        ON [PhysicalParameter].[Id] = [ParameterMapDeviceParameter].[PhysicalParameterId]

      LEFT JOIN [Dictionaries].[ParameterDictionaryValue] [ParameterDictionaryValue] 
        ON [ParameterMapDeviceParameter].[ParameterDictionaryId] = [ParameterDictionaryValue].[ParameterDictionaryId]
        AND [Archive].[Value] = [ParameterDictionaryValue].[Value]
       
       WHERE 
          [Archive].[PeriodTypeId] IN (1,5) AND 
          [Archive].[IsValid] = 1

       ORDER BY [Archive].[Time] DESC

       OPTION (MAXDOP 3, OPTIMIZE FOR ( @placementId = NULL, @measurementDeviceId = NULL, @channelId UNKNOWN) );
                     
       COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF (XACT_STATE()) = -1
    BEGIN       
      ROLLBACK TRANSACTION;
    END;
    IF (XACT_STATE()) = 1
    BEGIN      
      COMMIT TRANSACTION;   
    END;

    RETURN (3); 
  END CATCH;
	   	   	                     
  RETURN 0;

END;
GO