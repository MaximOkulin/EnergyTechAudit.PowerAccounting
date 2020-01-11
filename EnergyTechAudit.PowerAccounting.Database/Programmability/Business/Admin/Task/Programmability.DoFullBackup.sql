-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-04
-- Description: Полное резервное копирование
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoFullBackup]
AS
BEGIN
   -- снимок активных считывателей архивов 
   DECLARE @activeArchiveDownLoader TABLE 
   (
    [Id] INT
   );
   
   -- отключение активных считывателей архивов на период времени архивации
   UPDATE [Admin].[User] SET [IsApproved] = 0
	 OUTPUT [Inserted].[Id] INTO @activeArchiveDownLoader
   WHERE [RoleId] = 3 AND [IsApproved] = 1;
       
   BEGIN TRY
      BACKUP DATABASE [EnergyTechAudit.PowerAccounting.Database]
      TO [EnergyTechAudit.PowerAccounting.Database.Backup]
      WITH    
         FORMAT, 
         COMPRESSION         
   END TRY 
   BEGIN CATCH

      DECLARE @errorNumber INT = ERROR_NUMBER();      
      DECLARE @error NVARCHAR(128) = CONCAT( ERROR_MESSAGE(), ' ', 'Код ошибки: ', @errorNumber);      
      SET @error = CONCAT( @error, CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());

      DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;   
      DECLARE @subject NVARCHAR(128) = CONCAT
      (
          'Ошибка выполнения полного резервного копирования [Programmability].[DoFullBackup] на сервере ',               
          @serverName
      );

      EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
         @recipients = 'eta.development.dba@yandex.ru',
         @subject = @subject,
         @body = @error
   END CATCH

   -- включаем считывателей 
   UPDATE [Admin].[User] SET [IsApproved] = 1
   WHERE [Admin].[User].[Id] IN 
   (
	    SELECT [Id] FROM @activeArchiveDownLoader
   );
      
   RETURN 0;
END;