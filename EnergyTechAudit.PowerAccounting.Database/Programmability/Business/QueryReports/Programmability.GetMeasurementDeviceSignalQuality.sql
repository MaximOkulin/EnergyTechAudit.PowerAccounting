CREATE PROCEDURE [Programmability].[GetMeasurementDeviceSignalQuality]
(
   @userName NVARCHAR(64),
   @buildingId INT = NULL,
   @resourceSystemTypeId INT = NULL,
   @districtId INT = NULL,
   @transportServerModelId INT = NULL,
   @deviceId INT = NULL,
   @transportServerModelStatusId INT = NULL,
   @deviceStatusId INT = NULL,
   @isFlatAccounting BIT = 0
)
AS
BEGIN
  SET DATEFORMAT dmy;
  SET LANGUAGE N'русский';
  SET NOCOUNT ON;

   /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

   INSERT INTO @resultSetName VALUES
	   (1, 'MainData'),		    -- стандартное имя набора для отображения в решетке
	   (2, 'ColumnCaption'),	-- набор с необязательной расшифровкой расшифровка имен столбцов наборов
	   (3, 'ReportParameter') -- свободные параметры отчета

   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	   FROM @resultSetName [ResultSetName]
   /**/

   /* 2. Основная выборка */

   DECLARE @userId  INT;    
   DECLARE @roleCode NVARCHAR(64);

   EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

   SET @buildingId = IIF(@buildingId = 0, NULL, @buildingId);
   SET @resourceSystemTypeId = IIF(@resourceSystemTypeId = 0, NULL, @resourceSystemTypeId);
   SET @districtId = IIF(@districtId = 0, NULL, @districtId);
   SET @deviceId = IIF(@deviceId = 0, NULL, @deviceId);
   SET @transportServerModelId = IIF(@transportServerModelId = 0, NULL, @transportServerModelId);
   SET @transportServerModelStatusId = IIF(@transportServerModelStatusId = 0, NULL, @transportServerModelStatusId);
   SET @deviceStatusId = IIF(@deviceStatusId = 0, NULL, @deviceStatusId);
   
   -- дата доступа к прибору по-умолчанию
   DECLARE @defaultStartDateTime DATETIME 
      = CONVERT(DATETIME, '1900-01-01 00:00:00.000');
   
   WITH Result AS
   (
    -- выборка по измерительным приборам 
    SELECT 
	  [PlacementNumber],
	  [EntityId],
      [Address], 
      [DistrictDescription], 
      [IpAddress],
      [MeasurementDeviceId],
      [AccessPointId],
      [LastConnectionTime],
      [DeviceCode],
      [NetworkAddress],
      [StatusConnectionDescription],
      [SuccessConnectionPercent]
    FROM
    (
    SELECT 
	  -- для устранения появления дубликатов, т.к. INNER JOIN пригонит много дубликатов
      ROW_NUMBER() OVER(PARTITION BY [Md].[Id] ORDER BY [Md].[Id]) [MdId],
	  ISNULL(TRY_CAST([Placement].[Number] AS INT), 0) [PlacementNumber],
	  [Md].[Id] [EntityId],
      NULL [Address],
      NULL [DistrictDescription],
      IIF ([Placement].[PlacementPurposeId] = 2, 'Узел учета', 
	       IIF ([Placement].[PlacementPurposeId] = 1, 'Квартира ' + IIF([Placement].[Number] IS NULL, '', [Placement].[Number]), NULL)) [IpAddress],      
      [Md].[Id] [MeasurementDeviceId],
      [AccessPoint].[Id] [AccessPointId],
      IIF([Md].[LastConnectionTime] = @defaultStartDateTime, NULL, [Md].[LastConnectionTime]) 
      [LastConnectionTime],       
      [Device].[Code] + '-' + CAST([Md].[FactoryNumber] AS NVARCHAR) [DeviceCode],
      [Md].[NetworkAddress] [NetworkAddress],
      [StatusConnection].[Description] [StatusConnectionDescription],
      [Md].[SuccessConnectionPercent] [SuccessConnectionPercent],
	  [AccessPoint].[TransportServerModelId] [TransportServerModelId],
	  [Md].[LastStatusConnectionId] [MdLastStatusConnectionId],
	  [AccessPoint].[LastStatusConnectionId] [ApLastStatusConnectionId]
   FROM [Business].[MeasurementDevice] [Md] WITH (NOLOCK)
      
      INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
          ON [Channel].[MeasurementDeviceId] = [Md].[Id]
      
	  INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
	      ON [Channel].[PlacementId] = [Placement].[Id]

      INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
          ON [UserLink].[ChannelId] = [Channel].[Id] AND 
          ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))	
   
      INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH (NOLOCK)
          ON [AccessPoint].[Id] = [Md].[AccessPointId]
   
      INNER JOIN [Dictionaries].[StatusConnection] [StatusConnection] WITH (NOLOCK)
          ON [Md].[LastStatusConnectionId] = [StatusConnection].[Id]

     INNER JOIN [Dictionaries].[Device] [Device] WITH (NOLOCK)
          ON [Md].[DeviceId] = [Device].[Id]
     
    WHERE ([Md].[DeviceId] = @deviceId OR @deviceId IS NULL) 
	       AND ([Channel].[ResourceSystemTypeId] = @resourceSystemTypeId OR @resourceSystemTypeId IS NULL) 
		   
		   AND ((@isFlatAccounting = 0) OR
		        (@isFlatAccounting = 1 AND @buildingId IS NULL AND [Placement].[PlacementPurposeId] = 1)
		        OR (@isFlatAccounting = 1 AND @buildingId IS NOT NULL AND [Placement].[BuildingId] = @buildingId AND [Placement].[PlacementPurposeId] = 1))
    ) [Md] 
    WHERE [Md].[MdId] = 1 AND ([Md].[TransportServerModelId] = @transportServerModelId OR @transportServerModelId IS NULL)
	AND ([Md].[MdLastStatusConnectionId] = @deviceStatusId OR @deviceStatusId IS NULL)
	AND ([Md].[ApLastStatusConnectionId] = @transportServerModelStatusId OR @transportServerModelStatusId IS NULL)

   UNION ALL
   
   -- выборка по точкам доступа
   SELECT 
    [PlacementNumber],
    [EntityId],
    [Address], 
    [DistrictDescription], 
    [IpAddress],
    [MeasurementDeviceId],
    [AccessPointId],
    [LastConnectionTime],
    [DeviceCode],
    [NetworkAddress],
    [StatusConnectionDescription],
    [SuccessConnectionPercent]
    FROM
    (
       SELECT 
          ROW_NUMBER() OVER(PARTITION BY [Ap].[Id] ORDER BY [Ap].[Id]) [ApId],
		  0 [PlacementNumber],
		  [Ap].[Id] [EntityId],
          [Building].[FullAddress] [Address],
          [District].[Description] [DistrictDescription],
          IIF([Ap].[TransportServerModelId] = 6, '', [Ap].[NetAddress]) [IpAddress],
          NULL [MeasurementDeviceId], 
          [Ap].[Id] [AccessPointId],
          IIF([Ap].[LastConnectionTime] = @defaultStartDateTime, NULL, [Ap].[LastConnectionTime]) [LastConnectionTime],
          [Tsm].[Code] [DeviceCode],
          NULL [NetworkAddress],
          [StatusConnection].[Description] [StatusConnectionDescription],
          [Ap].[SuccessConnectionPercent][SuccessConnectionPercent],
          [Ap].[TransportServerModelId] [TransportServerModelId], 
		  [Md].[LastStatusConnectionId] [MdLastStatusConnectionId],
	      [Ap].[LastStatusConnectionId] [ApLastStatusConnectionId]     
          FROM [Business].[AccessPoint] [Ap] WITH (NOLOCK)
          
          INNER JOIN [Business].[MeasurementDevice] [Md] WITH (NOLOCK)
             ON [Ap].[Id] = [Md].[AccessPointId] AND ([Md].[DeviceId] = @deviceId OR @deviceId IS NULL)
			    AND ([Md].[LastStatusConnectionId] = @deviceStatusId OR @deviceStatusId IS NULL) /*!*/
          
          INNER JOIN [Business].[AccessPointLinkBuilding] [BuildingLink] WITH (NOLOCK)
             ON [BuildingLink].[AccessPointId] = [Ap].[Id]
    
          INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
             ON [Building].[Id] = [BuildingLink].[BuildingId]
          
          INNER JOIN [Dictionaries].[District] [District] WITH (NOLOCK)
            ON [Building].[DistrictId] = [District].[Id]
          
          INNER JOIN [Dictionaries].[TransportServerModel] [Tsm] WITH (NOLOCK)
            ON [Ap].[TransportServerModelId] = [Tsm].[Id]
    
          INNER JOIN [Dictionaries].[StatusConnection] [StatusConnection] WITH (NOLOCK)
            ON [Ap].[LastStatusConnectionId] = [StatusConnection].[Id]
    
          INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
            ON [Channel].[MeasurementDeviceId] = [Md].[Id]

		  INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
		    ON [Placement].[Id] = [Channel].[PlacementId]
			    AND ((@isFlatAccounting = 0) OR
		        (@isFlatAccounting = 1 AND @buildingId IS NULL AND [Placement].[PlacementPurposeId] = 1)
		        OR (@isFlatAccounting = 1 AND @buildingId IS NOT NULL AND [Placement].[BuildingId] = @buildingId AND [Placement].[PlacementPurposeId] = 1))

          INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
            ON [UserLink].[ChannelId] = [Channel].[Id] AND 
            ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))	
          
		  WHERE ([Channel].[ResourceSystemTypeId] = @resourceSystemTypeId OR @resourceSystemTypeId IS NULL)		  
          ) [Ap]
    WHERE [Ap].[ApId] = 1 AND ([Ap].[TransportServerModelId] = @transportServerModelId OR @transportServerModelId IS NULL)
	      AND ([Ap].[MdLastStatusConnectionId] = @deviceStatusId OR @deviceStatusId IS NULL)
	      AND ([Ap].[ApLastStatusConnectionId] = @transportServerModelStatusId OR @transportServerModelStatusId IS NULL)
   )
   
   SELECT   
            ROW_NUMBER() OVER (ORDER BY [DistrictId] ASC, [Result].[AccessPointId] ASC, [Result].[MeasurementDeviceId] ASC) [Id],
            [DistrictId],
			[EntityId],
            [Address],
            [BuildingLink].[DistrictDescription],
            [IpAddress],
            [MeasurementDeviceId],
            [Result].[AccessPointId],
            [LastConnectionTime],
            [DeviceCode],
            [NetworkAddress],
            [StatusConnectionDescription],
            [SuccessConnectionPercent],
			[BuildingLink].[BuildingId]
    FROM [Result]
    
    INNER JOIN 
      (
        SELECT [L].[DistrictId], [L].[AccessPointId], [L].[DistrictDescription],
		[L].[BuildingId]  FROM
        (
          SELECT 
            ROW_NUMBER() OVER(PARTITION BY [AccessPointId] ORDER BY [AccessPointId]) [Num],
            [AccessPointId],
            [District].[Id] [DistrictId],
            [District].[Description] [DistrictDescription],
			[Building].[Id] [BuildingId]
          FROM [Business].[AccessPointLinkBuilding] [BuildingLink]  WITH (NOLOCK)

          INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
            ON [Building].[Id] = [BuildingLink].[BuildingId]
    
          INNER JOIN [Dictionaries].[District] [District] WITH (NOLOCK)
            ON [Building].[DistrictId] = [District].[Id]

        ) [L] WHERE [L].[Num] = 1      
      )[BuildingLink]

      ON [BuildingLink].[AccessPointId] = [Result].[AccessPointId]

    WHERE  ([DistrictId] = @districtId OR  @districtId IS NULL)	AND 
	       ([BuildingId] = @buildingId OR @buildingId IS NULL)             

    ORDER BY [DistrictId] ASC, [Result].[AccessPointId] ASC, [Result].[PlacementNumber] ASC, [Result].[MeasurementDeviceId]

  /* 3. Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

	INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES
     ('MainData', 'Id', 'Ид', 1, 1)
	,('MainData', 'EntityId', 'Ид объекта', 1, 2)
    ,('MainData', 'DistrictId', 'Ид района', 1, 3)
    ,('MainData', 'DistrictDescription', 'Район', 1, 4)     
	  ,('MainData', 'Address', 'Адрес', 1, 5)    
    ,('MainData', 'IpAddress', 'IP-адрес', 1, 6)
	  ,('MainData', 'LastConnectionTime', 'Дата', 1, 7)
	  ,('MainData', 'DeviceCode', 'Тип устройства', 1, 8)
    ,('MainData', 'NetworkAddress', 'Сетевой адрес', 1, 9)
    ,('MainData', 'StatusConnectionDescription', 'Статус', 1, 10)
    ,('MainData', 'SuccessConnectionPercent', 'Процент успешных соединений', 1, 11);
		
	/**/

	/* 4. Формирование таблицы параметрии отчета */
  DECLARE @empty NCHAR(1) = '';
	DECLARE @reportParameter [Programmability].[CustomParameterTableType];
	
  INSERT INTO @reportParameter
    OUTPUT inserted.[Name], inserted.[Value]
    SELECT [Name], [Value] FROM 
    (
        SELECT [Name], [Value] 
        FROM (
            SELECT 
              CAST([User].[UserName] AS NVARCHAR(128)) [UserName]
              ,CAST(ISNULL([UserInfo].[FirstName], @empty) AS NVARCHAR(128)) [FirstName]
              ,CAST(ISNULL([UserInfo].[LastName], @empty) AS NVARCHAR(128)) [LastName]
              ,CAST(ISNULL([UserInfo].[Description], @empty) AS NVARCHAR(128)) [UserInfoDescription]

            FROM [Admin].[User] [User] WITH (NOLOCK) 
            LEFT OUTER JOIN [Business].[UserAdditionalInfo] [UserInfo] WITH (NOLOCK) 
              ON [User].[Id] = [UserInfo].[Id]
            WHERE [User].[UserName] = @userName)
          [A]
          UNPIVOT
          (
            [Value] FOR [Name] IN 
            (
              [UserName], 
              [FirstName], 
              [LastName],
              [UserInfoDescription] 
            )
          ) [B]   
    ) [C]

    UNION ALL 

    SELECT 'IsFlatAccounting' [Name], CAST(@isFlatAccounting AS NVARCHAR(128)) [Value]
   
	
END

GO