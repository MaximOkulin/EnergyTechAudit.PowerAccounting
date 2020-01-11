-- ====================================================================================================
-- Author:  	Leo & Okulin Maxim 
-- Create date: 2018-01-16
-- Description: Возвращает набор данных для отчета 'Временной срез по показаниям контроллеров погодозависимого регулирования'
-- ====================================================================================================

CREATE PROCEDURE Programmability.GetRegulatorsTimeSlices 
    @userName NVARCHAR(32),
    @periodBegin DATETIME,
	@periodBeginOffset INT = 24,
    @includeAnyMeasurement BIT
AS
BEGIN	
	SET NOCOUNT ON;

	SET XACT_ABORT ON;

   BEGIN TRY

      /* все выборки в составе хранимой процедуры имеют статус "грязных" */
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	BEGIN TRANSACTION;

	 /* Имена выходных резульсетов возвращаемых в отчет */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

    INSERT INTO @resultSetName 
    OUTPUT inserted.[Order], inserted.[Name]
    VALUES
         (1, 'ReportParameter'),         
         (2, 'MainData');         
    
	DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
	
	 SELECT 'UserName' [Name], CONVERT(NVARCHAR(128), @userName) [Value]
 
      DECLARE @userId  INT;    
      DECLARE @roleCode NVARCHAR(64);

      EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;
     	  
	  DECLARE @periodEnd DATETIME = DATEADD(HOUR, -@periodBeginOffset, @periodBegin); 

	  WITH [NearestTimeSignature]
       AS 
       (
           SELECT 
                [TimeSignature].[MeasurementDeviceId]
                ,[TimeSignature].[TimeSignatureId]
				,[TimeSignature].[TimeSignatureTime]
            FROM
           (
                SELECT 
                    ROW_NUMBER() OVER(PARTITION BY  [MeasurementDevice].[Id] ORDER BY [TimeSignature].[Time] DESC) [Num]
                    ,[MeasurementDevice].[Id] [MeasurementDeviceId]
                    ,[TimeSignature].[Id] [TimeSignatureId]
                    ,[TimeSignature].[Time] [TimeSignatureTime]
                        
                FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)
                
                INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                    ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]
                
                INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
                    ON [Channel].[Id] = [UserLinkChannel].[ChannelId] AND [UserLinkChannel].[UserId] = @userId  
        
                INNER JOIN [Business].[TimeSignature] [TimeSignature] WITH(NOLOCK)
                    ON [MeasurementDevice].[Id] = [TimeSignature].[MeasurementDeviceId]
                                       
                    -- It's "non searchable args" already! 
                   AND 
                   (                        
                        (@includeAnyMeasurement = 0 AND [TimeSignature].[Time] <= @periodBegin AND [TimeSignature].[Time] >= @periodEnd) 											 
                        OR 
                        (@includeAnyMeasurement = 1 AND [TimeSignature].[Time] <= @periodBegin)
                   )
                                        
        
                 WHERE 
                    [MeasurementDevice].[DeviceId] IN (8, 34) AND [Channel].[ResourceSystemTypeId] = 8
            ) [TimeSignature]
    
            WHERE [TimeSignature].[Num] = 1
        )  

		SELECT 
				[Building].[Id] [BuildingId],
				[Building].[Description] [BuildingDescription],				
				[Device].[ShortName] [DeviceShortName], 

				[FinalMainData].[Time] [Time],
				[FinalMainData].[Monitoring.Temper.ReturnPipe],
				[FinalMainData].[Monitoring.Temper.HwsReturnPipe],
				[FinalMainData].[Monitoring.Temper.CalcSupplyPipe],
				[FinalMainData].[Monitoring.Temper.SupplyPipe],
				[FinalMainData].[Monitoring.Temper.CalcHwsReturnPipe],
				[FinalMainData].[Monitoring.Temper.CalcReturnPipe],
				[FinalMainData].[Monitoring.Temper.HwsSupplyPipe],
				[FinalMainData].[Monitoring.Temper.OutdoorAir],
				[FinalMainData].[Monitoring.Temper.CalcHwsSupplyPipe] 

				,ABS(([FinalMainData].[Monitoring.Temper.CalcReturnPipe] - [FinalMainData].[Monitoring.Temper.ReturnPipe])) [Monitoring.Temper.ReturnPipe.Err]
				,ABS(([FinalMainData].[Monitoring.Temper.CalcSupplyPipe] - [FinalMainData].[Monitoring.Temper.SupplyPipe])) [Monitoring.Temper.SupplyPipe.Err]
				,ABS(([FinalMainData].[Monitoring.Temper.CalcHwsSupplyPipe] - [FinalMainData].[Monitoring.Temper.HwsSupplyPipe])) [Monitoring.Temper.HwsSupplyPipe.Err]
				,ABS(([FinalMainData].[Monitoring.Temper.CalcHwsReturnPipe] - [FinalMainData].[Monitoring.Temper.HwsReturnPipe])) [Monitoring.Temper.HwsReturnPipe.Err]
		FROM
		(
			SELECT 
				[MeasurementDeviceId],
				[PlacementId],
				[Time],
				[Monitoring.Temper.ReturnPipe],
				[Monitoring.Temper.HwsReturnPipe],
				[Monitoring.Temper.CalcSupplyPipe],
				[Monitoring.Temper.SupplyPipe],
				[Monitoring.Temper.CalcHwsReturnPipe],
				[Monitoring.Temper.CalcReturnPipe],
				[Monitoring.Temper.HwsSupplyPipe],
				[Monitoring.Temper.OutdoorAir],
				[Monitoring.Temper.CalcHwsSupplyPipe]
			FROM     
			(
					SELECT             							
					[Archive].[MeasurementDeviceId] [MeasurementDeviceId]
					,[Channel].[PlacementId] [PlacementId]
					,[NearestTimeSignature].[TimeSignatureTime] [Time]
					,[Parameter].[Code] [ParameterCode]
					,[Archive].[Value] [Value]          										

				FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)

				 INNER JOIN [NearestTimeSignature] 
					ON [NearestTimeSignature].[MeasurementDeviceId] = [MeasurementDevice].[Id]

				INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
					ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]
        
				INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
					ON [Channel].[Id] = [UserLinkChannel].[ChannelId] AND [UserLinkChannel].[UserId] = @userId

				INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK)
					ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]

				INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH(NOLOCK)
					ON [ChannelTemplate].[Id] = [ParameterMapDeviceParameter].[ChannelTemplateId]

				INNER JOIN [Dictionaries].[Parameter] [Parameter] WITH(NOLOCK)
					ON [ParameterMapDeviceParameter].[ParameterId] = [Parameter].[Id]
       
				INNER JOIN [Business].[Archive] [Archive] WITH(NOLOCK)         
					ON [MeasurementDevice].[Id] = [Archive].[MeasurementDeviceId] 
			
					AND [Archive].[TimeSignatureId] = [NearestTimeSignature].[TimeSignatureId]
			
					AND [Archive].[PeriodTypeId] = 1

					AND [ParameterMapDeviceParameter].[DeviceParameterId] = [Archive].[DeviceParameterId]
            
					AND [Archive].[IsValid] = 1
			   
				WHERE 
					[MeasurementDevice].[DeviceId] IN (8, 34) 
					AND [Channel].[ResourceSystemTypeId] = 8					

			) [MainData]
		 
			 PIVOT 
			(
				AVG([Value])
				FOR [ParameterCode] IN 
				(
					[Monitoring.Temper.ReturnPipe],
					[Monitoring.Temper.HwsReturnPipe],
					[Monitoring.Temper.CalcSupplyPipe],
					[Monitoring.Temper.SupplyPipe],
					[Monitoring.Temper.CalcHwsReturnPipe],
					[Monitoring.Temper.CalcReturnPipe],
					[Monitoring.Temper.HwsSupplyPipe],
					[Monitoring.Temper.OutdoorAir],
					[Monitoring.Temper.CalcHwsSupplyPipe]
				)
			) [PivotedMainData]
		) [FinalMainData]

		INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
			ON [Placement].[Id] = [FinalMainData].[PlacementId]

		INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
			ON [Building].[Id] = [Placement].[BuildingId]

		INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK) 
			ON [MeasurementDevice].[Id] =  [FinalMainData].[MeasurementDeviceId]

		INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK) 
			ON [Device].[Id] = [MeasurementDevice].[DeviceId]

	COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH
       
      /* транзакция имеет активную внутреннюю ошибку и дожна быть откатится */
      IF (XACT_STATE()) = -1
      BEGIN       
        ROLLBACK TRANSACTION;
      END;

      -- !IMPORTANT
      /* транзакция валидна, но подтверждение  не наступило, 
         например в силу генерации пользовательской ошибки */ 
      IF (XACT_STATE()) = 1
      BEGIN      
        COMMIT TRANSACTION;   
      END;
          
      DECLARE @lineFeed CHAR(1) = CHAR(13);

      DECLARE @parameterListTrace NVARCHAR(256) = 
             CONCAT
             (  
                '@userName: ' ,            @userName, @lineFeed,                 
                '@periodBegin: ',          @periodBegin, @lineFeed               
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
   END CATCH	
END;
GO