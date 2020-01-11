CREATE PROCEDURE [Programmability].[GetPivotDiagrammByDevice]
  @userName NVARCHAR(32),
  @districtId INT  
AS
BEGIN      
    SET NOCOUNT ON;

    SET @districtId = IIF(@districtId = 0, NULL, @districtId);

    DECLARE @userId INT;
    DECLARE @roleCode NVARCHAR(64);

    EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

    /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName VALUES        
        (1, 'MainData')        
    SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName];
                     
    /* 2. Основной наборн данных */
    SELECT  
      [Device].[Code] [Arg], 
      [MeasurementDeviceGroupByDevice].[Value] [Value],
      [MeasurementDeviceGroupByDevice].[Percentage] [Percentage]       
      FROM
      (        
        SELECT           
          [Md].[DeviceId], 
          COUNT(*) [Value],
          ROUND(COUNT(*) * 100.0 / CAST(SUM(COUNT(*))  OVER() AS DECIMAL(8, 1)), 2) [Percentage]
          FROM
          (
           SELECT [Md].[DeviceId] FROM
           (
              SELECT ROW_NUMBER() OVER(PARTITION BY [Md].[Id] ORDER BY [Md].[Id]) [Num], [Md].[DeviceId]
          
              FROM [Business].[MeasurementDevice] [Md] WITH(NOLOCK)
        
              LEFT OUTER JOIN [Business].[AccessPoint]  WITH(NOLOCK)
                ON [AccessPoint].[Id] = [Md].[AccessPointId]
        
              LEFT OUTER JOIN [Business].[AccessPointLinkBuilding] [LinkBuilding] WITH(NOLOCK)
                ON [AccessPoint].[Id] = [LinkBuilding].[AccessPointId]
        
              LEFT OUTER JOIN [Business].[Building] [Building] WITH(NOLOCK)
                ON [Building].[Id] = [LinkBuilding].[BuildingId] 
                    
              INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                ON [Channel].[MeasurementDeviceId] = [Md].[Id]

              INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
                ON [UserLink].[ChannelId] = [Channel].[Id] AND ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))	


              WHERE ([Building].[DistrictId] = @districtId OR @districtId IS NULL) 
              ) [Md]
            WHERE [Md].[Num] = 1
          ) [Md]
        
        GROUP BY [Md].[DeviceId]

      ) [MeasurementDeviceGroupByDevice]
  
      INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)  
        ON [MeasurementDeviceGroupByDevice].[DeviceId] = [Device].[Id] 

      ORDER BY [Device].[Code]
END;
GO
