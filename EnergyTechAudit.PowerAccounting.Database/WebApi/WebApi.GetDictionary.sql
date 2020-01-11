-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20141123
-- Description: Конвертор словаря в XML
-- ===================================================================================================

CREATE PROCEDURE WebApi.GetDictionary 
(
  @userName NVARCHAR(64),
	@name NVARCHAR(128),
  @actionUid UNIQUEIDENTIFIER OUTPUT
)
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @dateTime DATETIME = GETDATE();
   DECLARE @uid UNIQUEIDENTIFIER = NEWID();
   DECLARE @methodName VARCHAR(64) = 'Dictionary';
   DECLARE @error NVARCHAR(128); 
   
   SET @actionUid = @uid;

   DECLARE @query NVARCHAR(MAX) = 

    'SELECT  @dateTime [DateTime], @uid [Uid], @methodName [MethodName],
    (
	    SELECT (
	    SELECT @name AS ''@name'',
	    (   
		    SELECT [Id], [Code], [Description] FROM [Dictionaries].[' + @name +'] [' + @name + '] WITH(NOLOCK)
		    FOR XML AUTO, ELEMENTS, TYPE		    	 	 	
	    ) FOR XML PATH(''Dictionary''), ELEMENTS, TYPE
	    ) FOR XML PATH(''Dictionaries''), ELEMENTS, TYPE
    ) FOR XML PATH(''Package'')';

   BEGIN TRY	
	   
     EXEC [sys].[sp_executesql] @query, 
      N'@dateTime DATETIME, @uid UNIQUEIDENTIFIER, @name VARCHAR(128), @methodName  VARCHAR(64)',  
      @dateTime = @dateTime, 
      @uid = @uid,
      @name = @name, 
      @methodName = @methodName;

   END TRY
   BEGIN CATCH
	   SET @error = 'Внутренняя ошибка выполнения запроса. ' + ERROR_MESSAGE();
      SELECT 
         @dateTime [DateTime], 
         @uid [Uid],
         @methodName [MethodName],      
         @error [Message]             
      FOR XML PATH('Error'), ELEMENTS, TYPE;  
   END CATCH;
END;
GO