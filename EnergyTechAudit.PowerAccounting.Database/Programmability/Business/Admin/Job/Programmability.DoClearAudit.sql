-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-09-03
-- Description: Очистка аудита системы [Admin].[Audit]
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoClearAudit]
AS
BEGIN  

  SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

  BEGIN TRANSACTION;
  BEGIN TRY
    SET NOCOUNT ON;
    
    DELETE [Audit] FROM [Admin].[Audit] [Audit]
          
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

    DECLARE @subject NVARCHAR(256) = CONCAT
    (
        'Ошибка очистки аудита в процедуре [Programmability].[DoClearAudit] на сервере',               
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

