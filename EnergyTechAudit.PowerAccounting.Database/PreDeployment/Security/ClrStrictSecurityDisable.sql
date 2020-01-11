/* Pay attention! This pre-deployment script is needed in order to allow
unsigned CLR assemblies for SQL Server 2017 and above */

EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE WITH OVERRIDE
GO

IF EXISTS(SELECT 1 FROM sys.configurations WHERE name = 'clr strict security')
BEGIN
    EXEC sp_configure 'clr strict security', 0;
    RECONFIGURE;
END;