
DECLARE @dataBaseBackupName NVARCHAR(128) = N'EnergyTechAudit.PowerAccounting.Database.Backup';

IF  EXISTS (SELECT name FROM master.dbo.sysdevices WHERE name = @dataBaseBackupName)
BEGIN
   EXEC master.dbo.sp_dropdevice @logicalname = @dataBaseBackupName
END;

IF NOT EXISTS (SELECT name FROM master.dbo.sysdevices WHERE name = @dataBaseBackupName)
BEGIN
   DECLARE @backupPath NVARCHAR(MAX) = 
   (
	   SELECT  [physical_name] FROM [sys].[master_files] [mf]
		   WHERE [mf].[database_id] = DB_ID(N'master') AND [mf].[type_desc] = N'ROWS'
   );

   SET @backupPath = REPLACE(@backupPath, N'master.mdf', '') + @dataBaseBackupName + N'.bak';

   EXEC master.dbo.sp_addumpdevice  
	   @devtype = N'disk', 
	   @logicalname = @dataBaseBackupName, 
	   @physicalname = @backupPath
END;
