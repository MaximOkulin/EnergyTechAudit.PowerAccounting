-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-23
-- Edit date: 2015-10-28
-- Description: Источник для построения сводной таблицы распределения каналов приборов
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetChannelDistribution]
	@cityId INT,
  @userName NVARCHAR(64)   
AS
BEGIN
   SET NOCOUNT ON;

   SET @cityId = IIF(@cityId = 0, NULL, @cityId);
   
   DECLARE @userId  INT;    
   DECLARE @roleCode NVARCHAR(64);
   EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;
     
	SELECT 
     1 [Count]
     ,[Channel].[Id] [Id]
     ,[City].[Description] [City]
     ,[District].[Description] [District]
     ,[Building].[Description] [Building]     
     ,[Device].[Code] [Device]
     ,[ResourceSystemType].[ShortName] [ResourceSystemType]
     ,[Channel].[Description] [Channel]
     ,[Organization].[Description] [Organization]
              
     FROM [Business].[Channel] [Channel] WITH(NOLOCK)
  
        INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice]
          ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

        INNER JOIN [Dictionaries].[Device] [Device]  WITH(NOLOCK)
          ON [MeasurementDevice].[DeviceId] = [Device].[Id] 
                          
        INNER JOIN [Business].[AccessPoint] [AccessPoint] WITH(NOLOCK)
          ON [AccessPoint].[Id] = [MeasurementDevice].[AccessPointId]

        INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
          ON [UserLink].[ChannelId] = [Channel].[Id] AND 
          ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))		

        INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH(NOLOCK)
          ON [Channel].[ResourceSystemTypeId] = [ResourceSystemType].[Id]

        INNER JOIN [Business].[AccessPointLinkBuilding] [AccessPointLinkBuilding] WITH(NOLOCK)
          ON [AccessPoint].[Id] =  [AccessPointLinkBuilding].[AccessPointId]

        INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
          ON [Building].[Id] = [AccessPointLinkBuilding].[BuildingId]

        INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
          ON [Building].[DistrictId] = [District].[Id] 
  
        LEFT JOIN [Business].[Organization]  [Organization] WITH(NOLOCK)
        ON [Organization].[Id] = [Channel].[OrganizationId]

        INNER JOIN [Dictionaries].[City] [City] WITH(NOLOCK)
          ON [City].[Id] = [District].[CityId]
        

      WHERE ([City].[Id] = @cityId OR @cityId IS NULL) 
   
END;		
		
