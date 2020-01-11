
-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-10-23
-- Update date: 2018-09-20
-- Description: Сводная информация  по индивидуальному учету о помещении, владельце, расчетном счете и устройстве  
-- ===================================================================================================

CREATE PROCEDURE Programmability.GetIndividualAccountingPlacementInfo @channelId INT
AS
BEGIN

  /*Список имен выходных резалтсетов*/
  SET NOCOUNT ON;
  SET XACT_ABORT ON;

  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

  INSERT INTO @resultSetName
  OUTPUT inserted.[Order], inserted.[Name]
    VALUES (1, 'MainData'),
    (2, 'ColumnCaption');

  /* Список групп параметров*/
  DECLARE @group TABLE (
    [Id] INT
   ,[Name] NVARCHAR(32)
   ,[IconClass] NVARCHAR(32)
  );

  INSERT INTO @group
    VALUES (1, 'Строение и помещение', 'font-icon-building'),
    (2, 'Владелец и ресурс', 'font-icon-resourcesystemtype'),
    (3, 'Устройство', 'font-icon-measurement-device');

  /* Ссылочная таблица между параметром и группой */
  DECLARE @groupLink TABLE (
    [GroupId] INT
   ,[PlacementInfoId] INT
  );
  DECLARE @measurementDeviceId INT = (SELECT
      [Channel].[MeasurementDeviceId]
    FROM [Business].[Channel] [Channel]
    WHERE [Channel].[Id] = @channelId)

  INSERT INTO @groupLink
    VALUES (1, 1), (1, 2), (1, 3), (2, 4), (2, 5), (3, 6), (3, 7), (3, 8), (3, 9), (3, 10), (3, 11), (3, 12);

  BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    BEGIN TRANSACTION;

    /* Основной список информационных параметров */
    (
    SELECT
      [GroupLink].[GroupId]
     ,[Group].[Name] [Group]
     ,[Group].[IconClass] [IconClass]
     ,[PlacementInfo].[PlacementInfoId]
     ,[PlacementInfo].[Name]
     ,[PlacementInfo].[Value]
    FROM (SELECT
        ROW_NUMBER() OVER (ORDER BY (SELECT
            NULL)
        ) [PlacementInfoId]
       ,[Name]
       ,[Value]
      FROM (SELECT

          CAST([Building].[FullAddress] AS NVARCHAR(MAX)) [Полный адрес]

         ,CAST(ISNULL([ServiceOrganization].[Description], 'Нет данных для отображения') AS NVARCHAR(MAX)) [Эксплуатационная организация]

         ,CAST([Placement].[Description] AS NVARCHAR(MAX)) [Помещение]

         ,CAST(ISNULL(COALESCE([Organization].[Description], [UserAdditionalInfo].[Description]), 'Нет данных для отображения') AS NVARCHAR(MAX)) [Владелец]

         ,CAST([ResourceSystemType].[ShortName] AS NVARCHAR(MAX)) [Ресурс]

         ,CAST([MeasurementDevice].[Description] AS NVARCHAR(MAX)) [Измерительное устройство]

         ,CAST([MeasurementDevice].[FactoryNumber] AS NVARCHAR(MAX)) [Серийный номер]

         ,CAST([StatusConnection].[Description] AS NVARCHAR(MAX)) [Статус последнего подключения]

         ,CAST(ISNULL([StatusConnectionBar].[HtmlTable], 'Нет данных для отображения') AS NVARCHAR(MAX)) [Статусы подключений]

         ,CAST(FORMAT([MeasurementDevice].[LastConnectionTime], 'dd.MM.yyyy HH:mm:ss') AS NVARCHAR(MAX)) [Время последнего опроса]

         ,CAST(FORMAT([MeasurementDevice].[CurrentAccreditationDate], 'dd.MM.yyyy') AS NVARCHAR(MAX)) [Дата поверки]

         ,CAST(FORMAT([MeasurementDevice].[NextAccreditationDate], 'dd.MM.yyyy') AS NVARCHAR(MAX)) [Дата следующей поверки]


        FROM [Business].[Placement] [Placement] WITH (NOLOCK)

        INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
          ON [Placement].[BuildingId] = [Building].[Id]

        LEFT OUTER JOIN [Business].[Organization] [ServiceOrganization] WITH (NOLOCK)
          ON [ServiceOrganization].[Id] = [Building].[OrganizationId]

        INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
          ON [Channel].[PlacementId] = [Placement].[Id]
          /* по выбранному каналу*/
          AND [Channel].[Id] = @channelId

        INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH (NOLOCK)
          ON [ResourceSystemType].[Id] = [Channel].[ResourceSystemTypeId]

        INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
          ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

        INNER JOIN [Dictionaries].[StatusConnection] [StatusConnection] WITH (NOLOCK)
          ON [StatusConnection].[Id] = [MeasurementDevice].[LastStatusConnectionId]

        LEFT OUTER JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] WITH (NOLOCK)
          ON [UserAdditionalInfo].[Id] = [Placement].[UserAdditionalInfoId]

        LEFT OUTER JOIN [Business].[Organization] [Organization] WITH (NOLOCK)
          ON [Organization].[Id] = [Placement].[OrganizationId]

        LEFT OUTER JOIN [dbo].GetHtmlStatusConnectionBar(@measurementDeviceId, 'MeasurementDevice') [StatusConnectionBar]
          ON [StatusConnectionBar].[EntityId] = [MeasurementDevice].[Id]     
      ) [PlacementInfo]

      UNPIVOT
      (
      [Value] FOR [Name] IN
      (
      [Полный адрес],
      [Эксплуатационная организация],
      [Помещение],
      [Владелец],
      [Ресурс],
      [Измерительное устройство],
      [Серийный номер],
      [Статус последнего подключения],
      [Статусы подключений],

      [Время последнего опроса],
      [Дата поверки],
      [Дата следующей поверки]
      )
      ) [PlacementInfo]) [PlacementInfo]

    INNER JOIN @groupLink [GroupLink]
      ON [PlacementInfo].[PlacementInfoId] = [GroupLink].[PlacementInfoId]

    INNER JOIN @group [Group]
      ON [Group].[Id] = [GroupLink].[GroupId]
    )

    UNION ALL

    /* Присоединяем расчетные счета */
    (
    SELECT
      2 [GroupId]
     ,'Расчетные счета' [Group]
     ,''
     ,12
     ,'Cчет' [Name]
     ,[CheckingAccount].[Description] [Value]

    FROM [Business].[CheckingAccount] [CheckingAccount]

    INNER JOIN [Business].[CheckingAccountLinkPlacement] [CheckingAccountLinkPlacement]
      ON [CheckingAccount].[Id] = [CheckingAccountLinkPlacement].[CheckingAccountId]

    INNER JOIN [Business].[Placement] [Placement]
      ON [Placement].[Id] = [CheckingAccountLinkPlacement].[PlacementId]
    INNER JOIN [Business].[Channel] [Channel]
      ON [Placement].[Id] = [Channel].[PlacementId]
    WHERE [Channel].[Id] = @channelId
    );

    COMMIT TRANSACTION;

    DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

    /* Список столбцов для визуальной решетки */
    INSERT INTO @columnCaption

    OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]

      VALUES ('MainData', 'GroupId', 'Ид. группы', 1, 0)
      , ('MainData', 'Group', 'Группа', 1, 1)
      , ('MainData', 'Name', 'Наименование', 1, 2)
      , ('MainData', 'Value', 'Значение', 1, 3);
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