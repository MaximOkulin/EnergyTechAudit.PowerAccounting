-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-11-17
-- Description: Задача ежедневного часового обслуживания базы данных
-- ===================================================================================================

DECLARE @everyDayJob NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database.EveryDayJob';
DECLARE @databaseName NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database';

/* Принудительное удаление задачи, если такая существует */
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @everyDayJob)
BEGIN
   EXEC msdb.dbo.sp_delete_job @job_name = @everyDayJob, @delete_unused_schedule=1
END;

/* Начало транзакции */
BEGIN TRANSACTION
   DECLARE @ReturnCode INT
   SELECT @ReturnCode = 0

   /* Проверка наличия категории для задачи и ее создание если не существует */
   IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
   BEGIN
      EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   END
   
   /* Проверка существования задачи и ее создание */
   DECLARE @jobId BINARY(16)
   SELECT @jobId = job_id from msdb.dbo.sysjobs where (name = @everyDayJob)

   if (@jobId is NULL)
   BEGIN
      EXEC @ReturnCode =  msdb.dbo.sp_add_job 
          @job_name = @everyDayJob, 
		      @enabled=1, 
		      @notify_level_eventlog = 0, 
		      @notify_level_email = 0, 
		      @notify_level_netsend = 0, 
		      @notify_level_page = 0, 
		      @delete_level = 0, 
		      @description = N'Ежедневное почасовое обслуживание и проверки базы данных EnergyTechAudit.PowerAccounting.Database', 
		      @category_name = N'[Uncategorized (Local)]',           
		      @owner_login_name = N'sa', @job_id = @jobId OUTPUT

      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   END

   /* Удаляем все шаги задачи */
   EXEC @ReturnCode = msdb.dbo.sp_delete_jobstep 
      @job_name = @everyDayJob, 
      @step_id = 0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

      
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
        @job_name = @everyDayJob, 
        @step_name = N'Verify missing check constraints', 
		    @step_id = 1, 
		    @cmdexec_success_code = 0, 
		    @on_success_action = 1, 
		    @on_fail_action = 2, 
		    @retry_attempts = 0, 
		    @retry_interval = 0, 
		    @os_run_priority = 0, 
        @subsystem = N'TSQL', 
		    @command = N'EXEC [Programmability].[DoCheckMissingConstraints]', 
		    @database_name = @databaseName, 
		    @flags=0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /* Назначаем начальный шаг для задачи */
   EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /* Добавляем расписание для задачи */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId,
    @name=N'EnergyTechAudit.PowerAccounting.Database.EveryDayJob.Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=4, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150101, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'AEB51480-45F8-4EBB-B371-ECCC4925E464'
    

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /* Таргетирование задачи локальному жоб-серверу */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobserver 
      @job_name = @everyDayJob,
      @server_name = N'(local)'

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave: