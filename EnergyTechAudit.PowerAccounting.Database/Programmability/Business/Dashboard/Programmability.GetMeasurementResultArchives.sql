-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2014-10-08
-- Description: Возвращает архивные в соответствии с каналом измерительного устройства
-- для виджета "Результаты измерений"
-- ===================================================================================================

CREATE PROCEDURE Programmability.GetMeasurementResultArchives
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
    INSERT INTO @resultSetName VALUES 
        (1, 'MainData'),
        (2, 'ColumnCaption'),
        (3, 'PeriodTypes'),
        (4, 'LastTimeSignature');    

      SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	     FROM @resultSetName [ResultSetName];
  
  
    /*2. Основная выборка */
   
    /* Идентификатор шаблона канала */
    DECLARE @channelTemplateId INT = 
    (
      SELECT [ChannelTemplateId] 
      FROM [Business].[Channel] [Channel] 
      WHERE [Channel].[Id] = @channelId
    );

    /* Последняя временная сигнатура */
    DECLARE @lastTimeSignatureId INT = 
    (      
      SELECT [MeasurementDevice].[LastTimeSignatureId] 
      FROM [Business].[MeasurementDevice] [MeasurementDevice] 
      WHERE [MeasurementDevice].[Id] = @measurementDeviceId    
    );

    IF @lastTimeSignatureId IS NULL
    BEGIN 
      SET @lastTimeSignatureId = 
      (
        SELECT [TimeSignature].[Id] FROM
          (
              SELECT 
                [TimeSignature].[Id], 
                ROW_NUMBER() OVER(ORDER BY [TimeSignature].[Time] DESC) [Num]
  
              FROM [Business].[TimeSignature] [TimeSignature]
  
              WHERE [TimeSignature].[MeasurementDeviceId] = @measurementDeviceId
  
          ) [TimeSignature]
          WHERE [Num]= 1
      );
    END;
    
    /* Матрица сопоставления в соответствии с шаблоном канала */
    WITH [ParameterMapDeviceParameter]
    AS
    (
      SELECT 
        [ParameterMapDeviceParameter].[Id], 
        [ParameterMapDeviceParameter].[DeviceParameterId],       
        [ParameterMapDeviceParameter].[ParameterId], 
        [ParameterMapDeviceParameter].[ParameterDictionaryId], 
        [ParameterMapDeviceParameter].[Order],
        
        [Parameter].[Description] [ParameterDescription], 

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
    
      WHERE [ParameterMapDeviceParameter].[PeriodTypeId] = @periodTypeId 
        AND [ParameterMapDeviceParameter].[ChannelTemplateId] = @channelTemplateId    
    )
   
      /* Выборка из архива */
      SELECT 
            
        [ParameterMapDeviceParameter].[Id],
        [ParameterMapDeviceParameter].[ParameterId],
            
        [ParameterMapDeviceParameter].[ParameterDescription],  
        [ParameterMapDeviceParameter].[DimensionPrefix],
        [ParameterMapDeviceParameter].[MeasurementUnitDescription], 
        
        [ParameterMapDeviceParameter].[PhysicalParameterId],
        [ParameterMapDeviceParameter].[PhysicalParameterCode], 
        [ParameterMapDeviceParameter].[PhysicalParameterDescription], 
        [ParameterMapDeviceParameter].[PhysicalParameterOrder],

        [Archive].[Time],
        [Archive].[IsValid],
        [dbo].[ConvertMeasurementUnit]
        (
                [DimensionValue], 
                [DimensionValue2], 
                [Archive].[Value], 
                [Expression]
        ) [Value]  

        ,[ParameterDictionaryValue].[Description] [DictionaryValueDescription]
        ,[ParameterDictionaryValue].[Code] [DictionaryValueCode]

      FROM [Business].[Archive] [Archive]
  
      INNER JOIN [ParameterMapDeviceParameter] 
        ON [ParameterMapDeviceParameter].[DeviceParameterId] = [Archive].[DeviceParameterId]

      LEFT JOIN [Dictionaries].[ParameterDictionaryValue] [ParameterDictionaryValue]
        ON [ParameterDictionaryValue].[ParameterDictionaryId] = [ParameterMapDeviceParameter].[ParameterDictionaryId]
        AND [Archive].[Value] = [ParameterDictionaryValue].[Value]

      WHERE 
          [Archive].[PeriodTypeId] = @periodTypeId 
          AND [Archive].[TimeSignatureId] = @lastTimeSignatureId 
          AND [Archive].[MeasurementDeviceId] = @measurementDeviceId
   
     ORDER BY [ParameterMapDeviceParameter].[Order];

     /* 3. Вспомогательная таблица с расшифровками столбцов */
   
     DECLARE @columnCaption [Programmability].[ColumnCaptionTableType] ;

     INSERT INTO @columnCaption 
     OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
     VALUES     
	     
       ('MainData', 'PhysicalParameterCode', 'Код физ. величины', 0, 20)
       ,('MainData', 'PhysicalParameterId', 'Ид. физ. величины', 0, 20)
       ,('MainData', 'PhysicalParameterOrder', 'Порядок физ. величины', 0, 20)       	     
	   ,('MainData',  'ParameterDescription', 'Параметр', 1, 40)	   
       ,('MainData',  'DimensionPrefix', 'Размерность', 0, 50)	   
	   ,('MainData',  'MeasurementUnitDescription', 'Ед. измерения', 0, 60)
	   ,('MainData',  'PhysicalParameterCode', 'Код физ. величина', 0, 70)
	   ,('MainData',  'PhysicalParameterDescription', 'Физ. величина', 0, 80)
	   ,('MainData',  'IsValid', 'Физ. величина', 0, 85)       
       ,('MainData',  'Value', 'Значение', 1, 90);
       
       SELECT [Id] ,
              [Code] ,
              [Description] 
       FROM [Dictionaries].[PeriodType] [PeriodType]
       WHERE [PeriodType].[Id] IN (1, 5);     
    
       SELECT 
            [TimeSignature].[Id]
            ,[TimeSignature].[MeasurementDeviceId]
            ,[TimeSignature].[Time]
            ,[TimeSignature].[DeviceTime]
            ,[TimeSignature].[PollingDuration]
            ,[TimeSignature].[StatusConnectionId] 
        FROM [Business].[TimeSignature] [TimeSignature]
        WHERE [TimeSignature].[Id] = @lastTimeSignatureId        
         
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