-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2015-11-05
-- Description: This stored procedure returns last measurements by the channel identifier of individual accounting
-- ===================================================================================================

CREATE PROCEDURE Programmability.GetIndividualAccountingFinalInstantByChannel 
@channelId INT,
@periodBegin DATETIME,
@periodEnd DATETIME
AS
BEGIN

  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  DECLARE @buildingId INT = (SELECT
      [Placement].[BuildingId]
    FROM [Business].[Channel] [Channel] WITH (NOLOCK)
    INNER JOIN [Business].[Placement] [Placement]
      ON [Channel].[PlacementId] = [Placement].[Id]
    WHERE @channelId = [Channel].[Id]);

  SET @periodBegin = CAST(CAST(@periodBegin AS DATE) AS DATETIME);
  SET @periodEnd = CAST(CAST(@periodEnd AS DATE) AS DATETIME);

  DECLARE @periodEndWithInclude DATETIME = DATEADD(DAY, 1, @periodEnd);

  /* Perform checking the channel on individual accounting */
  IF NOT EXISTS (SELECT
        1
      FROM [Business].[Channel] [Channel]
      WHERE [Channel].[Id] = @channelId
      AND EXISTS (SELECT
          1
        FROM [Business].[Placement] [Placement]
        WHERE [Placement].[Id] = [Channel].[PlacementId]
        AND [Placement].[HasIndividualAccounting] = 1))
  BEGIN
    DECLARE @errorPermissionMsg NVARCHAR(2048) = [Programmability].[GetSysMessage](297, 1033);
    THROW 500001, @errorPermissionMsg, 1;
  END

  /* Make table with resultset names */

  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
  INSERT INTO @resultSetName
  OUTPUT inserted.[Order], inserted.[Name]
    VALUES (1, 'MainData'),
    (2, 'ColumnCaption');

  /* Extract last TimeSignature Id */

  DECLARE @lastTimeSignatureId INT = (SELECT
      [MeasurementDevice].[LastTimeSignatureId]
    FROM [Business].[MeasurementDevice] [MeasurementDevice]
    INNER JOIN [Business].[Channel] WITH (NOLOCK)
      ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]
    WHERE [Channel].[Id] = @channelId);

  IF @lastTimeSignatureId IS NULL
  BEGIN
    SET @lastTimeSignatureId = (SELECT
        [TimeSignature].[Id]
      FROM (SELECT
          ROW_NUMBER() OVER (ORDER BY [TimeSignature].[Time] DESC) [Num]
         ,[TimeSignature].[Id]
        FROM [Business].[TimeSignature] [TimeSignature] WITH (NOLOCK)
        WHERE [TimeSignature].[MeasurementDeviceId] IN (SELECT
            [Channel].[MeasurementDeviceId]
          FROM [Business].[Channel] [Channel] WITH (NOLOCK)
          WHERE [Channel].[Id] = @channelId)) [TimeSignature]
      WHERE [Num] = 1);
  END;

  BEGIN TRY
    /* Will read dirty */
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN TRANSACTION;
    /* Extract main data */
    WITH [Archive]
    AS
    (SELECT
        [Archive].[Time]
       ,[Archive].[Value]
       ,[Archive].[DeviceParameterId]
       ,[Archive].[MeasurementDeviceId]

      FROM [Business].[Archive] [Archive]
      WHERE [Archive].[PeriodTypeId] = 5
      AND [Archive].[TimeSignatureId] = @lastTimeSignatureId),

    [ParameterMapDeviceParameter]
    AS
    (SELECT
        [ParameterMapDeviceParameter].[Id]
       ,[ParameterMapDeviceParameter].[ParameterId]
       ,[ParameterMapDeviceParameter].[MeasurementUnitId]
       ,[ParameterMapDeviceParameter].[DimensionId]
       ,[ParameterMapDeviceParameter].[DeviceParameterId]

      FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]

      WHERE [ParameterMapDeviceParameter].[PeriodTypeId] = 5
      AND [ParameterMapDeviceParameter].[ChannelTemplateId] IN (SELECT
          [Channel].[ChannelTemplateId]
        FROM [Business].[Channel] [Channel]
        WHERE [Channel].[Id] = @channelId)),

    [Archive1]
    AS
    (SELECT
        [Archive].[Id]
       ,[Archive].[Time]
       ,[Archive].[Value]
       ,[Archive].[MeasurementDeviceId]
       ,[Archive].[DeviceParameterId]

      FROM [Business].[Archive] [Archive] WITH (NOLOCK)
      WHERE [Archive].[PeriodTypeId] = 5 /* FinalInstant */
      AND [Archive].[Time] >= @periodBegin
      AND [Archive].[Time] <= @periodEndWithInclude)

    /* Final selection from CTEs */

    SELECT
      [Parameter].[Id] [ParameterId1]
     ,[Parameter].[Description] [ParameterDescription]
     ,[Archive].[Time]
     ,[Archive].[Value]
     ,[Archive].[MeasurementDeviceId]
     ,[Dimension].[Prefix] [DimensionPrefix]
     ,[MeasurementUnit].[Description] [MeasurementUnitDescription]
     ,[PhysicalParameter].[Code] [PhysicalParameterCode]
     ,[ParameterMapDeviceParameter].[Id] [ParameterMapDeviceParameterId]
     
     ,[C].[AverageResourceConsumption]

     ,[E].[DiffValue]
     ,[E].[DiffPeriodBegin] 
     ,[E].[DiffPeriodEnd] 

     ,@channelId [ChannelId]
     ,@periodBegin [PeriodBegin]
     ,@periodEnd [PeriodEnd]

    FROM [Archive]

    INNER JOIN [ParameterMapDeviceParameter]
      ON [ParameterMapDeviceParameter].[DeviceParameterId] = [Archive].[DeviceParameterId]

    INNER JOIN [Dictionaries].[Parameter] [Parameter]
      ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId]

    INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit]
      ON [MeasurementUnit].[Id] = [ParameterMapDeviceParameter].[MeasurementUnitId]

    INNER JOIN [Dictionaries].[Dimension] [Dimension]
      ON [Dimension].[Id] = [ParameterMapDeviceParameter].[DimensionId]

    INNER JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter]
      ON [PhysicalParameter].[Id] = [Parameter].PhysicalParameterId

    LEFT JOIN (SELECT
        [D].[Num]
       ,[D].[ParameterId]
       ,[D].[DiffValue]
       ,[D].[DiffPeriodBegin]
       ,[D].[DiffPeriodEnd]
      FROM (SELECT
          ROW_NUMBER() OVER (PARTITION BY [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] DESC) [Num]
         ,[ParameterMapDeviceParameter].[ParameterId] [ParameterId]

         ,LAST_VALUE([Archive1].[Value]) OVER (PARTITION BY [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] ASC)
          - FIRST_VALUE([Archive1].[Value]) OVER (PARTITION BY [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] ASC) [DiffValue]

         ,LAST_VALUE([Archive1].[Time]) OVER (PARTITION BY [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] ASC) [DiffPeriodEnd]
         ,FIRST_VALUE([Archive1].[Time]) OVER (PARTITION BY [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] ASC) [DiffPeriodBegin]

        FROM [Business].[Channel] [Channel] WITH (NOLOCK)

        INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
          ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [Channel].[ChannelTemplateId]
          AND [ParameterMapDeviceParameter].[PeriodTypeId] = 5

        INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK)
          ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]

        LEFT JOIN [Archive1] WITH (NOLOCK)
          ON [Archive1].[MeasurementDeviceId] = [Channel].[MeasurementDeviceId]
          AND [Archive1].[DeviceParameterId] = [DeviceParameter].[Id]

        WHERE @channelId = [Channel].[Id]) [D]
      WHERE [Num] = 1) [E]
      ON [E].[ParameterId] = [ParameterMapDeviceParameter].[ParameterId]

    LEFT JOIN (SELECT
        [B].[ParameterId]
       ,[B].[AverageResourceConsumption]
      FROM (SELECT
          [A].[ParameterId]
         ,AVG([A].[Value]) OVER (PARTITION BY [A].[ParameterId]) [AverageResourceConsumption]
         ,ROW_NUMBER() OVER (PARTITION BY [A].[ParameterId] ORDER BY [A].[ParameterId]) [Num]

        FROM (SELECT
            ROW_NUMBER() OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] DESC) [Num]
           ,[ParameterMapDeviceParameter].[ParameterId] [ParameterId]

           ,LAST_VALUE([Archive1].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] ASC)
            - FIRST_VALUE([Archive1].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive1].[Time] ASC) [Value]

          FROM [Business].[Channel] [Channel] WITH (NOLOCK)

          INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
            ON [Placement].[BuildingId] = @buildingId
            AND [Placement].[HasIndividualAccounting] = 1
            AND [Placement].[Id] = [Channel].[PlacementId]

          INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
            ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [Channel].[ChannelTemplateId]
            AND [ParameterMapDeviceParameter].[PeriodTypeId] = 5

          INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK)
            ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]

          LEFT JOIN [Archive1] WITH (NOLOCK)
            ON [Archive1].[MeasurementDeviceId] = [Channel].[MeasurementDeviceId]
            AND [Archive1].[DeviceParameterId] = [DeviceParameter].[Id]) [A]

        WHERE [A].[Num] = 1) [B]
      WHERE [B].[Num] = 1) [C]
      ON [C].[ParameterId] = [ParameterMapDeviceParameter].[ParameterId] ;

    COMMIT TRANSACTION;

    DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

    INSERT INTO @columnCaption
    OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES ('MainData', 'ParameterDescription', 'Параметр', 1, 1)
      , ('MainData', 'Time', 'Время', 0, 2)
      , ('MainData', 'Value', 'Значение', 1, 3)      
      , ('MainData', 'DiffValue', 'Разница за период', 1, 4)
      , ('MainData', 'AverageResourceConsumption', 'Среднее потребление по дому за период', 1, 5)
      , ('MainData', 'DimensionPrefix', 'Размерность', 0, 6)
      , ('MainData', 'MeasurementUnitDescription', 'Единица измерения', 0, 7)

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

  RETURN (0);

END;

GO