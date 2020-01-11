CREATE PROCEDURE [Programmability].[DoClearStatusConnectionLog]
AS
BEGIN  

  SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

  BEGIN TRANSACTION;
  BEGIN TRY

    SET NOCOUNT ON;
        
    DECLARE @queryBase NVARCHAR(MAX) =

     'DELETE [SLog] FROM [Business].[{CONNECTED_DEVICE}StatusConnectionLog] [SLog] 
      WHERE [SLog].[Id] IN
      (  
	      SELECT [Id]    
		        FROM 
		        (
			      SELECT
				        [SCL1].[Id],
				        ROW_NUMBER() OVER(PARTITION BY [SCL1].[{CONNECTED_DEVICE}Id] ORDER BY [SCL1].[ConnectionTime] DESC) [Num],
				        [SCL1].[ConnectionTime] [Time], 
				        [SCL1].[StatusConnectionId] [StatusConnectionId], 
				        [SCL1].[{CONNECTED_DEVICE}Id] [{CONNECTED_DEVICE}Id]           
				      FROM [Business].[{CONNECTED_DEVICE}StatusConnectionLog] [SCL1]     
		        ) [SCL2] 
		      WHERE [SCL2].[Num] > 30
      );';

      DECLARE @statusConnectionLogQuery NVARCHAR(MAX);

      SET @statusConnectionLogQuery = REPLACE (@queryBase, N'{CONNECTED_DEVICE}', N'MeasurementDevice');
      EXEC sp_executesql @statusConnectionLogQuery;

      SET @statusConnectionLogQuery  = REPLACE (@queryBase, N'{CONNECTED_DEVICE}', N'AccessPoint');
      EXEC sp_executesql @statusConnectionLogQuery;
          
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
    DECLARE @error NVARCHAR(128) = CONCAT( ERROR_MESSAGE(), ' ', 'Код ошибки: ', @errorNumber);      
    SET @error = CONCAT( @error, CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());

    DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;

    DECLARE @subject NVARCHAR(256) = CONCAT
    (
        'Ошибка очистки лога статусов соединений устройств в процедуре [Programmability].[DoClearStatusConnectionLog] на сервере ',               
        @serverName
    );
     
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
        @recipients = 'eta.development.dba@yandex.ru',
        @subject = @subject,
        @body = @error
    
    RETURN @@ERROR;  

  END CATCH;

  ALTER INDEX ALL ON [Business].[MeasurementDeviceStatusConnectionLog]
        REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);

  ALTER INDEX ALL ON [Business].[AccessPointStatusConnectionLog]
        REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);

  RETURN 0;
END;

