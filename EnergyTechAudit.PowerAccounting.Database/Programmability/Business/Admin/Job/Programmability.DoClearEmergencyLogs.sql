-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20180111
-- Description: The stored procedure clears emergency logs and emergency messages
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoClearEmergencyLogs]	
	-- for more than three months (100 days) for EmergencyLog table
	@emergencyLogDepthRemovalByDay INT = 100, 
	-- for about a month (30 days) for EmergencyMessage table
	@emergencyMessageDepthRemovalByDay INT = 30 
AS
BEGIN  
				
	BEGIN TRANSACTION;
	BEGIN TRY
		SET NOCOUNT ON;	
		
		DECLARE @emergencySituationParameterId INT;
		DECLARE @oldestEmergencyTimeSignatureTime DATETIME;
		DECLARE @highBoundTime DATETIME;

		DECLARE @oldestRecordsCursor CURSOR;

		SET NOCOUNT ON;

		/* 1. EmergencyLog cleaning */
		--  EmergencySituationParameter identifier and the time of the oldest record emergency log for particular [EmergencySituationParameter].[Id]
		
		SET @highBoundTime = DATEADD(DAY, -@emergencyLogDepthRemovalByDay, GETDATE());

		SET @oldestRecordsCursor = CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
			SELECT
				[Emergency].[EmergencySituationParameterId],
				[Emergency].[EmergencyTimeSignatureTime] 
			FROM 
			(
				SELECT 
					ROW_NUMBER() OVER (PARTITION BY [EmergencySituationParameter].[Id] ORDER BY [EmergencyTimeSignature].[Time] ASC) [Num], 
					[EmergencySituationParameter].[Id] [EmergencySituationParameterId],
					[EmergencyTimeSignature].[Time] [EmergencyTimeSignatureTime]
        
					FROM [Business].[EmergencyLog] [EmergencyLog] WITH(NOLOCK)
        
					INNER JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] WITH(NOLOCK)
						ON [EmergencyLog].[EmergencyTimeSignatureId] = [EmergencyTimeSignature].[Id]
    
					INNER JOIN [Business].[EmergencySituationParameter] [EmergencySituationParameter] WITH(NOLOCK)
						ON [EmergencySituationParameter].[Id] = [EmergencyLog].[EmergencySituationParameterId]    
			) [Emergency]

			WHERE [Emergency].[Num] = 1;

		OPEN @oldestRecordsCursor;

		FETCH NEXT FROM @oldestRecordsCursor INTO @emergencySituationParameterId, @oldestEmergencyTimeSignatureTime;
		
		/* It's the "big piece" strategy deleting with a "step by step" approach. */
		WHILE @@FETCH_STATUS = 0 
		BEGIN	
			-- It has a cascading delete action for EmergencyMessage table 
			DELETE /* TOP(@byStepDeep) It's the most effective way. Deadlocks didn't occur at all. */ [EmergencyLog]
			FROM [Business].[EmergencyLog] 

				INNER JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] 
					ON [EmergencyLog].[EmergencyTimeSignatureId] = [EmergencyTimeSignature].[Id]    
				INNER JOIN [Business].[EmergencySituationParameter] [EmergencySituationParameter] 
					ON [EmergencySituationParameter].[Id] = [EmergencyLog].[EmergencySituationParameterId]		
				WHERE 
					([EmergencySituationParameter].[Id] = @emergencySituationParameterId) AND 
					([EmergencyTimeSignature].[Time] BETWEEN @oldestEmergencyTimeSignatureTime AND @highBoundTime)			

			FETCH NEXT FROM @oldestRecordsCursor INTO @emergencySituationParameterId, @oldestEmergencyTimeSignatureTime;
		END;

		CLOSE @oldestRecordsCursor;
		DEALLOCATE @oldestRecordsCursor;
		
		/* Perform to reoganize all indexes [EmergencyLog] table  */
		ALTER INDEX ALL ON [Business].[EmergencyLog] REORGANIZE;
		
		/* 2. EmergencyMessage cleaning (what's left  after a cascading deleting) */
		SET @highBoundTime = DATEADD(DAY, -@emergencyMessageDepthRemovalByDay, GETDATE());
		
		-- "monolithic" removal
		DELETE [EmergencyMessage] FROM [Business].[EmergencyMessage] 
			WHERE [EmergencyMessage].[Time] <= @highBoundTime

		/* Perform to reoganize all indexes [EmergencyMessage] table */
		ALTER INDEX ALL ON [Business].[EmergencyMessage] REORGANIZE;

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
			'Ошибка выполнения процедуры [Programmability].[DoClearEmergencyLogs] на сервере',               
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

