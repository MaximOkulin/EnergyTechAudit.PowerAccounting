CREATE PROCEDURE [Programmability].[GetPivotDiagrammByDistrict]
  @userName NVARCHAR(32),  
  @deviceId  INT
AS
BEGIN  
    SET NOCOUNT ON;

    DECLARE @userId INT;
    DECLARE @roleCode NVARCHAR(64);
        
    SET @deviceId = IIF(@deviceId = 0, NULL, @deviceId);

    EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

    /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName VALUES        
        (1, 'MainData')        
    SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName];
    
    /* 2. Основной набор данных */
    SELECT        
      [District].[Description] [Arg], 
      [MeasurementDeviceGroupByDistrict].[Value],
      [MeasurementDeviceGroupByDistrict].[Percentage]      
      FROM
      (
        SELECT 
          [Building].[DistrictId],
          COUNT(*) [Value], 
          ROUND(COUNT(*) * 100.0 / CAST(SUM(COUNT(*)) OVER() AS DECIMAL(8, 1)), 2)  [Percentage]    
          FROM
          (
            SELECT [Building].[Num], [Building].[DistrictId] 
            FROM
            (
              SELECT ROW_NUMBER() OVER(PARTITION BY [Md].[Id] ORDER BY [Md].[Id]) [Num], [Building].[DistrictId]
              
              FROM [Business].[MeasurementDevice] [Md] WITH(NOLOCK)
    
              LEFT OUTER JOIN [Business].[AccessPoint] [Ap] WITH(NOLOCK)
                ON [Md].[AccessPointId] = [Ap].[Id]
  
              LEFT OUTER JOIN [Business].[AccessPointLinkBuilding] [BuildingLink] WITH(NOLOCK)
                ON [Ap].[Id] = [BuildingLink].[AccessPointId] 
  
              LEFT OUTER JOIN [Business].[Building] [Building] WITH(NOLOCK)
                ON [BuildingLink].[BuildingId] = [Building].[Id]
  
              LEFT OUTER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
                ON [Building].[DistrictId] = [District].[Id]
          
              INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                ON [Channel].[MeasurementDeviceId] = [Md].[Id]

              INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
                ON [UserLink].[ChannelId] = [Channel].[Id] AND ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))	

        
              WHERE ([Md].[DeviceId] = @deviceId OR @deviceId IS NULL)  
           ) [Building] WHERE [Building].[Num] = 1
          ) [Building] 
                  
        GROUP BY [Building].[DistrictId]

      ) [MeasurementDeviceGroupByDistrict]
  
    INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
      ON [MeasurementDeviceGroupByDistrict].[DistrictId] = [District].[Id] 

    ORDER BY [District].[Description]

END;
GO
