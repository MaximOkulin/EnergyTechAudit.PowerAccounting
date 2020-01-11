-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-03
-- Description: Реорганизация индексов таблицы [Business].[Archive]
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[DoIndexesReorganize]   
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

   DECLARE @dataBaseName sysname = N'EnergyTechAudit.PowerAccounting.Database';

   DECLARE @tableName sysname;

   DECLARE @tableSchema sysname;

   DECLARE @tableFullName NVARCHAR(1024);

   DECLARE @averageFragmentation FLOAT = 0;

   DECLARE @infoSchemaTableCursor CURSOR;

   BEGIN TRY

     SET @infoSchemaTableCursor = CURSOR FAST_FORWARD READ_ONLY LOCAL FOR
	     SELECT [T].[TABLE_NAME], [T].[TABLE_SCHEMA]
		     FROM INFORMATION_SCHEMA.TABLES T 
		     WHERE [T].[TABLE_CATALOG] = @dataBaseName;	

     OPEN @infoSchemaTableCursor;

     FETCH NEXT FROM @infoSchemaTableCursor INTO @tableName, @tableSchema;

     WHILE @@FETCH_STATUS = 0 
     BEGIN
	     SET @tableFullName = '[' + @tableSchema + '].[' +  @tableName + ']';

	     SELECT @averageFragmentation = AVG([avg_fragmentation_in_percent])
                 FROM [sys].[dm_db_index_physical_stats]
                    ( 
                       DB_ID(@dataBaseName), 
                       OBJECT_ID(@tableFullName), NULL, NULL, NULL
                    )  [A] 
                    JOIN [sys].[indexes] [B]
                       ON [A].[object_id] = [B].[object_id] AND [A].[index_id] = [B].[index_id]
          

	        IF(@averageFragmentation > 30)
	        BEGIN
	          EXEC ('ALTER INDEX ALL ON ' + @tableFullName + ' REORGANIZE;');	
          
          /*EXEC (
				     'ALTER INDEX ALL ON ' + @tableFullName + ' REBUILD WITH 
				     (
				      ONLINE = ON,
				      FILLFACTOR = 80, 
				      SORT_IN_TEMPDB = ON,
				      STATISTICS_NORECOMPUTE = ON
				     );'
			     );*/
	        END
	        ELSE 
	        BEGIN
		       IF(@averageFragmentation >= 5 AND @averageFragmentation <= 30)
		       BEGIN
			      EXEC ('ALTER INDEX ALL ON ' + @tableFullName + ' REORGANIZE;');			
		       END;
	        END;

	     FETCH NEXT FROM @infoSchemaTableCursor INTO @tableName, @tableSchema;
     END;

     CLOSE @infoSchemaTableCursor;
     DEALLOCATE @infoSchemaTableCursor;

    END TRY

    BEGIN CATCH   
       
      DECLARE @errorNumber INT = ERROR_NUMBER();      
      DECLARE @error NVARCHAR(128) = CONCAT( ERROR_MESSAGE(), ' ', 'Код ошибки: ', @errorNumber);      
      SET @error = CONCAT( @error, CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());
          
      DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;
      DECLARE @subject NVARCHAR(128) = CONCAT
            (
               'Ошибка выполнения процедуры реорганизации индексов [Programmability].[DoIndexesReorganize]  на сервере ',               
               @serverName
            );

      EXEC msdb.dbo.sp_send_dbmail
         @profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
         @recipients = 'eta.development.dba@yandex.ru',
         @subject = @subject,
         @body = @error; 

    END CATCH;

   -- включаем считывателей 
   UPDATE [Admin].[User] SET [IsApproved] = 1
   WHERE [Admin].[User].[Id] IN 
   (
	    SELECT [Id] FROM @activeArchiveDownLoader
   );

   RETURN 0;
END;

