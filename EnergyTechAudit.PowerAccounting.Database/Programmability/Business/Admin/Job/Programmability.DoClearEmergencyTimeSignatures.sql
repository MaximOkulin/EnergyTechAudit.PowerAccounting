-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20190628
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoClearEmergencyTimeSignatures]		
AS
BEGIN  
				
	BEGIN TRANSACTION;
	BEGIN TRY
		SET NOCOUNT ON;	
		
        /* Be courage ! One shot is one corpse! */
        DELETE  [EmergencyTimeSignature] FROM [Business].[EmergencyTimeSignature]
          LEFT JOIN [Business].[EmergencyLog] [EmergencyLog] ON [EmergencyTimeSignature].[Id] = [EmergencyLog].[EmergencyTimeSignatureId]
        WHERE [EmergencyLog].[Id] IS NULL
		
		ALTER INDEX ALL ON [Business].[EmergencyTimeSignature] REORGANIZE;
		
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
			'Ошибка выполнения процедуры [Programmability].[[DoClearEmergencyTimeSignatures]] на сервере',               
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

