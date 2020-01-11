-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-20-05
-- Update date 2015-08-18
-- Description: Дифференциальное резервное копирование
-- ===================================================================================================

CREATE PROCEDURE Programmability.DoDifferentialBackup
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
         DIFFERENTIAL, 
         COMPRESSION;   

   END TRY 
   BEGIN CATCH

      DECLARE @errorNumber INT = ERROR_NUMBER();      
      DECLARE @error NVARCHAR(MAX) = CONCAT( ERROR_MESSAGE(), ' ', 'Код ошибки: ', @errorNumber);    
	    
      SET @error = CONCAT( @error, CHAR(10), CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());
          
      DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;
      DECLARE @subject NVARCHAR(128) = CONCAT
            (
               'Ошибка выполнения дифференциального резервного копирования [Programmability].[DoDifferentialBackup] на сервере ',               
               @serverName
            );

	  /* Уточняем, что ошибка связана с отсутствием медиасета полной резервной копии */
	  IF (@errorNumber = 3013)
      BEGIN      		
			SET @error = CONCAT (@error, CHAR(10), CHAR(13), CHAR(10), CHAR(13), 
				'В устройстве резервного копирования отсутствет медиасет полной резервной копии!',
				'Дифференциальное копирование невозможно и будет запущена попытка формирования полной резервной копии.' )		
	  END;	

      EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
         @recipients = 'eta.development.dba@yandex.ru',
         @subject = @subject,
         @body = @error; 

      /* Если отсутствует полная резервная копия или поврежден медиасет устройства резервного копирования */      
      IF (@errorNumber = 3013)
      BEGIN      		
        -- включаем считывателей 
        UPDATE [Admin].[User] SET [IsApproved] = 1
        WHERE [Admin].[User].[Id] IN 
        (
	         SELECT [Id] FROM @activeArchiveDownLoader
        );

        EXEC [Programmability].[DoFullBackup];

        RETURN 0;
      END;	

   END CATCH
   
   -- включаем считывателей 
   UPDATE [Admin].[User] SET [IsApproved] = 1
   WHERE [Admin].[User].[Id] IN 
   (
	    SELECT [Id] FROM @activeArchiveDownLoader
   );
   RETURN 0;
END;
GO