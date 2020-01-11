-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2017-06-15
-- Update date: 2017-06-15
-- ====================================================================================================

CREATE PROC Programmability.GetUnitedAccountingParamSheet
    @userName NVARCHAR (32) = NULL,
    @buildingId INT = NULL,
    @periodTypeId INT = 3,
    @isPreload BIT = 1,
    
    @channelIdHeatSys INT = 0,
    @channelIdHeatSysBlock INT = 0,
    @channelIdHws INT = 0,
    @channelIdHeatSysMakeup INT = 0,
    @channelIdElectroSys INT = 0,

    @isStubMode BIT = 0,
    @resourceSubsystemTypeCode NVARCHAR(32) = NULL
AS
BEGIN
    SET NOCOUNT ON;

	IF OBJECT_ID('tempdb..#ChannelInfoStub') IS NOT NULL DROP Table #ChannelInfoStub

	SELECT [ChannelInfoStub].[Id]
          ,[ChannelInfoStub].[Code]
          ,[ChannelInfoStub].[Description]
          ,[ChannelInfoStub].[ChannelId]
          ,[ChannelInfoStub].[ResourceSystemTypeId]
          ,[ChannelInfoStub].[ResourceSubsystemTypeId]
          ,[ChannelInfoStub].[ResourceSystemTypeCode]
          ,[ChannelInfoStub].[ResourceSubsystemTypeCode]
          ,[ChannelInfoStub].[IsStubChannel]
          ,[ChannelInfoStub].[ChannelTemplateId] 
    INTO [#ChannelInfoStub] FROM 
	(
		SELECT 
			[ChannelInfoStub].[Id]
			 ,[ChannelInfoStub].[Code]
			 ,[ChannelInfoStub].[Description]
			 ,[ChannelInfoStub].[ChannelId]
			 ,[ChannelInfoStub].[ResourceSystemTypeId]
			 ,[ChannelInfoStub].[ResourceSubsystemTypeId]
			 ,[ChannelInfoStub].[ResourceSystemTypeCode]
			 ,[ChannelInfoStub].[ResourceSubsystemTypeCode]
			 ,[ChannelInfoStub].[IsStubChannel] 
			 ,[ChannelInfoStub].[ChannelTemplateId] 
        
			FROM 
			(
				VALUES 
				(0, CAST(NULL AS NVARCHAR(64)), CAST(NULL AS NVARCHAR(64)), 0, 4, NULL, N'HeatSys', N'HeatSys', CAST( CASE WHEN @channelIdHeatSys = 0 AND @isPreload = 0 THEN 1 ELSE 0 END AS BIT), 2),
				(0, CAST(NULL AS NVARCHAR(64)), CAST(NULL AS NVARCHAR(64)), 0, 4, 8, N'HeatSys', N'HeatSysBlock', CAST( CASE WHEN @channelIdHeatSysBlock = 0 AND @isPreload = 0 THEN 1 ELSE 0 END AS BIT), 3),        
				(0, CAST(NULL AS NVARCHAR(64)), CAST(NULL AS NVARCHAR(64)), 0, 4, 7, N'HeatSys', N'HeatSysMakeup', CAST( CASE WHEN @channelIdHeatSysMakeup = 0 AND @isPreload = 0 THEN 1 ELSE 0 END AS BIT), 500),            
				(0, CAST(NULL AS NVARCHAR(64)), CAST(NULL AS NVARCHAR(64)), 0, 3, NULL, N'Hws', N'Hws', CAST( CASE WHEN @channelIdHws = 0 AND @isPreload = 0 THEN 1 ELSE 0 END AS BIT), 101),        
				(0, CAST(NULL AS NVARCHAR(64)), CAST(NULL AS NVARCHAR(64)), 0, 5, NULL, N'ElectroSys', N'ElectroSys', CAST( CASE WHEN @channelIdElectroSys = 0 AND @isPreload = 0 THEN 1 ELSE 0 END AS BIT), 20)           
			) 
			[ChannelInfoStub]([Id], [Code], [Description], [ChannelId], [ResourceSystemTypeId], [ResourceSubsystemTypeId], [ResourceSystemTypeCode], [ResourceSubsystemTypeCode], [IsStubChannel], [ChannelTemplateId])
       
	) [ChannelInfoStub];

    IF(@isStubMode = 1 AND @resourceSubsystemTypeCode IS NOT NULL)
    BEGIN
        DECLARE @channelTemplateId INT = (SELECT [#ChannelInfoStub].[ChannelTemplateId] FROM [#ChannelInfoStub] WHERE [#ChannelInfoStub].[ResourceSubsystemTypeCode] = @resourceSubsystemTypeCode)
            
        EXEC [Programmability].[GetAccountingParamSheetStub] @periodTypeId = @periodTypeId, @channelTemplateId = @channelTemplateId ;
        
        RETURN;
    END;
	        
    DECLARE @userId INT = 
        (
            SELECT TOP (1) [User].[Id] 
            FROM [Admin].[User] WITH (NOLOCK) 
            WHERE [UserName] = @userName
        );

	SELECT [ResultSetName].[Order], [ResultSetName].[Name]
		FROM
		(
			VALUES (1, N'ReportParameter'), (2, N'MainData')) ResultSetName([Order], [Name]
		);

	SELECT [Name], [Value] FROM
	(SELECT                                         
		CAST([District].[Description] AS NVARCHAR(128)) [District],
		CAST([Building].[FullAddress] AS NVARCHAR(128)) [FullAddress]
             
		FROM  [Business].[Building] [Building] WITH (NOLOCK)
        
		INNER JOIN [Dictionaries].[District] [District] WITH (NOLOCK)
			ON [District].[Id] = [Building].[DistrictId]
           
		WHERE [Building].[Id] = @buildingId
	) [BuildingInfo]
	UNPIVOT 
	(  
		[Value] FOR [Name] IN 
		(             
		  [District], 
		  [FullAddress]               
		) 
	) [ReportParameter];

    (
		SELECT 
			[ChannelInfoStub].[Id]
		   ,[ChannelInfoStub].[Code]
		   ,[ChannelInfoStub].[Description]
		   ,[ChannelInfoStub].[ChannelId]
		   ,[ChannelInfoStub].[ResourceSystemTypeId]
		   ,[ChannelInfoStub].[ResourceSubsystemTypeId]
		   ,[ChannelInfoStub].[ResourceSystemTypeCode]
		   ,[ChannelInfoStub].[ResourceSubsystemTypeCode]
		   ,[ChannelInfoStub].[IsStubChannel] 

		FROM  [#ChannelInfoStub] [ChannelInfoStub]

		WHERE [ChannelInfoStub].[IsStubChannel] = 1
    )
    UNION ALL
    (
		SELECT 
			[ChannelInfo].[Id]
		   ,[ChannelInfo].[Code]
		   ,[ChannelInfo].[Description]

		   ,[ChannelInfo].[ChannelId]
		   ,[ChannelInfo].[ResourceSystemTypeId]
		   ,[ChannelInfo].[ResourceSubsystemTypeId]
		   ,[ChannelInfo].[ResourceSystemTypeCode]
		   ,[ChannelInfo].[ResourceSubsystemTypeCode]
		   ,CAST (0 AS BIT)  [IsStubChannel] 
		FROM 
		(SELECT 
			[Channel].[Id] [Id], 
			[Channel].[Description] [Code],
			[ResourceSystemType].[Description] [Description],

			[Channel].[Id] [ChannelId], 
			[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId],
			[Channel].[ResourceSubsystemTypeId] [ResourceSubsystemTypeId],        
			[ResourceSystemType].[Code] [ResourceSystemTypeCode],

			CASE [ResourceSystemType].[Id]
        		WHEN 3 THEN [ResourceSystemType].[Code]
        		ELSE COALESCE([ResourceSubsystemType].[Code], [ResourceSystemType].[Code]) 
			END [ResourceSubsystemTypeCode]
    
		FROM [Business].[Channel] [Channel] WITH(NOLOCK)
    
		INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
			ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
    
		INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
			ON [Channel].[PlacementId] = [Placement].[Id]
    
		INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
			ON [Placement].[BuildingId] = [Building].[Id]

		INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH (NOLOCK)
			ON [Channel].[ResourceSystemTypeId] = [ResourceSystemType].[Id]

		LEFT JOIN [Dictionaries].[ResourceSubsystemType] [ResourceSubsystemType] WITH (NOLOCK)
			ON [Channel].[ResourceSubsystemTypeId] = [ResourceSubsystemType].[Id]
    
		WHERE 
			(@isPreload = 0 OR [Building].[Id] = @buildingId)

			AND ([ResourceSystemType].[Code] IN (SELECT [#ChannelInfoStub].[ResourceSystemTypeCode] FROM [#ChannelInfoStub])) 

			AND (@isPreload = 1 OR ( [Channel].[Id] IN (@channelIdHeatSys, @channelIdHeatSysBlock, @channelIdHws, @channelIdHeatSysMakeup, @channelIdElectroSys))) 
        
		) [ChannelInfo] 
   
		WHERE [ChannelInfo].[Id] IN 
			(
				SELECT [UserLinkChannel].[ChannelId] 
				FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH (NOLOCK) 
				WHERE [UserLinkChannel].[UserId] = @userId
			)
	)

END;

GO