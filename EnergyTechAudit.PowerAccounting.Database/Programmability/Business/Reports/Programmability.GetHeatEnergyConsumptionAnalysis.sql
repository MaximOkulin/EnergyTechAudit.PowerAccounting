CREATE PROCEDURE Programmability.GetHeatEnergyConsumptionAnalysis
  @userName NVARCHAR(32),  
  @buildingId INT,
  @heatSysChannelId INT,

  @periodBegin DATETIME,
  @periodEnd DATETIME,
  @calcIndoorAirTemperature INT,
  @thermalEnergyRate INT,

  @defaultHourlyConsumptionHeat DECIMAL(9,4),
  @defaultMinimalTemperature INT,
  @defaultUseDeductionHwsHeat BIT, 
  @defaultCwsForHwsHeatingFactor DECIMAL(9,4),

  @isPreload BIT = 0
AS
BEGIN   
	SET NOCOUNT ON;  
	SET XACT_ABORT ON;

	BEGIN TRY      
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		BEGIN TRANSACTION;
		
		DECLARE  @errorMsg1 NVARCHAR(2048) = CONCAT
			(
				N'Отсутствуют или имеют неверное содержимое связанные с ресурсоснабжающей организацией (Organization) динамические параметры ',
				N'Organization.HeatCurveSupplyPipe и/или Organization.HeatCurveReturnPipe, ',
				N'описывающие температурные графики.'
			),
			@resultSetName [Programmability].[ResultSetNameTableType],
			@cityCode NVARCHAR(32), 
			@minimalTemperature INT;
		
		IF(@isPreload = 1)
		BEGIN
			INSERT INTO @resultSetName 
				OUTPUT inserted.[Order], inserted.[Name]
				VALUES 
                    (1, 'HeatSysChannels'),
                    (2, 'DiagnosticOrganizationHeatCurves')

			SELECT 
				[Channel].[Id] [Id], 
				[Channel].[Description] [Code],				
				[Channel].[Description] [Description]				
			FROM [Business].[Placement] [Placement] WITH(NOLOCK)    
				INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) ON [Placement].[Id] = [Channel].[PlacementId]				
			WHERE [Placement].[BuildingId] = @buildingId 
				AND [Placement].[PlacementPurposeId] = 2	-- AccountingNode	
				AND [Channel].[ResourceSystemTypeId] = 4	-- HeatSys
				AND [Channel].[ResourceSubsystemTypeId] IS NULL
            
            DECLARE @isValidOrganizationHeatCurves BIT;

            EXEC [Programmability].[GetOrganizationHeatCurves]
                @buildingId = @buildingId, 
                @onlyDiagnostic = @isPreload,
                @isValid = @isValidOrganizationHeatCurves OUTPUT

            SELECT @isValidOrganizationHeatCurves [IsValid];

			COMMIT TRANSACTION;   
			RETURN ;
		END;

	    SELECT @cityCode = [City].[LatinCode], @minimalTemperature = [City].[MinimalTemperature]
			FROM [Business].[Building] [Building] WITH(NOLOCK)
		        INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK) ON [Building].[DistrictId] = [District].[Id]
			    INNER JOIN [Dictionaries].[City] [City] ON [District].[CityId] = [City].[Id]    
				WHERE [Building].[Id] = @buildingId;
        IF(@minimalTemperature IS NULL)
		BEGIN
			SET @minimalTemperature	= @defaultMinimalTemperature;
		END;

		DECLARE @hourlyConsumptionHeat DECIMAL(9,4) = 
		TRY_CAST
		(
			(
			   SELECT TOP (1) [Value] FROM [Core].[DynamicParameterValue] [DynamicParameterValue]
			   WHERE [EntityId] = @buildingId AND [DynamicParameterId] = 180	-- 'Building.HourlyConsumptionHeat'
			) 
			AS DECIMAL(9,4)
		);  		
		IF(@hourlyConsumptionHeat IS NULL)
		BEGIN
			SET @hourlyConsumptionHeat = @defaultHourlyConsumptionHeat;
		END;

		DECLARE @cwsForHwsHeatingFactor DECIMAL(9,4) = 
		TRY_CAST
		(
			(
			   SELECT TOP (1) [Value] FROM [Core].[DynamicParameterValue] [DynamicParameterValue]
			   WHERE [EntityId] = @buildingId AND [DynamicParameterId] = 182	-- 'Building.CwsForHwsHeatingFactor'
			) 
			AS DECIMAL(9,4)
		);   
        IF(@cwsForHwsHeatingFactor IS NULL)
		BEGIN
			SET @cwsForHwsHeatingFactor = @defaultCwsForHwsHeatingFactor;
		END;

		DECLARE @useDeductionHwsHeat BIT = 
		TRY_CAST
		(
			(
			   SELECT TOP (1) [Value] FROM [Core].[DynamicParameterValue] [DynamicParameterValue]
			   WHERE [EntityId] = @buildingId AND [DynamicParameterId] = 183	-- 'Building.UseDeductionHwsHeat'
			) 
			AS BIT
		);   
        IF(@useDeductionHwsHeat IS NULL)
		BEGIN
			SET @useDeductionHwsHeat = @defaultUseDeductionHwsHeat;
		END;
				
		INSERT INTO @resultSetName 
		OUTPUT inserted.[Order], inserted.[Name]
		VALUES
			(1, 'ReportParameter'),         			
			(2, 'HeatCurvesData'),
			(3, 'MeteoData'),
			(4, 'HwsChannel')
               		
		DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 	

		INSERT INTO @reportParameter 
		OUTPUT inserted.[Name], inserted.[Value]
		VALUES	
			('UserName', @userName),
			('ChannelId', CAST( @heatSysChannelId AS NVARCHAR )),
			('FullAddress', (SELECT  [FullAddress] FROM [Business].[Building] [Building] WITH(NOLOCK) WHERE [Building].[Id] = @buildingId)),

			('MinimalTemperature', CAST( @minimalTemperature AS NVARCHAR )),
			('HourlyConsumptionHeat', CAST( @hourlyConsumptionHeat AS NVARCHAR )),
			('CwsForHwsHeatingFactor', CAST( @hourlyConsumptionHeat AS NVARCHAR )),			
			('UseDeductionHwsHeat', CAST(IIF(@useDeductionHwsHeat = 1, 'true', 'false') AS NVARCHAR )),

			('DefaultHourlyConsumptionHeat', CAST( @defaultHourlyConsumptionHeat AS NVARCHAR )),			
			('DefaultUseDeductionHwsHeat', CAST(IIF(@defaultUseDeductionHwsHeat = 1, 'true', 'false') AS NVARCHAR ));
		        	 
        EXEC [Programmability].[GetOrganizationHeatCurves]
                @buildingId = @buildingId, 
                @onlyDiagnostic = @isPreload,
                @isValid = @isValidOrganizationHeatCurves OUTPUT
        
		/* Обнуление временной части */
		 DECLARE @today DATETIME  = CAST( CAST( GETDATE() AS DATE ) AS DATETIME);		
		 SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME);
		 SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME);		 
		 SET @periodEnd = DATEADD(DAY, 1, @periodEnd);

		 IF(@periodEnd >= @today)
		 BEGIN
			SET @periodEnd = @today;
		 END;

		DECLARE @meteoStationMeasurementDeviceId INT = 
		(
			SELECT TOP(1) [Id]
			FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
			WHERE [MeasurementDevice].[DeviceId] = 52
		);

		DECLARE @meteoStationOutdoorAirDeviceParameterId INT = 
		(
			SELECT TOP(1) [DeviceParameter].[Id] FROM [Dictionaries].[DeviceParameter] [DeviceParameter]  WITH(NOLOCK)
			WHERE 
				[DeviceParameter].[DeviceId] = 52 AND
				[DeviceParameter].[Code] = 'Monitoring_Temper_MeteoOutdoorAir_' + @cityCode 
		);

		SELECT CONVERT(DATE, [Archive].[Time]) [Time], 
			   AVG([Archive].[Value]) [AverageTemperature]
			FROM [Business].[Archive] [Archive] WITH(NOLOCK)
			WHERE [PeriodTypeId] = 1 
			AND [MeasurementDeviceId] = @meteoStationMeasurementDeviceId
			AND [DeviceParameterId] = @meteoStationOutdoorAirDeviceParameterId
			AND [Time] >= @periodBegin
			AND [Time] < @periodEnd
		GROUP BY CONVERT(DATE, [Archive].[Time])
		ORDER BY [Time]
		
		SELECT 
			[Channel].[Id] [Id], 					
			[Channel].[Description] [Description],

			[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId],
			[Channel].[ResourceSubsystemTypeId] [ResourceSubsystemTypeId]

		FROM [Business].[Placement] [Placement] WITH(NOLOCK)    
			INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) ON [Placement].[Id] = [Channel].[PlacementId]				
		WHERE [Placement].[BuildingId] = @buildingId 
			AND [Placement].[PlacementPurposeId] = 2	-- AccountingNode	
			AND 
			(
				[Channel].[ResourceSystemTypeId] = 3 OR -- Hws
				(
					[Channel].[ResourceSystemTypeId] = 2 AND [Channel].[ResourceSubsystemTypeId] = 6 -- Cws + CwsForHws
				)
			)			
		COMMIT TRANSACTION;   
	END TRY
	BEGIN CATCH
		
	  IF (XACT_STATE()) = -1
      BEGIN       
        ROLLBACK TRANSACTION;
      END;
	       
      IF (XACT_STATE()) = 1
      BEGIN      
        COMMIT TRANSACTION;   
      END;
          
      DECLARE @lineFeed CHAR(1) = CHAR(13);

      DECLARE @parameterListTrace NVARCHAR(256) = 
             CONCAT
             (  
                '@userName: ' ,            @userName, @lineFeed,                 
                '@buildingId: ',           @buildingId, @lineFeed, 
                '@periodBegin: ',          @periodBegin, @lineFeed, 
                '@periodEnd: ',            @periodEnd, @lineFeed                 
             );

      DECLARE @errorMessage NVARCHAR(MAX) = 
         CONCAT
         (
            'ErrorNumber: ',     ERROR_NUMBER(), @lineFeed,
            'ErrorSeverity: ',   ERROR_SEVERITY(), @lineFeed,
            'ErrorState: ' ,     ERROR_STATE(), @lineFeed,
            'ErrorProcedure: ',  ERROR_PROCEDURE(), @lineFeed,
            'ErrorLine: ',       ERROR_LINE(), @lineFeed,
            'ErrorMessage: ',    ERROR_MESSAGE()
         );

      INSERT INTO [Admin].[ErrorLogEntry] 
         (
            [Time], 
            [Exception], 
            [Message], 
            [UserName],
            [StackTrace]
         )
      VALUES
         (
            GETDATE(), 
            'InternalSqlServerException', 
            @errorMessage, 
            SUSER_NAME(),
           @parameterListTrace
         );
      
      THROW;	
	END CATCH;
END;	
GO