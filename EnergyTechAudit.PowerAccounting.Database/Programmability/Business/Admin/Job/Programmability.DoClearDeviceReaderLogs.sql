-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20150418
-- Description: The stored procedure clears some logs of device reader(s) 
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoClearDeviceReaderLogs]
	@deviceEventSaveDeepInHours INT = 36, 
	@deviceReaderErrorLogSaveDeepInDays INT = 30
AS
BEGIN  
				
	BEGIN TRANSACTION;
	BEGIN TRY
		SET NOCOUNT ON;	

		-- Clear DeviceEvent with a records saving for 36 hours deep 
		-- ( стратегия "малого остатка" -  усечение таблицы и сохранение остатка во временной таблице )

		IF(OBJECT_ID('tempdb..#DeviceEvent') IS NOT NULL)
		BEGIN
			DROP TABLE #DeviceEvent;	
		END;
 
		SELECT  
			[Time]
			,[DeviceEventParameterId]
			,[MeasurementDeviceId]
			,[State]       
		INTO #DeviceEvent
		FROM
		(    
			SELECT 
				[DeviceEvent].[Time]
				,[DeviceEvent].[DeviceEventParameterId]
				,[DeviceEvent].[MeasurementDeviceId]
				,[DeviceEvent].[State]
			FROM [Business].[DeviceEvent] [DeviceEvent] WITH (NOLOCK) 
    
			WHERE [DeviceEvent].[Time] BETWEEN DATEADD(HOUR, -@deviceEventSaveDeepInHours, GETDATE()) AND GETDATE() 
		) [DeviceEvent];

		TRUNCATE TABLE [Business].[DeviceEvent];

		INSERT INTO [Business].[DeviceEvent] ([Time], [DeviceEventParameterId], [MeasurementDeviceId], [State])
		SELECT 
			[Time]
			,[DeviceEventParameterId]
			,[MeasurementDeviceId]
			,[State]         
		FROM #DeviceEvent;
        
		-- Clear DeviceReaderErrorLog  with a records saving for 30  days deep
		-- ( стратегия "большого куска" -  сохранение потенциально большого числа записей в зачищаемой таблице без возможности транкейта  )
		DECLARE @allRecordsCount INT =
		(
			SELECT COUNT(*)
			FROM [Business].[DeviceReaderErrorLog] [DeviceReaderErrorLog] WITH(NOLOCK)
		);

		DECLARE @savingRecordsCount INT =
		(
			SELECT COUNT(*)
			FROM [Business].[DeviceReaderErrorLog] [DeviceReaderErrorLog] WITH(NOLOCK)
			WHERE [DeviceReaderErrorLog].[Time] BETWEEN DATEADD(DAY, -@deviceReaderErrorLogSaveDeepInDays, GETDATE()) AND GETDATE() 
		);
		 DECLARE @width INT = 1000;
	
		 DECLARE @cleanerSteps INT = (@allRecordsCount - @savingRecordsCount) / @width;
		 DECLARE @cleanerStepsCounter INT = 1;

		 DECLARE @now DATETIME = GETDATE();
		 DECLARE @saveBound DATETIME = DATEADD(DAY, -@deviceReaderErrorLogSaveDeepInDays, GETDATE());

		 --  no truncting batch deletion without locks 
		 WHILE(@cleanerStepsCounter < @cleanerSteps AND @@ROWCOUNT > 0)
		 BEGIN
			DELETE TOP (@width) FROM [Business].[DeviceReaderErrorLog] 
			WHERE [DeviceReaderErrorLog].[Time] NOT BETWEEN @saveBound AND @now;
			SET @cleanerStepsCounter = @cleanerStepsCounter + 1;
		 END;
		
		IF(@@TRANCOUNT > 0)
		BEGIN
			COMMIT TRANSACTION;
		END;
	END TRY

	BEGIN CATCH   
	 
		IF(@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION;
		END;    
    
		DECLARE @errorNumber INT = ERROR_NUMBER();      
		DECLARE @error NVARCHAR(256) = CONCAT( ERROR_MESSAGE(), ' ', 'Код ошибки: ', @errorNumber);      
		SET @error = CONCAT( @error, CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());

		DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;

		DECLARE @subject NVARCHAR(MAX) = CONCAT
		(
			'Ошибка выполнения процедуры [Programmability].[DoClearDeviceReaderLogs] на сервере',               
			@serverName
		);
           
		EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
			@recipients = 'eta.development.dba@yandex.ru',
			@subject = @subject,
			@body = @error
    
		RETURN @@ERROR;  

	END CATCH;

	RETURN 0;
END;

