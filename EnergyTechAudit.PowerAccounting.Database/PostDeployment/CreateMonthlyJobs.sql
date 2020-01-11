-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-08-18
-- Description: Задача ежемесячного обслуживания базы данных
-- ===================================================================================================

DECLARE @monthlyMaintenanceJob NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database.MonthlyMaintenanceJob';
DECLARE @databaseName NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database';


/*Принудительное удаление задачи, если такая существует*/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @monthlyMaintenanceJob)
BEGIN
   EXEC msdb.dbo.sp_delete_job @job_name = @monthlyMaintenanceJob, @delete_unused_schedule=1
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
   SELECT @jobId = job_id from msdb.dbo.sysjobs where (name = @monthlyMaintenanceJob)

   IF (@jobId is NULL)
   BEGIN
      EXEC @ReturnCode =  msdb.dbo.sp_add_job 
          @job_name = @monthlyMaintenanceJob, 
		      @enabled=1, 
		      @notify_level_eventlog=0, 
		      @notify_level_email=3, 
		      @notify_level_netsend=0, 
		      @notify_level_page=0, 
		      @delete_level=0, 
		      @description=N'Ежемесячное обслуживание базы данных EnergyTechAudit.PowerAccounting.Database', 
		      @category_name=N'[Uncategorized (Local)]', 
          @notify_email_operator_name=N'EnergyTechAudit.PowerAccounting.Database.JobOperator',
		      @owner_login_name=N'sa', @job_id = @jobId OUTPUT

      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   END

   /*Удаляем все шаги задачи*/
   EXEC @ReturnCode = msdb.dbo.sp_delete_jobstep 
      @job_name = @monthlyMaintenanceJob, 
      @step_id = 0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /* Добавляем шаг перестроения индексов базы */
   
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
    @job_id=@jobId, 
    @step_name=N'Do rebuild indexes database tables', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC [Programmability].[DoIndexesReorganize]', 
		@database_name=N'EnergyTechAudit.PowerAccounting.Database', 
		@flags=0

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

  /* Добавляем шаг очистки аудита */

  EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Do clear audit', 
		  @step_id=2, 
		  @cmdexec_success_code=0, 
		  @on_success_action=1, 
		  @on_success_step_id=0, 
		  @on_fail_action=2, 
		  @on_fail_step_id=0, 
		  @retry_attempts=0, 
		  @retry_interval=0, 
		  @os_run_priority=0, @subsystem=N'TSQL', 
		  @command=N'EXEC [Programmability].[DoClearAudit]', 
		  @database_name=N'EnergyTechAudit.PowerAccounting.Database', 
		  @flags=0

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Назначаем начальный шаг для задачи*/
   EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Добавляем расписание для задачи */
   EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule 
      @job_name = @monthlyMaintenanceJob,
      @name=N'EnergyTechAudit.PowerAccounting.Database.MonthlyMaintenanceJob.Schedule', 
		  @enabled=1, 
		  @freq_type=32, 
		  @freq_interval=7, 
		  @freq_subday_type=1, 
		  @freq_subday_interval=0, 
		  @freq_relative_interval=1, 
		  @freq_recurrence_factor=1, 
		  @active_start_date=20150818, 
		  @active_end_date=99991231, 
		  @active_start_time=40000, 
		  @active_end_time=235959, 
		  @schedule_uid=N'602908c0-1027-42da-8f86-6787f302102a'

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Таргетирование задачи локальному жоб-серверу*/
   EXEC @ReturnCode = msdb.dbo.sp_add_jobserver 
      @job_name = @monthlyMaintenanceJob,
      @server_name = N'(local)'

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave: