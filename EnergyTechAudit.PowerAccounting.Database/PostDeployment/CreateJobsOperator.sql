-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-04
-- Description: Создание оператора жобов 
-- ===================================================================================================

/* Разрешаем SQL Server Agent отсылать почту */

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, 
		@databasemail_profile=N'EnergyTechAudit.PowerAccounting.Database.MailProfile', 
		@use_databasemail=1

/**/

/* Создание оператора задач */
IF  EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'EnergyTechAudit.PowerAccounting.Database.JobOperator')
BEGIN
   EXEC msdb.dbo.sp_delete_operator @name=N'EnergyTechAudit.PowerAccounting.Database.JobOperator'
END

EXEC msdb.dbo.sp_add_operator 
       @name=N'EnergyTechAudit.PowerAccounting.Database.JobOperator', 
		   @enabled=1, 
		   @weekday_pager_start_time = 0, 
		   @weekday_pager_end_time = 235959, 
		   @saturday_pager_start_time = 0, 
		   @saturday_pager_end_time = 235959, 
		   @sunday_pager_start_time = 0, 
		   @sunday_pager_end_time = 235959, 
		   @pager_days = 127, 
		   @email_address = N'eta.development.dba@yandex.ru', 
		   @category_name = N'[Uncategorized]'

