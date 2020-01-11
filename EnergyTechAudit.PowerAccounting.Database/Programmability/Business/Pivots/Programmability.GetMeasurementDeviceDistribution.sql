-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-23
-- Edit date: 2015-10-28
-- Description: Источник для построения сводной таблицы распределения каналов приборов
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetMeasurementDeviceDistribution]
	@cityId INT,
  @userName NVARCHAR(64)   
AS
BEGIN
   SET NOCOUNT ON;

   SET @cityId = IIF(@cityId = 0, NULL, @cityId);
   
   DECLARE @userId  INT;    
   DECLARE @roleCode NVARCHAR(64);

   EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

  WITH [MeasurementDeviceWithChannelLink]
  AS
  (
    SELECT [MeasurementDevice].[Id] 
    FROM [Business].[MeasurementDevice] [MeasurementDevice]
    
    INNER JOIN [Business].[Channel] [Channel]
      ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

    INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
          ON [UserLink].[ChannelId] = [Channel].[Id] AND 
          ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))		
  )

	SELECT 
     1 [Count]
     ,[MeasurementDevice].[Id] [Id]
     ,[City].[Description] [City]
     ,[District].[Description] [District]
     ,[Building].[Description] [Building]
     ,[AccessPoint].[Description] [AccessPoint]
     ,[Device].[Code] [Device]     
     ,[MeasurementDevice].[Description] [MeasurementDevice]
     ,[DeviceReader].[Description] [DeviceReaderDescription]
         
     FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
  
        INNER JOIN [Dictionaries].[Device] [Device]  WITH(NOLOCK)
          ON [MeasurementDevice].[DeviceId] = [Device].[Id] 
                                    
        INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH(NOLOCK)
          ON [AccessPoint].[Id] = [MeasurementDevice].[AccessPointId]

        LEFT OUTER JOIN [Business].[DeviceReader] [DeviceReader] WITH(NOLOCK)
          ON [DeviceReader].[Id] = [AccessPoint].[DeviceReaderId]                

       INNER JOIN [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH(NOLOCK)
          ON [AccessPoint].[Id] =  [AccessPointLinkBuilding].[AccessPointId]

        INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
          ON [Building].[Id] = [AccessPointLinkBuilding].[BuildingId]

        INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
          ON [Building].[DistrictId] = [District].[Id] 
  
        INNER JOIN [Dictionaries].[City] [City] WITH(NOLOCK)
          ON [City].[Id] = [District].[CityId]

      WHERE 
        [MeasurementDevice].[Id] IN (SELECT [Id] FROM [MeasurementDeviceWithChannelLink]) AND 
        ([City].[Id] = @cityId OR @cityId IS NULL);
      
END;		
		
