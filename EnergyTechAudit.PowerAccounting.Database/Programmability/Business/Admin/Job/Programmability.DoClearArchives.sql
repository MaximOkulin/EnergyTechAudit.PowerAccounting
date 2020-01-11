-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20170605
-- Description: 
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoClearArchives]	
AS
BEGIN  
	BEGIN TRY      

		DECLARE @safeBoundTime DATETIME; 
	
		DECLARE @safeBoundDaysCount INT = 730, @singleStepProceedingRowCount INT = 500;
	
		SET @safeBoundTime = DATEADD(DAY, -@safeBoundDaysCount,  GETDATE());

		DECLARE @measurementDeviceId INT;
		DECLARE @oldestIdTimeSignature INT;
		DECLARE @oldestTimeSignatureTime DATETIME;

		-- для обеспечения атомарности используем курсор
		DECLARE measurementDeviceCursor CURSOR FORWARD_ONLY READ_ONLY FAST_FORWARD	
		FOR
			SELECT [MeasurementDevice].[Id] 
			FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK);

		OPEN measurementDeviceCursor;
	
		FETCH NEXT FROM measurementDeviceCursor INTO @measurementDeviceId;

		WHILE @@FETCH_STATUS = 0  
		BEGIN 
			SELECT TOP(1)
				@oldestIdTimeSignature = [TimeSignature].[Id], 
				@oldestTimeSignatureTime = FIRST_VALUE (  [TimeSignature].[Time] ) OVER (ORDER BY [TimeSignature].[Time])  
			FROM [Business].[TimeSignature] [TimeSignature] WITH(NOLOCK) 
			WHERE [TimeSignature].[MeasurementDeviceId] = @measurementDeviceId;

			-- Very slow execution
			/*				
			DELETE TOP(@singleStepProceedingRowCount) [Archive]
			FROM [Business].[Archive] [Archive] 
			WHERE [Archive].[MeasurementDeviceId] = @measurementDeviceId AND  [Archive].[TimeSignatureId] IN
			(
				SELECT [Id]
				FROM [Business].[TimeSignature] [TimeSignature] WITH(NOLOCK)
				WHERE [TimeSignature].[MeasurementDeviceId] = @measurementDeviceId AND 
				([TimeSignature].[Time] >= @oldestTimeSignatureTime AND [TimeSignature].[Time] <= @safeBoundTime)
			)
			*/
			FETCH NEXT FROM measurementDeviceCursor INTO @measurementDeviceId;			
			-- PRINT @measurementDeviceId;
		END;

		CLOSE measurementDeviceCursor;  
		DEALLOCATE measurementDeviceCursor; 
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
			'Ошибка выполнения процедуры [Programmability].[DoClearArchives] на сервере',               
			@serverName
		);
           
		EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
			@recipients = 'eta.development.dba@yandex.ru',
			@subject = @subject,
			@body = @error
    
		RETURN @@ERROR;  

	END CATCH;
END;