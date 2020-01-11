
-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2014-10-08
-- Description: Возвращает архивные по группе устройств связанных с квартирами в строении
-- ===================================================================================================

CREATE   PROCEDURE Programmability.GetIndividualAccountingFinalInstantArchives @buildingId INT,
@periodBegin DATETIME = NULL,
@periodEnd DATETIME = NULL
AS
BEGIN

  SET NOCOUNT ON;
  /* 1. Формирование имен резалтсетов для отчета*/

  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
  INSERT INTO @resultSetName
    VALUES (1, 'MainData')
    , (2, 'ColumnCaption');

  SELECT
    [ResultSetName].[Order]
   ,[ResultSetName].[Name]
  FROM @resultSetName [ResultSetName];

  /* 2. Основная выборка */
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
    WHERE [Archive].[PeriodTypeId] = 5 /* FinalInstant */ AND
    [Archive].[TimeSignatureId] IN (SELECT
        [TimeSignatureId]
      FROM (SELECT
          ROW_NUMBER() OVER
          (
          PARTITION BY [TimeSignature].[MeasurementDeviceId]
          ORDER BY [TimeSignature].[Time] DESC
          ) [RowNumber]
         ,[TimeSignature].[Id] [TimeSignatureId]
        FROM [Business].[TimeSignature] [TimeSignature] WITH (NOLOCK)
        WHERE EXISTS (SELECT
            1
          FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
          WHERE [MeasurementDevice].[Id] = [TimeSignature].[MeasurementDeviceId]
          AND EXISTS (SELECT
              1
            FROM [Business].[Channel] [Channel]
            WHERE [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]
            AND EXISTS (SELECT
                1
              FROM [Business].[Placement] [Placement] WITH (NOLOCK)
              WHERE [Placement].[BuildingId] = @buildingId
              AND [Placement].[HasIndividualAccounting] = 1
              AND [Placement].[Id] = [Channel].[PlacementId])))) [TimeSignature]
      WHERE [TimeSignature].[RowNumber] = 1))
  SELECT
    
    ROW_NUMBER() OVER (ORDER BY [Placement].[Id], [Channel].[Id], [ParameterMapDeviceParameter].[Id]) [Id]
   ,[Placement].[Id] [PlacementId]
   ,[Channel].[Id] [ChannelId]
   ,[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId]
   ,[Archive].[TimeSignatureId]
   ,[ParameterMapDeviceParameter].[Id] [ParameterMapDeviceParameterId]
   ,[Archive].[Value]
   ,[Archive].[Time]
   ,[Placement].[Number] [PlacementNumber]

   ,[PlacementPurpose].[Description] [PlacementPurposeDescription]

   ,COALESCE([Organization].[Description], [UserAdditionalInfo].[Description]) [PlacementHolderDescription]
   ,[MeasurementDevice].[FactoryNumber] [MeasurementDeviceFactoryNumber]

   ,[Channel].[Description] [ChannelDescription]
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

  ORDER BY [PlacementId], [ResourceSystemTypeId], [ParameterMapDeviceParameterId];

  /* 3. Вспомогательная таблица с расшифровками столбцов */

  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

  INSERT INTO @columnCaption
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
    VALUES 
    ('MainData', 'Id', 'Ид', 0, 1)
    , ('MainData', 'PlacementNumber', 'Помещение', 1, 0)
    , ('MainData', 'PlacementPurposeDescription', 'Назначение помещения', 0, 1)
    , ('MainData', 'PlacementHolderDescription', 'Владелец', 1, 2)
    , ('MainData', 'ChannelDescription', 'Канал', 1, 3)
    , ('MainData', 'MeasurementDeviceFactoryNumber', 'Завод. номер', 1, 4)
    , ('MainData', 'ParameterDescription', 'Параметр', 1, 5)
    , ('MainData', 'ResourceSystemTypeDescription', 'Ресурс', 1, 6)
    , ('MainData', 'Value', 'Значение', 1, 7)
    , ('MainData', 'Time', 'Время', 1, 8)

  RETURN 0;
END;
GO