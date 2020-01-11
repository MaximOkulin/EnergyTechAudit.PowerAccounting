CREATE PROCEDURE Programmability.GetPivotDiagrammDatasource
  @userName NVARCHAR(32),
  @datasourceCode NVARCHAR(32)
AS
BEGIN
  
  SET NOCOUNT ON;

  DECLARE @userId  INT;    
  DECLARE @roleCode NVARCHAR(64);

  EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

  IF(@datasourceCode = 'byConnectionQuality')
  BEGIN
    
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
              
            ) [Md] WHERE [Md].[Num] = 1

		      ) [Md]
		    ) [Range]
		GROUP BY  [Range].[Range]

  END
  
  ELSE  IF(@datasourceCode = 'byDistrict')

  BEGIN
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

           ) [Building] WHERE [Building].[Num] = 1
          ) [Building] 
                  
        GROUP BY [Building].[DistrictId]

      ) [MeasurementDeviceGroupByDistrict]
  
    INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
      ON [MeasurementDeviceGroupByDistrict].[DistrictId] = [District].[Id] 

    ORDER BY [District].[Description]

  END
  
  ELSE  IF(@datasourceCode = 'byDevice')

  BEGIN  
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
                              
              ) [Md]
            WHERE [Md].[Num] = 1
          ) [Md]
        
        GROUP BY [Md].[DeviceId]

      ) [MeasurementDeviceGroupByDevice]
  
      INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)  
        ON [MeasurementDeviceGroupByDevice].[DeviceId] = [Device].[Id] 

      ORDER BY [Device].[Code]

  END;  
END;
GO