CREATE PROCEDURE [Programmability].[GetArchiveRowByDate]
@channelTemplateId INT,
@date DATETIME,
@channelId INT,
@measurementDeviceId INT,
@periodTypeId INT
AS
BEGIN
  SET NOCOUNT ON;

  SET XACT_ABORT ON;

  BEGIN TRY

    /* все выборки в составе хранимой процедуры имеют статус "грязных" */
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN TRANSACTION;

    -- таблица со списком параметров в соответствии с типом прибора 
    DECLARE @deviceParameterCodePull [Programmability].[CodePullTableType];

    INSERT INTO @deviceParameterCodePull
      SELECT
        [Parameter].[Id] [Id]
       ,[Parameter].[Code] [Code]
      FROM [Dictionaries].[Parameter] [Parameter] WITH (NOLOCK)
      INNER JOIN [Business].[ParameterMapDeviceParameter] [Map] WITH (NOLOCK)
        ON [Parameter].[Id] = [Map].[ParameterId]
          AND [Map].[PeriodTypeId] = @periodTypeId
      INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
        ON [ChannelTemplate].[Id] = [Map].[ChannelTemplateId]
      INNER JOIN [Business].[Channel] WITH (NOLOCK)
        ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
          AND [Channel].[Id] = @channelId
      WHERE [Channel].[MeasurementDeviceId] = @measurementDeviceId

    -- собираем строку со списком параметров отчета для возможности динамического из разворота 
    DECLARE @deviceParameterCodeFields NVARCHAR(MAX) = '';
    DECLARE @deviceParameterCodeFieldsWithNext NVARCHAR(MAX) = '';

    SELECT
      @deviceParameterCodeFields =
      @deviceParameterCodeFields
      + CONCAT('[', [D].[Code], ']') + ', '
     ,@deviceParameterCodeFieldsWithNext =
      @deviceParameterCodeFieldsWithNext
      + CONCAT('[', [D].[Code], ']') + ', '
      + CONCAT('LEAD([', [D].[Code], ']) OVER(ORDER BY [Time]) [', [D].[Code], '.Next', ']') + ','

    FROM @deviceParameterCodePull [D];

    SET @deviceParameterCodeFields = LEFT(@deviceParameterCodeFields, LEN(@deviceParameterCodeFields) - 1);
    SET @deviceParameterCodeFieldsWithNext = LEFT(@deviceParameterCodeFieldsWithNext, LEN(@deviceParameterCodeFieldsWithNext) - 1);

    DECLARE @mainDataQuery NVARCHAR(MAX) =
    'WITH [Archive]
     AS
     (
       SELECT 
  	      [Archive].[Time] [Time]	  
  	     ,[Parameter].[Code] [ParameterCode]        
         ,[dbo].[ConvertMeasurementUnit]
          (
              [Dimension].[Value], 
              [Muc].[DimensionValue2], 
              [Archive].[Value], 
              [Muc].[Expression]
          ) [Value]      
       FROM [Business].[Archive] [Archive] WITH(NOLOCK) 
         
         INNER JOIN [Business].[MeasurementDevice] [Device] WITH(NOLOCK) 
           ON [Device].[Id] = @measurementDeviceId AND [Device].[Id] = [Archive].[MeasurementDeviceId]

         INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
           ON [Channel].[Id] = @channelId AND [Channel].[MeasurementDeviceId] = [Device].[Id]
         
         INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK)
            ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId]

         INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH(NOLOCK)
            ON [DeviceParameter].[Id] = [Archive].[DeviceParameterId]
         
         INNER JOIN [Business].[ParameterMapDeviceParameter] [Map] WITH(NOLOCK)
            ON [Map].[DeviceParameterId] = [DeviceParameter].[Id] 
               AND [Map].[ChannelTemplateId] = [ChannelTemplate].[Id]
               AND [Map].[PeriodTypeId] = @periodTypeId

        INNER JOIN [Dictionaries].[Dimension] [Dimension] WITH(NOLOCK)
            ON [Map].[DimensionId] = [Dimension].[Id]

          INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] WITH(NOLOCK)
            ON [Map].[MeasurementUnitId] = [MeasurementUnit].[Id]

        LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc] 

          /* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
          ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 

         INNER JOIN [Dictionaries].[Parameter] [Parameter] WITH(NOLOCK) 
           ON [Parameter].[Id] = [Map].[ParameterId]

         WHERE          
            [Archive].[Time] = @date AND [Archive].[PeriodTypeId] = @periodTypeId                   
     )
     SELECT * INTO #ResultPivotArchive FROM (
        SELECT [Time], CAST(1 AS BIT) [IsValidRowState], {deviceParameterCodeFieldsWithNext} FROM
          (
            SELECT [Time], {deviceParameterCodeFields}           
            FROM [Archive]
                PIVOT
                (
                  AVG([Value])
                  FOR [ParameterCode] IN ( {deviceParameterCodeFields} )                  
                ) [MainData]
          ) [PrePivotArchive] ORDER BY [PrePivotArchive].[Time] OFFSET 0 ROW
       ) [PivotArchive];

       /* главная часть выборки */
 	    SELECT * FROM #ResultPivotArchive [R] 
	   ';

    SET @mainDataQuery = REPLACE(@mainDataQuery, '{deviceParameterCodeFields}', @deviceParameterCodeFields);
    SET @mainDataQuery = REPLACE(@mainDataQuery, '{deviceParameterCodeFieldsWithNext}', @deviceParameterCodeFieldsWithNext);

    EXEC [sys].[sp_executesql] @mainDataQuery
                              ,N'@measurementDeviceId INT, @channelId INT, @periodTypeId INT, 
          @date DATETIME, @deviceParameterCodePull [Programmability].[CodePullTableType] READONLY'
                              ,@measurementDeviceId = @measurementDeviceId
                              ,@channelId = @channelId
                              ,@periodTypeId = @periodTypeId
                              ,@date = @date
                              ,@deviceParameterCodePull = @deviceParameterCodePull

    COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH

    /* транзакция имеет активную внутреннюю ошибку и дожна быть откатится */
    IF (XACT_STATE()) = -1
    BEGIN
      ROLLBACK TRANSACTION;
    END;

    -- !IMPORTANT
    /* транзакция валидна, но подтверждение  не наступило, 
       например в силу генерации пользовательской ошибки */
    IF (XACT_STATE()) = 1
    BEGIN
      COMMIT TRANSACTION;
    END;

    THROW;
  END CATCH

END;
GO