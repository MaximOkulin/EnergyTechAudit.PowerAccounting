-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-04
-- Description: Задача ежедневного обслуживания базы данных
-- ===================================================================================================

DECLARE @dailyMaintenanceJob NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database.DailyMaintenanceJob';
DECLARE @databaseName NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database';


/*Принудительное удаление задачи, если такая существует*/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @dailyMaintenanceJob)
BEGIN
   EXEC msdb.dbo.sp_delete_job @job_name = @dailyMaintenanceJob, @delete_unused_schedule=1
END;

/*Начало транзакции*/
BEGIN TRANSACTION
   DECLARE @ReturnCode INT
   SELECT @ReturnCode = 0

   /*Проверка наличия категории для задачи и ее создание если не существует*/
   IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
   BEGIN
      EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   END


   /*Проверка существования задачи и ее создание*/
   DECLARE @jobId BINARY(16)
   SELECT @jobId = job_id from msdb.dbo.sysjobs where (name = @dailyMaintenanceJob)

   if (@jobId is NULL)
   BEGIN
      EXEC @ReturnCode =  msdb.dbo.sp_add_job 
            @job_name = @dailyMaintenanceJob, 
		      @enabled=1, 
		      @notify_level_eventlog=0, 
		      @notify_level_email=3, 
		      @notify_level_netsend=0, 
		      @notify_level_page=0, 
		      @delete_level=0, 
		      @description=N'Ежедневное обслуживание базы данных EnergyTechAudit.PowerAccounting.Database', 
		      @category_name=N'[Uncategorized (Local)]', 
          @notify_email_operator_name=N'EnergyTechAudit.PowerAccounting.Database.JobOperator',
		      @owner_login_name=N'sa', @job_id = @jobId OUTPUT

      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   END

   /*Удаляем все шаги задачи*/
   EXEC @ReturnCode = msdb.dbo.sp_delete_jobstep 
      @job_name = @dailyMaintenanceJob, 
      @step_id = 0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   
   /* 1. Чистка логов  девайс ридеров */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
        @job_name = @dailyMaintenanceJob,  
        @step_name = N'Clear device readers logs', 
		    @step_id = 1, 
		    @cmdexec_success_code = 0, 
		    @on_success_action = 3, 
		    @on_success_step_id = 0, 
		    @on_fail_action = 3, 
		    @on_fail_step_id = 0, 
		    @retry_attempts = 0, 
		    @retry_interval = 0, 
		    @os_run_priority = 0, 
			@subsystem = N'TSQL', 
		    @command = N'EXEC [Programmability].[DoClearDeviceReaderLogs] @deviceEventSaveDeepInHours = 36, @deviceReaderErrorLogSaveDeepInDays = 30', 
		    @database_name = @databaseName, 
		    @flags = 0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback


   /* 2. Ежедневный сброс утилизированной сервером памяти */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
        @job_name = @dailyMaintenanceJob,  
        @step_name = N'Memory pressure', 
		    @step_id = 2, 
		    @cmdexec_success_code = 0, 
		    @on_success_action = 3, 
		    @on_success_step_id = 0, 
		    @on_fail_action = 3, 
		    @on_fail_step_id = 0, 
		    @retry_attempts = 0, 
		    @retry_interval = 0, 
		    @os_run_priority = 0, 
			@subsystem = N'TSQL', 
		    @command = N'EXEC [Programmability].[DoMemoryPressure] @minBound = 0.5, @maxBound = 0.75', 
		    @database_name = @databaseName, 
		    @flags = 0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /* 3. Добавляем шаг очистки логов нештатных ситуаций */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
         @job_name = @dailyMaintenanceJob, 
         @step_name=N'Clear emergency logs and messages', 
		     @step_id=3, 
		     @cmdexec_success_code=0, 
		     @on_success_action=3, 
		     @on_fail_action=3, 
		     @retry_attempts=0, 
		     @retry_interval=0, 
		     @os_run_priority=0, 
			 @subsystem=N'TSQL', 
		     @command=N'EXEC [Programmability].[DoClearEmergencyLogs]', 
		     @database_name = @databaseName, 
		     @flags=0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /* 3. Добавляем шаг очистки логов нештатных ситуаций */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
         @job_name = @dailyMaintenanceJob, 
         @step_name= N'Clear emergency time signatures', 
		     @step_id=4, 
		     @cmdexec_success_code=0, 
		     @on_success_action=3, 
		     @on_fail_action=3, 
		     @retry_attempts=0, 
		     @retry_interval=0, 
		     @os_run_priority=0, 
			 @subsystem=N'TSQL', 
		     @command=N'EXEC [Programmability].[DoClearEmergencyTimeSignatures]', 
		     @database_name = @databaseName, 
		     @flags=0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
       
   /* 4. Добавляем шаг дифференциального резевного копирования базы данных */  
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
         @job_name = @dailyMaintenanceJob, 
         @step_name=N'Differential Backup Maintaince', 
		     @step_id=5, 
		     @cmdexec_success_code=0, 
		     @on_success_action=1, 
		     @on_fail_action=2, 
		     @retry_attempts=0, 
		     @retry_interval=0, 
		     @os_run_priority=0, @subsystem=N'TSQL', 
		     @command=N'EXEC [Programmability].[DoDifferentialBackup]', 
		     @database_name = @databaseName, 
		     @flags=0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Назначаем начальный шаг для задачи*/
   EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Добавляем расписание для задачи */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule 
         @job_name = @dailyMaintenanceJob,
         @name=N'EnergyTechAudit.PowerAccounting.Database.DailyMaintenanceJob.Schedule', 
		   @enabled=1, 
		   @freq_type=4, 
		   @freq_interval=1, 
		   @freq_subday_type=1, 
		   @freq_subday_interval=0, 
		   @freq_relative_interval=0, 
		   @freq_recurrence_factor=0, 
		   @active_start_date=20150101, 
		   @active_end_date=99991231, 
		   @active_start_time=0, 
		   @active_end_time=235959, 
		   @schedule_uid=N'ae20c1d3-1216-4ae0-ba5c-dd6a8c7319a1'

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Таргетирование задачи локальному жоб-серверу*/
   EXEC @ReturnCode = msdb.dbo.sp_add_jobserver 
      @job_name = @dailyMaintenanceJob,
      @server_name = N'(local)'

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave: