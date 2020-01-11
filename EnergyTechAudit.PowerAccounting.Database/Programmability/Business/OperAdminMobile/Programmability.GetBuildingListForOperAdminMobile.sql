CREATE    PROCEDURE Programmability.GetBuildingListForOperAdminMobile
@userName NVARCHAR(32),
@statusConnectionId INT
AS
BEGIN
    DECLARE @userId INT = 
    (
        SELECT
            [Id]
        FROM [Admin].[User] [User] WITH(NOLOCK)
        WHERE [User].[UserName] = @userName
    );

    SELECT
        [Building].[Id] [BuildingId]
       ,[Building].[Description] [BuildingDescription] 
       
       ,[Channel].[Id] [ChannelId]       
       ,[Channel].[Description] [ChannelDescription]
       ,[Channel].[MeasurementDeviceId] [MeasurementDeviceId]             
       ,[Channel].[ResourceSystemTypeId]

       ,[ChannelTemplate].[Description] [ChannelTemplateDescription]  
       
       ,[MeasurementDevice].[LastStatusConnectionId] [LastStatusConnectionId]       
       ,[MeasurementDevice].[AccessPointId] [AccessPointId]
       ,[MeasurementDevice].[SuccessConnectionPercent] [MeasurementDeviceSuccessConnectionPercent]
       ,IIF
       ( 
            [MeasurementDevice].[LastSuccessConnectionTime] < '20000101', 
            NULL, 
            [MeasurementDevice].[LastSuccessConnectionTime]
       ) [MeasurementDeviceLastSuccessConnectionTime]

    FROM [Business].[Channel] [Channel] WITH(NOLOCK)
    
    INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
        ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]

    INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
        ON [Channel].[PlacementId] = [Placement].[Id] AND [Placement].[HasIndividualAccounting] = 0

    INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
        ON [Placement].[BuildingId] = [Building].[Id]

    INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK) 
      ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
    
    WHERE [Channel].[Id] IN 
        (
            SELECT [UserLinkChannel].[ChannelId]
            FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
            WHERE [UserLinkChannel].[UserId] = @userId
        )  AND ([MeasurementDevice].[LastStatusConnectionId] = @statusConnectionId OR @statusConnectionId = 0)
		
      ORDER BY [Building].[Id], ISNULL([Channel].[Order], 1000),  [Channel].[Id];
    
END
GO