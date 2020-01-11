-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-13
-- Description: Разрешение почтовых уведомлений при выполнении задач обслуживания БД   
-- ===================================================================================================

/*Имя профиля DatabaseMail*/
DECLARE @profile_name sysname = 'EnergyTechAudit.PowerAccounting.Database.MailProfile';

/*Настройки почтовой учетной записи */
DECLARE @account_name sysname = 'EnergyTechAudit.PowerAccounting.Database.JobMailAccount';
DECLARE @SMTP_servername sysname = 'smtp.yandex.ru';
DECLARE @email_address NVARCHAR(128) = 'eta.development.dbserver@yandex.ru'; 
DECLARE @display_name NVARCHAR(128) = 'EnergyTechAudit.PowerAccounting.Database.JobMailAccount';

DECLARE @result INT;

/* Удаление существующей учетки DatabaseMail*/
IF EXISTS (SELECT * FROM msdb.dbo.sysmail_account WHERE name = @account_name )
BEGIN
   -- удалим привязку учетки к профилю
   EXECUTE @result = msdb.dbo.sysmail_delete_profileaccount_sp
		@profile_name = @profile_name,
		@account_name = @account_name;	
   -- удалим учетку
	EXECUTE @result = msdb.dbo.sysmail_delete_account_sp
		@account_name = @account_name;
END;

/* Удаление существующего профиля DatabaseMail */
IF EXISTS (SELECT * FROM msdb.dbo.sysmail_profile WHERE name = @profile_name)
BEGIN
  EXECUTE @result = msdb.dbo.sysmail_delete_profile_sp
    @profile_name = @profile_name ;
END;

IF @result <> 0
   BEGIN
       RAISERROR('Ошибка удаления существующих объектов Database Mail', 16, 1);	    
       GOTO QuitWithRoolback;
   END;

/*Транзакционная цепочка создания объектов почты*/
BEGIN TRANSACTION ;

   /* Добавление учетной записи почты */
   EXECUTE @result = msdb.dbo.sysmail_add_account_sp
       @account_name = @account_name,
       @email_address = @email_address,
       @display_name = @display_name,
       @mailserver_name = @SMTP_servername,
       @port = 587,
       @username =  'eta.development.dbserver@yandex.ru', 
       @password = 'gh8nc3pe4',
       @enable_ssl = 1;

   IF @result <> 0
   BEGIN
       RAISERROR('Ошибка создания учетной записи профиля Database Mail', 16, 1) ;	    
       GOTO QuitWithRoolback;
   END

   /* Добавление профиля DatabaseMail */
   EXECUTE @result = msdb.dbo.sysmail_add_profile_sp
       @profile_name = @profile_name ;

   IF @result <> 0
   BEGIN
       RAISERROR('Ошибка создания профиля Database Mail', 16, 1);	    
       GOTO QuitWithRoolback;
   END;

   /* Профиль DatabaseMail как публичный*/
   EXECUTE @result = msdb.dbo.sysmail_add_principalprofile_sp
       @profile_name = @profile_name,
       @principal_name = 'public',
       @is_default = 1 ;

   IF @result <> 0
   BEGIN
       RAISERROR('Ошибка назначения публичного принципала', 16, 1);	    
       GOTO QuitWithRoolback;
   END;

   /* Ассоциация учетной записи почты с почтовым профилем */
   EXECUTE @result = msdb.dbo.sysmail_add_profileaccount_sp
       @profile_name = @profile_name,
       @account_name = @account_name,
       @sequence_number = 1 ;

   IF @result <> 0
   BEGIN
       RAISERROR('Ошибка ассоциации профиля с учетной записи Database Mail).', 16, 1) ;	    
       GOTO QuitWithRoolback;
   END;

   COMMIT TRANSACTION;

GOTO EndSave;

QuitWithRoolback:
   IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
EndSave:
