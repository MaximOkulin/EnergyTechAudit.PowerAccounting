CREATE PROCEDURE [Programmability].[GetOrganizationHeatCurves]
	@buildingId INT,
	@onlyDiagnostic BIT,
	@isValid BIT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @isValid = 1;
	
	DECLARE @heatCurveJson NVARCHAR(MAX) = '';

	SELECT @heatCurveJson = @heatCurveJson + CONCAT(' "object', [DynamicParameter].[Id], '": ', [DynamicParameterValue].[Value], ', ')

	FROM [Dictionaries].[DynamicParameter] [DynamicParameter] WITH(NOLOCK)

		INNER JOIN [Core].[DynamicParameterValue] [DynamicParameterValue] WITH(NOLOCK)
			ON [DynamicParameterValue].[DynamicParameterId] = [DynamicParameter].[Id]        
	WHERE 
		[DynamicParameter].[Id] IN (61, 62)     -- Organization.HeatCurveSupplyPipe, Organization.HeatCurveReturnPipe 
		AND [DynamicParameter].[EntityTypeName] = 'Organization' 
		AND [DynamicParameterValue].[EntityId] IN 
		(
			SELECT 
				[Organization].[Id] [OrganizationId]
                
			FROM [Business].[Building] [Building] WITH(NOLOCK)
				INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK) ON [Building].[Id] = [Placement].[BuildingId]
				INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) ON [Placement].[Id] = [Channel].[PlacementId]
				INNER JOIN [Business].[Organization] [Organization] WITH(NOLOCK) ON [Channel].[OrganizationId] = [Organization].[Id]            
			WHERE 
				[Building].[Id] = @buildingId 
				AND [Channel].[ResourceSystemTypeId] = 4        -- HeatSys
				AND [Organization].[OrganizationTypeId] = 3     -- Rsc
		)
		 
	IF (@heatCurveJson IS NOT NULL AND @heatCurveJson != '')		
	BEGIN			
		SET @heatCurveJson =  '{'  +  LEFT(@heatCurveJson, LEN(@heatCurveJson) - 1) + '}';
		IF (ISJSON(@heatCurveJson) != 1)
		BEGIN 
			-- Json ia not valid!
			SET @isValid = 0;
		END		
	END
	ELSE
	BEGIN
		-- There are no associated Organization.HeatCurveSupplyPipe or Organization.HeatCurveReturnPipe dynamic parameters				
		SET @isValid = 0;
	END;

	IF(@isValid = 1 AND @onlyDiagnostic = 0)
	BEGIN
		SELECT [HeatCurveSupplyPipe].[Temper.OutdoorAir]    
				,[HeatCurveSupplyPipe].[Organization.HeatCurveSupplyPipe]
				,[HeatCurveReturnPipe].[Organization.HeatCurveReturnPipe]        
		FROM 
			(
				SELECT [Organization.HeatCurveSupplyPipe], CAST(REPLACE([Temperature], '°С', '') AS DECIMAL(9,4)) [Temper.OutdoorAir]
				FROM OPENJSON(@heatCurveJson, '$.object61.userInputValues')
				WITH 
				(   	
					[Organization.HeatCurveSupplyPipe] DECIMAL(9,4) '$.value',  
					[Temperature]	NVARCHAR(32)   '$.caption'        
				) 
			) [HeatCurveSupplyPipe]
			INNER JOIN 
			(
				SELECT [Organization.HeatCurveReturnPipe], CAST(REPLACE([Temperature], '°С', '') AS DECIMAL(9,4)) [Temper.OutdoorAir]
				FROM OPENJSON(@heatCurveJson, '$.object62.userInputValues')
				WITH 
				(   	
					[Organization.HeatCurveReturnPipe] DECIMAL(9,4) '$.value',  
					[Temperature]	NVARCHAR(32) '$.caption'        
					)
			) [HeatCurveReturnPipe] ON [HeatCurveSupplyPipe].[Temper.OutdoorAir] = [HeatCurveReturnPipe].[Temper.OutdoorAir] 
	END;
END;