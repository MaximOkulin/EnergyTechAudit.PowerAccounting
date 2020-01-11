-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2014-10-08
-- Update date: 2018-09-18
-- Description: Возвращает архивные по группе устройств связанных 
-- с квартирами в строении (разность между показаниями за период)
-- ===================================================================================================

CREATE   PROCEDURE Programmability.GetIndividualAccountingFinalInstantByPeriodArchives @buildingId INT,
@periodBegin DATETIME,
@periodEnd DATETIME
AS
BEGIN

  SET NOCOUNT ON;

  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
  INSERT INTO @resultSetName
    VALUES (1, 'MainData')
    , (2, 'ColumnCaption');

  SELECT
    [ResultSetName].[Order]
   ,[ResultSetName].[Name]
  FROM @resultSetName [ResultSetName];

  SET @periodBegin = CAST(CAST(@periodBegin AS DATE) AS DATETIME);
  SET @periodEnd = CAST(CAST(@periodEnd AS DATE) AS DATETIME);

  DECLARE @periodEndWithInclude DATETIME = DATEADD(DAY, 1, @periodEnd);

  DECLARE @now DATETIME = CAST(CAST(GETDATE() AS DATE) AS DATETIME);

  WITH [Archive]
  AS
  (SELECT
      [Archive].[Id]
     ,[Archive].[Time]
     ,[Archive].[Value]
     ,[Archive].[MeasurementDeviceId]
     ,[Archive].[DeviceParameterId]
     ,[Archive].[TimeSignatureId]
    FROM [Business].[Archive] [Archive] WITH (NOLOCK)
    WHERE [Archive].[PeriodTypeId] = 5 /* FinalInstant */ AND [Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEndWithInclude
    )

  SELECT

    ROW_NUMBER() OVER (ORDER BY [A].[PlacementId], [A].[ChannelId], [A].[ParameterMapDeviceParameterId]) [Id]
   ,[A].[PlacementId]
   ,[A].[ChannelId]
   ,[A].[ParameterMapDeviceParameterId]
   ,[A].[FirstValue]
   ,[A].[LastValue]
   ,[A].[Value]
   ,[A].[Start]
   ,[A].[End]
   ,[A].[PlacementNumber]
   ,[A].[PlacementPurposeDescription]
   ,[A].[PlacementHolderDescription]
   ,[A].[MeasurementDeviceFactoryNumber]
   ,[A].[ChannelDescription]
   ,[A].[ParameterDescription]
   ,[A].[ResourceSystemTypeDescription]
   ,[A].[DimensionDescription]
   ,[A].[MeasurementUnitDescription]
   ,[A].PhysicalParameterCode
  FROM (SELECT

      ROW_NUMBER() OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] DESC) [Num]
     ,[Channel].[Id] [ChannelId]
     ,[Channel].[Description] [ChannelDescription]
     ,[Channel].[MeasurementDeviceId] [MeasurementDeviceId]
     ,[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId]

     ,[Placement].[Id] [PlacementId]
     ,[Placement].[Number] [PlacementNumber]
     ,[ParameterMapDeviceParameter].[Id] [ParameterMapDeviceParameterId]

     ,FIRST_VALUE([Archive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) [FirstValue]
     ,LAST_VALUE([Archive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) [LastValue]

     ,LAST_VALUE([Archive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) - FIRST_VALUE([Archive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) [Value]

     ,FIRST_VALUE([Archive].[Time]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) [Start]
     ,LAST_VALUE([Archive].[Time]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [Archive].[Time] ASC) [End]

     ,[PlacementPurpose].[Description] [PlacementPurposeDescription]

     ,COALESCE([Organization].[Description], [UserAdditionalInfo].[Description]) [PlacementHolderDescription]
     
     ,[MeasurementDevice].[FactoryNumber] [MeasurementDeviceFactoryNumber]

     ,[Parameter].[Description] [ParameterDescription]
     ,[ResourceSystemType].[ShortName] [ResourceSystemTypeDescription]
     ,[Dimension].[Prefix] [DimensionDescription]
     ,[MeasurementUnit].[Description] [MeasurementUnitDescription]
     ,[PhysicalParameter].Code [PhysicalParameterCode]

    FROM [Business].[Channel] [Channel] WITH (NOLOCK)

    INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
      ON [Placement].[BuildingId] = @buildingId
      AND [Placement].[HasIndividualAccounting] = 1
      AND [Placement].[Id] = [Channel].[PlacementId]

    INNER JOIN [Dictionaries].[PlacementPurpose] [PlacementPurpose]
      ON [PlacementPurpose].[Id] = [Placement].[PlacementPurposeId]

    INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
      ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

    INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
      ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [Channel].[ChannelTemplateId]
      AND [ParameterMapDeviceParameter].[PeriodTypeId] = 5

    INNER JOIN [Dictionaries].[Parameter] [Parameter] WITH (NOLOCK)
      ON [ParameterMapDeviceParameter].[ParameterId] = [Parameter].[Id]

    INNER JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter] WITH (NOLOCK)
      ON [PhysicalParameter].[Id] = [Parameter].[PhysicalParameterId]

    INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK)
      ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]

    INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH (NOLOCK)
      ON [ResourceSystemType].[Id] = [Channel].[ResourceSystemTypeId]

    INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] WITH (NOLOCK)
      ON [MeasurementUnit].[Id] = [ParameterMapDeviceParameter].[MeasurementUnitId]

    INNER JOIN [Dictionaries].[Dimension] [Dimension] WITH (NOLOCK)
      ON [Dimension].[Id] = [ParameterMapDeviceParameter].[DimensionId]

   
    LEFT JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] WITH (NOLOCK)
      ON [UserAdditionalInfo].[Id] = [Placement].[UserAdditionalInfoId]

    LEFT JOIN [Business].[Organization] [Organization] WITH (NOLOCK)
      ON [Organization].[Id] = [Placement].[OrganizationId]

    LEFT JOIN [Archive] WITH (NOLOCK)
      ON [Archive].[MeasurementDeviceId] = [Channel].[MeasurementDeviceId]
      AND [Archive].[DeviceParameterId] = [DeviceParameter].[Id]       
      
    ) [A]

  WHERE [A].[Num] = 1
  ORDER BY [A].[PlacementId], [A].[ResourceSystemTypeId], [A].[ParameterMapDeviceParameterId];


  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

  INSERT INTO @columnCaption
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
    VALUES ('MainData', 'Id', 'Ид', 0, 1)
    , ('MainData', 'PlacementNumber', 'Помещение', 1, 2)
    , ('MainData', 'PlacementPurposeDescription', 'Назначение помещения', 0, 3)
    , ('MainData', 'PlacementHolderDescription', 'Владелец', 1, 4)
    , ('MainData', 'ChannelDescription', 'Канал', 1, 5)
    , ('MainData', 'MeasurementDeviceFactoryNumber', 'Завод. номер', 1, 6)
    , ('MainData', 'ParameterDescription', 'Параметр', 1, 7)
    , ('MainData', 'ResourceSystemTypeDescription', 'Ресурс', 1, 8)
    , ('MainData', 'Value', 'Значение', 1, 9)
    , ('MainData', 'FirstValue', 'На начало', 1, 10)
    , ('MainData', 'LastValue', 'На конец', 1, 11)
    , ('MainData', 'Start', 'Начало периода', 1, 12)
    , ('MainData', 'End', 'Конец периода', 1, 13);

  RETURN 0;
END;
GO