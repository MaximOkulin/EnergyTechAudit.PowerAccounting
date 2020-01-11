-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-04-14
-- Description: Задача ежечасное обслуживания базы данных
-- ===================================================================================================

DECLARE @hourlyMaintenanceJob NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database.HourlyMaintenanceJob';
DECLARE @databaseName NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database';


/*Принудительное удаление задачи, если такая существует*/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = @hourlyMaintenanceJob)
BEGIN
   EXEC msdb.dbo.sp_delete_job @job_name = @hourlyMaintenanceJob, @delete_unused_schedule=1
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
   SELECT @jobId = job_id from msdb.dbo.sysjobs WHERE (name = @hourlyMaintenanceJob)

   if (@jobId is NULL)
   BEGIN
      EXEC @ReturnCode =  msdb.dbo.sp_add_job 
          @job_name = @hourlyMaintenanceJob, 
		      @enabled=1, 
		      @notify_level_eventlog=0, 
		      @notify_level_email=0, 
		      @notify_level_netsend=0, 
		      @notify_level_page=0, 
		      @delete_level=0, 
		      @description=N'Ежечасное обслуживание базы данных EnergyTechAudit.PowerAccounting.Database', 
		      @category_name=N'[Uncategorized (Local)]', 
          -- @notify_email_operator_name=N'EnergyTechAudit.PowerAccounting.Database.JobOperator',
		      @owner_login_name=N'sa', @job_id = @jobId OUTPUT

      IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   END

   /*Удаляем все шаги задачи*/
   EXEC @ReturnCode = msdb.dbo.sp_delete_jobstep 
      @job_name = @hourlyMaintenanceJob, 
      @step_id = 0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Добавляем три шага (очистка стутусов соединений, перестроение индекса, резевное копирование базы данных) */
   
   EXEC @ReturnCode = msdb.dbo.sp_add_jobstep 
         @job_name = @hourlyMaintenanceJob, 
         @step_name=N'Clear StatusConnectionLog Maintaince', 
		   @step_id=1, 
		   @cmdexec_success_code=0, 
		   @on_success_action=1, 
		   @on_fail_action=2, 
		   @retry_attempts=0, 
		   @retry_interval=0, 
		   @os_run_priority=0, @subsystem = N'TSQL', 
		   @command=N'EXEC [Programmability].[DoClearStatusConnectionLog]', 
		   @database_name = @databaseName, 
		   @flags=0

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
   
   /*Назначаем начальный шаг для задачи*/
   EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

   /*Добавляем расписание для задачи */
   EXEC msdb.dbo.sp_add_jobschedule  
    @job_name = @hourlyMaintenanceJob, 
    @name=N'EnergyTechAudit.PowerAccounting.Database.HourlyMaintenanceJob.Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20150414, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, @schedule_uid=N'1e2011d3-1216-4ae0-ba5c-dd2a1c7319a1'

   
   /*Таргетирование задачи локальному жоб-серверу*/
   EXEC @ReturnCode = msdb.dbo.sp_add_jobserver 
      @job_name = @hourlyMaintenanceJob,
      @server_name = N'(local)'

   IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave: