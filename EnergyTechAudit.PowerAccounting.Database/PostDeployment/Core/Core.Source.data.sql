SET IDENTITY_INSERT [Core].[Source] ON;

INSERT INTO [Core].[Source] ([Id], [Template])
VALUES       
	
	(2, 'EXEC [Programmability].[GetChannelDistribution]
		@cityId = {cityId}, @userName=''{userName}'''),
	
	(6, 'EXEC [Programmability].[MeasurementDeviceListForOperAdmin]
		@userName=''{userName}'''),

	(7, 'EXEC [Programmability].[MeasurementDeviceArchiveData] 
		@userName = ''{userName}'', 
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'',
		@channelId = {channelId},
		@periodTypeId = {periodTypeId}'),

	(8, 'EXEC [Programmability].[MeasurementDeviceCustomInfoListForOperAdmin] 
		@userName=''{userName}'''),

	(9, 'EXEC [Programmability].[GetParametersInfoByDevice] 
		@deviceId={deviceId}'),

	(10, 'EXEC [Programmability].[GetAccountingParamSheet] 
		@userName = ''{userName}'',			
        @channelId = {channelId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'',
        @includePeriodEnd = {includePeriodEnd},
		@periodTypeId = {periodTypeId}'),

	(11, 'EXEC [Programmability].[GetErrorLog] @monthCount = {monthCount}'),

	(13, 'EXEC [Programmability].[DoUserLinkChannel] 
         
		@userName = ''{userName}'',
		@operationUniqueId = ''{uniqueIdentifier}'',

		@operationType = {operationType},
		@userIdArray =  ''{userIdArray}'',
		@deviceIdArray = ''{deviceIdArray}'',        
		@districtIdArray = ''{districtIdArray}'',
		@organizationIdArray = ''{organizationIdArray}'',
		@resourceSystemTypeIdArray = ''{resourceSystemTypeIdArray}'',
		@showOutputLinksInfo = {showOutputLinksInfo}, 
		@useBriefcase = {useBriefcase},
		@briefcaseId = {briefcaseId}'),

	(14, 'EXEC [Programmability].[GetMeasurementDeviceSignalQuality] 
		@userName = ''{userName}'', @districtId = {districtId}, @transportServerModelId = {transportServerModelId}, @transportServerModelStatusId = {transportServerModelStatusId}, @deviceStatusId = {deviceStatusId}, @deviceId = {deviceId}'),

	(15, 'EXEC [Programmability].[GetAudit] @monthCount = {monthCount}'),

	(16, 'EXEC [Programmability].[GetMultipleToMultipleInfo]  @linkName = ''{linkName}'', @direction = ''{direction}'''),

	(17, 'EXEC [Programmability].[GetPivotDiagrammByDevice] @userName = ''{userName}'', @districtId = {districtId}'),
   
	(18, 'EXEC [Programmability].[GetPivotDiagrammByDistrict] @userName = ''{userName}'', @deviceId = {deviceId}'),
   
	(19, 'EXEC [Programmability].[GetPivotDiagrammByConnectionQuality] @userName = ''{userName}'', @deviceId = {deviceId}, @districtId = {districtId}'),
   
	(20, 'EXEC [Programmability].[GetFlatHolderAccountingParamSheet] 
		@userName = ''{userName}'',			
		@channelId = {channelId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'''
	),

    (21, 'SELECT NULL'), -- a vacancy

	(22, 'EXEC [Programmability].[GetArchives] 
		@measurementDeviceId = {measurementDeviceId},
		@factoryNumber = {factoryNumber},
		@deviceId = {deviceId},
		@periodTypeId = {periodTypeId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'''),
   
   (23, 'EXEC [Programmability].[GetFlatHolderAccounts] 
		@userName = ''{userName}'', 
		@organizationId = {organizationId}, @isBeginBuildingWithNewPage = {isBeginBuildingWithNewPage}'),

	  (24, 'EXEC [Programmability].[GetUserMessages] @userName = ''{userName}'''),

	  (25, 'EXEC [Programmability].[GetMeasurementDeviceSignalQuality] 
		@userName = ''{userName}'', @buildingId = {buildingId}, @resourceSystemTypeId = {resourceSystemTypeId},  @deviceStatusId = {deviceStatusId}, @isFlatAccounting = 1'),

	  (26, 'EXEC [Programmability].[GetMeasurementDeviceDistribution]
		@cityId = {cityId}, @userName=''{userName}'''),

	  (27, 'EXEC [Programmability].[GetLostMeasurementDevices]'),

	  (28, 'EXEC [Programmability].[GetTv7MeasurementDeviceJournal] @userName = ''{userName}'', @channelId = {channelId}, @asyncArchiveTypeId = {asyncArchiveTypeId}'),

	  (29, 'EXEC [Programmability].[GetSummaryAccountingSheet] 
		@userName = ''{userName}'', 
		@resourceSystemTypeId = {resourceSystemTypeId},
		@districtId = {districtId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'', 
		@briefcaseId = {briefcaseId}'),
		
	(30, 'EXEC [Programmability].[GetChannelsEmergencySituationParameters] 
		@userName = ''{userName}'', @resourceSystemTypeId = {resourceSystemTypeId},  @districtId = {districtId}'),

	(31, 'EXEC [Programmability].[GetChannelsEmergencySituationParameters] 
		@userName = ''{userName}'', @resourceSystemTypeId = {resourceSystemTypeId},  @districtId = {districtId}, @fillAllData = 1'),

	(32, 'EXEC [Programmability].[GetVzljot26MeasurementDeviceJournal] @userName = ''{userName}'', @channelId = {channelId}, @asyncArchiveTypeId = {asyncArchiveTypeId}'),

	(33, 'EXEC [Programmability].[GetEmergencySituationSummary] 
        @userName = ''{userName}'', 
        @resourceSystemTypeId = {resourceSystemTypeId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'''
	),

	(34, 'EXEC [Programmability].[GetSystemProtocols] 
        @userName = ''{userName}'',
        @periodBegin = ''{periodBegin}'',
        @periodEnd = ''{periodEnd}'',
        @intervalByDay = {intervalByDay}, 
        @protocolType = ''{protocolType}'', 
        @entityCodeArray = ''{entityCodeArray}'', 
        @selectAllEntity = {selectAllEntity}'
	),

	(35, 'EXEC [Programmability].[DoMeasurementDevicePollingInterval] 
		@userName = ''{userName}'',
        @operationUniqueId = ''{uniqueIdentifier}'',
		@pollingInterval = {pollingInterval},
		@deviceIdArray = ''{deviceIdArray}'',        
		@districtIdArray = ''{districtIdArray}'',		
		@showOutputLinksInfo = {showOutputLinksInfo}'
	),

	(36, 'EXEC [Programmability].[GetUnitedAccountingParamSheet] 
			@userName = ''{userName}'', 
			@buildingId = {buildingId}, 
			@isPreload = {isPreload}, 
			@periodTypeId = {periodTypeId},

			@channelIdHeatSys = {channelIdHeatSys}, 
			@channelIdHeatSysBlock = {channelIdHeatSysBlock},
			@channelIdHws = {channelIdHws},
			@channelIdHeatSysMakeup = {channelIdHeatSysMakeup},
			@channelIdElectroSys = {channelIdElectroSys}'),

     (37, 'EXEC [Programmability].[GetResourceReleaseBalance]
	        @userName = ''{userName}'', 
			@resourceBuildingId = {resourceBuildingId},
			@resourceSystemTypeId1 = {resourceSystemTypeId1}'),
     
	 (38, 'EXEC [Programmability].[GetPreliminaryElectroWorkingDayGraphDataSource]
	            @userName = ''{userName}'',			
                @channelId = {channelId},
				@withDesignFactor = {withDesignFactor}'),
	
	(39, 'EXEC [Programmability].[GetRegulatorsTimeSlices]
	            @userName = ''{userName}'',			
                @periodBegin = ''{periodBegin}'',
				@periodBeginOffset = {periodBeginOffset},
    			@includeAnyMeasurement = {includeAnyMeasurement}'),

	(40, 'EXEC [Programmability].[GetHeatEnergyConsumptionAnalysis]
	            @userName = ''{userName}'',			
				@buildingId = {buildingId},
				@heatSysChannelId = {heatSysChannelId},
                @periodBegin = ''{periodBegin}'',
				@periodEnd = ''{periodEnd}'',
				@calcIndoorAirTemperature = {calcIndoorAirTemperature},
				@thermalEnergyRate = {thermalEnergyRate},
				@defaultHourlyConsumptionHeat = {defaultHourlyConsumptionHeat},
				@defaultMinimalTemperature = {defaultMinimalTemperature},
				@defaultUseDeductionHwsHeat = {defaultUseDeductionHwsHeat},
				@defaultCwsForHwsHeatingFactor = {defaultCwsForHwsHeatingFactor},
				@isPreload = {isPreload}'),
	
	(41, 'EXEC [Programmability].[GetIndividualAccountingPeriodicalAverageResourceConsumptionByParameter]  
				@buildingId = {buildingId},
				@parameterId = {parameterId},
				@periodBegin = ''{periodBegin}'',
				@periodEnd = ''{periodEnd}'''
	),

			
    (47, 'EXEC [Programmability].[GetAccountingParamSheetEmergencySituations] 
		@userName = ''{userName}'',			
        @channelId = {channelId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'',
		@periodTypeId = {periodTypeId}'),

    (48, 'EXEC [Programmability].[GetDeviceSettings] 
		@userName = ''{userName}'',			
        @channelId = {channelId}'),

    (49, 'EXEC [Programmability].[GetAccountingParamSheet] 
		@userName = ''{userName}'',			
        @channelId = {channelId},
		@periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'',
        @includePeriodEnd = {includePeriodEnd},
		@periodTypeId = 2'),

    (50, 'EXEC [Programmability].[GetIndividualAccountingBalanceSheet] 
        @userName = ''{userName}'',
        @buildingId = {buildingId},
        @resourceSystemTypeId = {resourceSystemTypeId}, 
        @periodBegin = ''{periodBegin}'',
		@periodEnd = ''{periodEnd}'''),

    (51, 'EXEC [Programmability].[GetUserExtendedInfoSummary] @userName = ''{userName}''')
	
GO

SET IDENTITY_INSERT [Core].[Source] OFF;
GO