-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2014-10-24
-- Description: Возвращает список связанных диспетчеризируемых устройств оператором в роли OPERADMIN
-- Запрос: "Список диспетчеризируемых приборов"
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[MeasurementDeviceCustomInfoListForOperAdmin]
	@userName NVARCHAR(32) = NULL
AS
BEGIN
  SET DATEFORMAT dmy;
  SET LANGUAGE N'русский';
  SET NOCOUNT ON;
  
  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

  INSERT INTO @resultSetName VALUES
	(1, 'MainData'),		-- стандартное имя набора для отображения в решетке
	(2, 'ColumnCaption');	-- набор с необязательной расшифровкой расшифровка имен столбцов наборов

  SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName]
  /**/
  
  /* 2. Формирование основной выборки*/
 
    
  DECLARE @userId  INT;    
  DECLARE @roleCode NVARCHAR(64);

  EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;
    
  SELECT 
     [MeasurementDeviceList].[Id]
    ,[MeasurementDeviceList].[MeasurementDeviceDescription]
    ,[MeasurementDeviceList].[StatusBar]    
    ,[MeasurementDeviceList].[SuccessConnectionPercent]
    ,[MeasurementDeviceList].[AccessPointDescription]
    ,[MeasurementDeviceList].[DistrictDescription]
    ,[MeasurementDeviceList].[BuildingDescription]
    ,[MeasurementDeviceList].[ResourceSystemTypeDescription]    
    ,[MeasurementDeviceList].[ChannelId]  -- first ChannelId  

  FROM
  (
	SELECT 			
      ROW_NUMBER() OVER(PARTITION BY [Device].[Id] ORDER BY [Device].[Id]) [Num],
      [Device].[Id] [Id],                     
      ISNULL([SCLog].[HtmlTable], '<p style=''color: gray''>Нет данных для отображения</p>') [StatusBar],
      [Device].[SuccessConnectionPercent] [SuccessConnectionPercent],
		  [District].[Description] [DistrictDescription],
      [Build].[Description] [BuildingDescription],
      [Rst].[Description] [ResourceSystemTypeDescription],
      [AccessPoint].[Description] [AccessPointDescription],
		  [Device].[Description] [MeasurementDeviceDescription],
      [Channel].[Id] [ChannelId]

	FROM [Business].[MeasurementDevice] [Device] WITH (NOLOCK)
		
    INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK) 
         ON [Channel].[MeasurementDeviceId] = [Device].[Id]

    INNER JOIN [Business].[UserLinkChannel] [Link]  WITH (NOLOCK)
         ON [Link].[UserId] = @userId AND [Link].[ChannelId] = [Channel].[Id]
    
    INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH (NOLOCK)
         ON [AccessPoint].[Id] = [Device].[AccessPointId]
        
    INNER JOIN [Dictionaries].[ResourceSystemType] [Rst] WITH (NOLOCK) 
         ON [Channel].[ResourceSystemTypeId] = [Rst].[Id]
		
    INNER JOIN [Business].[Placement] [Place]  WITH (NOLOCK)
         ON [Place].[Id] = [Channel].[PlacementId]
		
    INNER JOIN [Business].[Building] [Build] WITH (NOLOCK)
         ON [Build].[Id] = [Place].[BuildingId]

	 INNER JOIN [Dictionaries].[District] [District]  WITH (NOLOCK) 
         ON [District].[Id] = [Build].[DistrictId]

    LEFT OUTER JOIN [dbo].GetHtmlStatusConnectionBar(NULL, 'MeasurementDevice') [SCLog]
      ON [SCLog].[EntityId] = [Device].[Id]
      
	) [MeasurementDeviceList] WHERE [MeasurementDeviceList].[Num] = 1;

   
	/* 3. Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

	INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES
		  ('MainData', 'Id', 'Ид', 1, 1)
      ,('MainData', 'MeasurementDeviceDescription', 'Прибор', 1, 2)
      ,('MainData', 'StatusBar', 'Статус', 1, 3)
      ,('MainData', 'SuccessConnectionPercent', 'Процент успешных соединений', 1, 4)
      ,('MainData', 'AccessPointDescription', 'Точка доступа', 1, 5)
		  ,('MainData', 'DistrictDescription', 'Район', 1, 6)
		  ,('MainData', 'BuildingDescription', 'Строение', 1, 7)
      ,('MainData', 'ResourceSystemTypeDescription', 'Тип ресурса', 1, 8)
      ,('MainData', 'ChannelId', 'Ид. канала', 0, 9); -- первого канала
			
	/**/
END;
GO