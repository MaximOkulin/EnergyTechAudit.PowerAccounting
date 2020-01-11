CREATE PROCEDURE Programmability.GetResourceReleaseBalance
	@userName NVARCHAR (32) = NULL,
    @resourceBuildingId INT = NULL,
	@resourceSystemTypeId1 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @userId INT = 
        (
            SELECT TOP (1) [User].[Id] 
            FROM [Admin].[User] WITH (NOLOCK) 
            WHERE [UserName] = @userName
        );

	SELECT [ResultSetName].[Order], [ResultSetName].[Name]
		FROM
		(
			VALUES (1, N'ReportParameter'), (2, N'SummaryData'), (3, 'MainData')) ResultSetName([Order], [Name]
		);

	SELECT [Name], [Value] FROM	
	(	SELECT                                         
			CAST([District].[Description] AS NVARCHAR(128)) [District],
			CAST([Building].[FullAddress] AS NVARCHAR(128)) [FullAddress],
			CAST([Placement].[Description] AS NVARCHAR(128)) [PlacementDescription]
             
			FROM  [Business].[Building] [Building] WITH (NOLOCK)
        
			INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
				ON [Placement].[BuildingId] = [Building].[Id]

			INNER JOIN [Dictionaries].[District] [District] WITH (NOLOCK)
				ON [District].[Id] = [Building].[DistrictId]
           
			WHERE [Building].[Id] = @resourceBuildingId
	) 			
	[Info]
	UNPIVOT 
	(  
		[Value] FOR [Name] IN 
		(             
		  [District], 
		  [FullAddress],
		  [PlacementDescription]
		) 
	) [ReportParameter]
	UNION 
	(
			SELECT 
				'ResourceSystemTypeDescription' [Name],
				CAST([ResourceSystemType].[Description] AS NVARCHAR(128)) [Value] 
			FROM 
				[Dictionaries].[ResourceSystemType] [ResourceSystemType]
			WHERE 
				[ResourceSystemType].[Id] = @resourceSystemTypeId1
	);

   SELECT 

		[Channel].[Id] [ChannelId],
		[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId],
        [Channel].[Description] [ChannelDescription],
        [Building].[Description] [BuildingDescription],
        0 [IsConsumer]

	FROM  [Business].[Channel] [Channel] WITH (NOLOCK)

	INNER JOIN  [Business].[Placement] [Placement] WITH (NOLOCK)
		ON [Channel].[PlacementId] = [Placement].[Id]

	INNER JOIN  [Business].[Building] [Building] WITH (NOLOCK)
		ON [Placement].[BuildingId] = [Building].[Id]

	WHERE [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId1 AND

	      [Channel].[ResourceSubsystemTypeId] IS NULL AND
		  [Channel].[PlacementId] IN
  	      (
            SELECT [Id] FROM [Business].[Placement] WITH(NOLOCK) WHERE [BuildingId]= @resourceBuildingId
		 );

	SELECT 

		[Channel].[Id] [ChannelId],
		[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId],
        [Channel].[Description] [ChannelDescription],
        [Building].[Description] [BuildingDescription],
        1 [IsConsumer]

	FROM  [Business].[Channel] [Channel] WITH (NOLOCK)

	INNER JOIN  [Business].[Placement] [Placement] WITH (NOLOCK)
		ON [Channel].[PlacementId] = [Placement].[Id]

	INNER JOIN  [Business].[Building] [Building] WITH (NOLOCK)
		ON [Placement].[BuildingId] = [Building].[Id]

	WHERE [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId1 AND

	      [Channel].[ResourceSubsystemTypeId] IS NULL AND
		  [Channel].[PlacementId] IN
  	      (
				   SELECT [Id] FROM [Business].[Placement] WITH(NOLOCK) WHERE [BuildingId] IN
	                (
	                   SELECT [BuildingMapResourceBuilding]. [BuildingId]
	                   FROM [Business].[BuildingMapResourceBuilding] [BuildingMapResourceBuilding] WITH (NOLOCK)
	                   WHERE 
						[BuildingMapResourceBuilding].[ResourceBuildingId] = @resourceBuildingId 
						AND [ResourceSystemTypeId] = @resourceSystemTypeId1
					)
		 )
END;

GO