CREATE PROCEDURE [Programmability].[GetPivotDiagrammByConnectionQuality]
  @userName NVARCHAR(32),
  @deviceId INT,
  @districtId INT  
AS
BEGIN      
    SET NOCOUNT ON;

    SET @districtId = IIF(@districtId = 0, NULL, @districtId);
    SET @deviceId = IIF(@deviceId = 0, NULL, @deviceId);

    DECLARE @userId INT;
    DECLARE @roleCode NVARCHAR(64);
        
    EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

    /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName VALUES        
        (1, 'MainData')        
    SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName];
                     
    /* 2. Основной набор данных */
    SELECT       
      [Range].[Range] [Arg], 
      COUNT(*) [Value], 
      ROUND(COUNT(*) * 100.0 / CAST(SUM(COUNT(*)) OVER() AS DECIMAL(8, 1)), 2)  [Percentage]
		FROM 
		    (
		    SELECT 
			    CASE      
			      WHEN [SuccessConnectionPercent] BETWEEN 1 AND 10 THEN '1-10%'
			      WHEN [SuccessConnectionPercent] BETWEEN 11 AND 20 THEN '11-20%'
			      WHEN [SuccessConnectionPercent] BETWEEN 21 AND 30 THEN '21-30%'
			      WHEN [SuccessConnectionPercent] BETWEEN 31 AND 40 THEN '31-40%'
			      WHEN [SuccessConnectionPercent] BETWEEN 41 AND 50 THEN '41-50%'
			      WHEN [SuccessConnectionPercent] BETWEEN 51 AND 60 THEN '51-60%'
			      WHEN [SuccessConnectionPercent] BETWEEN 61 AND 70 THEN '61-70%'
			      WHEN [SuccessConnectionPercent] BETWEEN 71 AND 80 THEN '71-80%'
			      WHEN [SuccessConnectionPercent] BETWEEN 81 AND 90 THEN '81-90%'
			      WHEN [SuccessConnectionPercent] BETWEEN 91 AND 100 THEN '91-100%'
			      ELSE ' < 1 %'
			    END AS [Range]
		    FROM 
		      (
            SELECT [Md].[SuccessConnectionPercent]  FROM 
            (
			        SELECT 
                ROW_NUMBER() OVER (PARTITION BY [Md].[Id] ORDER BY [Md].[Id]) [Num], 
                [Md].[SuccessConnectionPercent] 
            
              FROM [Business].[MeasurementDevice] [Md] WITH(NOLOCK)
			        
              INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                ON [Channel].[MeasurementDeviceId] = [Md].[Id]

              INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
                ON [UserLink].[ChannelId] = [Channel].[Id] AND ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))		
            
              LEFT OUTER JOIN [Business].[AccessPoint] [AccessPoint] WITH(NOLOCK)
                ON [AccessPoint].[Id] = [Md].[AccessPointId]

              LEFT OUTER  JOIN [Business].[AccessPointLinkBuilding] [LinkBuilding] WITH(NOLOCK)
                ON [AccessPoint].[Id] = [LinkBuilding].[AccessPointId]

              LEFT OUTER  JOIN [Business].[Building] [Building] WITH(NOLOCK)
                ON [Building].[Id] = [LinkBuilding].[BuildingId]

              WHERE ([Md].[DeviceId] = @deviceId OR @deviceId IS NULL) AND 
                    ([Building].[DistrictId] = @districtId OR @districtId IS NULL)

            ) [Md] WHERE [Md].[Num] = 1

		      ) [Md]
		    ) [Range]
		GROUP BY  [Range].[Range]

END;
GO
