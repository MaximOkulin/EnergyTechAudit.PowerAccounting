-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2016-12-21
-- Description: Cброс памяти SQL Server
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoMemoryPressure] 
  @minBound FLOAT,
  @maxBound FLOAT,
  @delay VARCHAR(32) = '00:03:00'
AS
BEGIN
  BEGIN TRY    

      DECLARE @maxMemory INT = 
      (
	      SELECT [physical_memory_kb] / 1024 FROM [sys].[dm_os_sys_info]
      );
           
      -- CHECKPOINT;
           
      DECLARE @minMemory  INT;

      SET @minMemory = CAST( (@maxMemory * @minBound) AS INT);

      EXEC sp_configure  'max server memory', @minMemory
        
      RECONFIGURE WITH OVERRIDE;

      WAITFOR DELAY @delay;

      SET @minMemory = CAST( ( @maxMemory * @maxBound ) AS INT);

      EXEC sp_configure  'max server memory', @minMemory

      RECONFIGURE WITH OVERRIDE;
      
      -- DBCC DROPCLEANBUFFERS;
      -- CHECKPOINT;
  END TRY
  BEGIN CATCH

    DECLARE @errorNumber INT = ERROR_NUMBER();      
    DECLARE @error NVARCHAR(256) = CONCAT( ERROR_MESSAGE(), ' ', 'Код ошибки: ', @errorNumber);      
    SET @error = CONCAT( @error, CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());

    DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;

    DECLARE @subject NVARCHAR(256) = CONCAT
    (
        'Ошибка выполнения процедуры опрессовки памяти SQL SERVER на сервере ',               
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