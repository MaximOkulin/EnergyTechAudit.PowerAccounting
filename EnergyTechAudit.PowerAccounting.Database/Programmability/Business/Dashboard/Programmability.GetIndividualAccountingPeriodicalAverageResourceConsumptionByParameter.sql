
CREATE PROCEDURE Programmability.GetIndividualAccountingPeriodicalAverageResourceConsumptionByParameter 
  @buildingId INT,
  @parameterId INT,
  @periodBegin DATETIME,
  @periodEnd DATETIME

AS
BEGIN

  SET NOCOUNT ON;

  SET @periodBegin = CAST(CAST(@periodBegin AS DATE) AS DATETIME);
  SET @periodEnd = CAST(CAST(@periodEnd AS DATE) AS DATETIME);

  DECLARE @periodEndWithInclude DATETIME = DATEADD(DAY, 1, @periodEnd);

  WITH [Archive]
  AS
  (SELECT
      [Archive].[Id]
     ,[Archive].[Time]
     ,[Archive].[Value]
     ,[Archive].[MeasurementDeviceId]
     ,[Archive].[DeviceParameterId]
    
    FROM [Business].[Archive] [Archive] WITH (NOLOCK)
    WHERE [Archive].[PeriodTypeId] = 5 /* FinalInstant */ 
    AND [Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEndWithInclude
  )

  SELECT TOP(1) AVG([A].[Value]) OVER (PARTITION BY  [A].[ParameterId])
   
  FROM 
   (
    SELECT
      ROW_NUMBER() OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] DESC) [Num]     
    ,[ParameterMapDeviceParameter].[ParameterId] [ParameterId]
     
     ,LAST_VALUE([Archive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) 
      - FIRST_VALUE([Archive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) [Value]

    FROM [Business].[Channel] [Channel] WITH (NOLOCK)

    INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
      ON [Placement].[BuildingId] = @buildingId
      AND [Placement].[HasIndividualAccounting] = 1
      AND [Placement].[Id] = [Channel].[PlacementId]

    INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
      ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [Channel].[ChannelTemplateId]
      AND [ParameterMapDeviceParameter].[PeriodTypeId] = 5 AND [ParameterMapDeviceParameter].ParameterId = @parameterId

    INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK)
      ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]

    LEFT JOIN [Archive] WITH (NOLOCK)
      ON [Archive].[MeasurementDeviceId] = [Channel].[MeasurementDeviceId]
      AND [Archive].[DeviceParameterId] = [DeviceParameter].[Id]     
   ) [A]
      
  WHERE [A].[Num] = 1

  RETURN 0;
END;
GO