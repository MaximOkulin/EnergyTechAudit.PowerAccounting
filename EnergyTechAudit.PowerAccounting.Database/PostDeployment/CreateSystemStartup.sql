-- This script makes and assigns a stored procedure 
-- that will be execute immediately after restart SQL Server.
 
USE [master];
GO

IF(OBJECT_ID('[master].[dbo].[sp_etasysstartup]') IS NOT NULL)
BEGIN
	DROP PROCEDURE [dbo].[sp_etasysstartup];	
END;
GO

CREATE PROCEDURE [dbo].[sp_etasysstartup] 	
AS
BEGIN	
	SET NOCOUNT ON;

	DECLARE @renewTempDbMembershipsStatement NVARCHAR(MAX) = 
	N'
		USE [tempdb];
		ALTER ROLE [db_ddladmin] ADD MEMBER [guest];
		ALTER ROLE [db_owner] ADD MEMBER [guest];
		ALTER ROLE [db_securityadmin] ADD MEMBER [guest];
	';

	EXEC [sys].[sp_executesql] @renewTempDbMembershipsStatement;

	-- Will do more here, if you need, but you must do very carefully!
END;
GO

EXEC master.[sys].[sp_procoption] N'[dbo].[sp_etasysstartup]', 'startup', '1'