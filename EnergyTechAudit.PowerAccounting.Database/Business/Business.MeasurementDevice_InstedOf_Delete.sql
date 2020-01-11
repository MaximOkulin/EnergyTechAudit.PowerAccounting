CREATE TRIGGER [Business].[MeasurementDevice_InstedOf_Delete]
ON [Business].[MeasurementDevice]

INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT OFF;
    DECLARE @DeletedRows INT = 1;

  BEGIN TRY      
      /* [Archive] */
      SET @DeletedRows = 1;
      WHILE(@DeletedRows > 0)
      BEGIN

        DELETE TOP (5000) [Archive] 
          FROM [Business].[Archive] [Archive] 
          WHERE [Archive].[MeasurementDeviceId] IN
          (
            SELECT [Id] FROM [Deleted]
          );
          SET @DeletedRows = @@ROWCOUNT;
      END;
    
      /* [TimeSignature] */
      SET @DeletedRows = 1;
      WHILE(@DeletedRows > 0)
      BEGIN

        DELETE TOP (5000) [TimeSignature] 
          FROM [Business].[TimeSignature] [TimeSignature] 
          WHERE [TimeSignature].[MeasurementDeviceId] IN
          (
            SELECT [Id] FROM [Deleted]
          );

          SET @DeletedRows = @@ROWCOUNT;
      END;

      /* [DeviceReaderErrorLog] */
      SET @DeletedRows = 1;
      WHILE(@DeletedRows > 0)
      BEGIN

        DELETE TOP (5000) [DeviceReaderErrorLog] 
          FROM [Business].[DeviceReaderErrorLog]
          WHERE ISNULL([DeviceReaderErrorLog].[MeasurementDeviceId], 0) IN
          (
            SELECT [Id] FROM [Deleted]
          );
          SET @DeletedRows = @@ROWCOUNT;
      END;

      /* [DeviceEvent] */
      SET @DeletedRows = 1;
      WHILE(@DeletedRows > 0)
      BEGIN
        DELETE TOP (5000) [DeviceEvent]
          FROM [Business].[DeviceEvent]
          WHERE [DeviceEvent].[MeasurementDeviceId] IN 
          (
            SELECT [Deleted].[Id] FROM [Deleted]
          );

          SET @DeletedRows = @@ROWCOUNT;
      END;

      /* Каскадно удаляем остатки потрохов по [MeasurementDevice] */
      
      DELETE [MeasurementDevice] 
        FROM [Business].[MeasurementDevice] [MeasurementDevice]
        WHERE [MeasurementDevice].[Id] 
        IN 
        (
          SELECT [Deleted].[Id] FROM [Deleted]
        );
  END TRY

  BEGIN CATCH
    DECLARE @error NVARCHAR(MAX) = ERROR_MESSAGE();
    DECLARE @serverName  NVARCHAR(128) = @@SERVERNAME;

    DECLARE @subject NVARCHAR(128) = CONCAT
    (
        'Ошибка триггера  [MeasurementDevice_InstedOf_Delete] при удалении сущности [MeasurementDevice]',               
        @serverName
    );

    SET @error = CONCAT( @error, CHAR(13), 'Время возникновения ошибки на сервере: ', GETDATE());
     
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'EnergyTechAudit.PowerAccounting.Database.MailProfile',
        @recipients = 'eta.development.dba@yandex.ru',
        @subject = @subject,
        @body = @error
      ;
      SET NOCOUNT ON;
    THROW;
  END CATCH;
  
  SET NOCOUNT ON;
END
