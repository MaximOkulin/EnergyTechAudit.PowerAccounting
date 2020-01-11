-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2014-10-24
-- Description: Возвращает список связанных диспетчеризируемых устройств оператором в роли OPERADMIN
-- ОТЧЕТ: "Список диспетчеризируемых приборов"
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[MeasurementDeviceListForOperAdmin]
	@userName NVARCHAR(32) = NULL
AS
BEGIN
  SET DATEFORMAT dmy;
  SET LANGUAGE N'русский';
  SET NOCOUNT ON;

  DECLARE @empty NCHAR(1) = '';
  
  DECLARE @userId  INT;    
   DECLARE @roleCode NVARCHAR(64);

   EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;   

  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

  INSERT INTO @resultSetName VALUES
	 (1, 'ReportParameter')		-- стандартное имя набора для отображения в решетке
   ,(2, 'MainData')
	 ,(3, 'ColumnCaption');	  -- набор с необязательной расшифровкой расшифровка имен столбцов наборов

  SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName]
  /**/

  /* 2. Дополнительные параметры для отчета */
  
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
    ) [C];
   
   /**/
    
   /* 2. Основная выборка */
  
  SELECT 
    [MeasurementDeviceDeviceId],
    [MeasurementDeviceDescription],
    [BuildingDescription],
    [DistrictId],
    [DistrictDescription],
    [CityDescription],
    [AccessPointDescription]
  FROM
  (
     SELECT 
          ROW_NUMBER() OVER(PARTITION BY [Md].[Id] ORDER BY [Md].[Id]) [Num],
			   [Md].[Id] [MeasurementDeviceDeviceId]
			  ,[Md].[Description] [MeasurementDeviceDescription]
			  ,[Building].[Description] [BuildingDescription]
        ,[District].[Id] [DistrictId]
        ,[City].[Description] [CityDescription]
        ,[District].[Description] [DistrictDescription]
        ,[AccessPoint].[Description] [AccessPointDescription]
	   FROM [Business].[MeasurementDevice] [Md] WITH (NOLOCK)

		  INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
            ON [Channel].[MeasurementDeviceId] = [Md].[Id]

      INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
            ON [UserLink].[ChannelId] = [Channel].[Id] AND 
            ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))	

      INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH (NOLOCK)
        ON [AccessPoint].[Id] = [Md].[AccessPointId]
   
      INNER JOIN [Business].[AccessPointLinkBuilding] [AccessPointLink]  WITH (NOLOCK)
        ON [AccessPointLink].[AccessPointId] = [AccessPoint].[Id]
       
      INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
        ON [Building].[Id] = [AccessPointLink].[BuildingId]
    
      INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
        ON [Placement].[BuildingId] = [Building].[Id]
   
      INNER JOIN [Dictionaries].[District] [District] WITH (NOLOCK)
        ON [District].[Id] = [Building].[DistrictId]

      INNER JOIN [Dictionaries].[City] [City] WITH (NOLOCK)
        ON [City].[Id] = [District].[CityId]

   ) [Md]
   
   WHERE [Md].[Num] = 1

   ORDER BY [Md].[DistrictDescription] ASC

   /**/

   /* 3. Вспомогательная таблица с расшифровками столбцов */
   DECLARE @columnCaption [Programmability].[ColumnCaptionTableType] ;

   INSERT INTO @columnCaption 
   OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
   VALUES
      ('MainData', 'CityDescription', 'Город', 0, 1)
      ,('MainData', 'DistrictDescription', 'Район', 1, 1)
	   ,('MainData', 'MeasurementDeviceDeviceId', 'Ид', 1, 2)
	   ,('MainData',  'MeasurementDeviceDescription', 'Прибор', 1, 3)
	   ,('MainData',  'AccessPointDescription', 'Точка доступа', 1, 4)
	   ,('MainData', 'BuildingDescription', 'Объект учета', 1, 5) ;

   SELECT [ColumnCaption].[Name], [ColumnCaption].[Caption]  FROM @columnCaption [ColumnCaption];

END;