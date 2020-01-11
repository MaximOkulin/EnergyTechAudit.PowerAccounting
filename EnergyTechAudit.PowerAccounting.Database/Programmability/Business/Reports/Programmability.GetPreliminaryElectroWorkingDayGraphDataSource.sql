-- ====================================================================================================
-- Author:  	Maxim Okulin
-- Create date: 28 November 2017
-- Description: Формирует предварительные данные для отчета "График потребления активной и реактивной мощности в рабочий день"
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[GetPreliminaryElectroWorkingDayGraphDataSource]
@userName NVARCHAR(32),
@channelId INT,
@withDesignFactor BIT

AS
BEGIN
      
	  DECLARE @measurementDeviceId INT = 
      (
        SELECT TOP(1) [Channel].[MeasurementDeviceId] 
        FROM [Business].[Channel] [Channel] WITH (NOLOCK)
        WHERE [Channel].[Id] = @channelId 
      );

	    DECLARE @deviceId INT;
	    DECLARE @deviceCode NVARCHAR(64);
      
      SELECT TOP(1) 
        @deviceId = [MeasurementDevice].[DeviceId], 
        @deviceCode = [Device].[Code]
      
      FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)

      INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)
        ON [MeasurementDevice].[DeviceId] = [Device].[Id]

      WHERE [MeasurementDevice].[Id] = @measurementDeviceId


	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

      INSERT INTO @resultSetName VALUES
         (1, 'ReportParameter'),
		 (2, 'MainData'),
		 (3, 'ActivePowerSecondData'),
		 (4, 'ActivePowerSummaryData'),
		 (5, 'ReactivePowerFirstData'),
		 (6, 'ReactivePowerSecondData')
		 
	  SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName]

	  DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 

	  INSERT INTO @reportParameter ([Name], [Value]) VALUES ('UserName', @userName);

	  INSERT INTO @reportParameter
         SELECT [Name], [Value]
         FROM
		      (SELECT             
               
               CAST([D].[Code] AS NVARCHAR(128)) [DeviceCode],
			   CAST([D].[ShortName] AS NVARCHAR(128)) [DeviceShortName],
			   CONVERT(NVARCHAR(128), [Md].[FactoryNumber], 0) [FactoryNumber],
			   CAST([Building].[Description] AS NVARCHAR(128)) [BuildingDescription]
			  
		      FROM [Business].[MeasurementDevice] [Md] WITH (NOLOCK)
			      INNER JOIN [Dictionaries].[Device] [D] 
              ON [D].[Id] = [Md].[DeviceId]
			      
            INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
              ON [Channel].[MeasurementDeviceId] = [Md].[Id] AND [Channel].[Id] = @channelId --!IMPORTANT
		    
			INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
             ON [Channel].[PlacementId] = [Placement].[Id]

            INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
             ON [Building].[Id] = [Placement].[BuildingId])  [MeasurementDeviceInfo]  
         UNPIVOT 
         (  
            [Value] FOR [Name] IN 
            (
              [DeviceCode],
			  [DeviceShortName],
			  [FactoryNumber],
			  [BuildingDescription]
            ) 
         ) [ReportParameter];
  
      IF(@deviceCode = 'Mercury230' OR @deviceCode = 'CET_4TM_03M' OR @deviceCode = 'Mercury234')
	   BEGIN
	        DECLARE @designFactor NVARCHAR(8) = (SELECT  [DPV].[Value] [Value] FROM [Core].[DynamicParameterValue] [DPV]
		          WHERE [DPV].[DynamicParameterId] = 166 AND [DPV].[EntityId] = @measurementDeviceId)
            IF @designFactor IS NULL OR @withDesignFactor = 0
	        BEGIN
			   SET @designFactor = 1
			END

			INSERT INTO @reportParameter ([Name],[Value])
			VALUES ('DesignFactor', @designFactor)
	   END

	  SELECT 
         [ReportParameter].[Name], 
         [ReportParameter].[Value] 
      FROM @reportParameter [ReportParameter];
         
      SELECT 1;
	  SELECT 1;
	  SELECT 1;
	  SELECT 1;
	  SELECT 1;
END;
