-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20160815
-- Description: Возвращает XML-ответ с расписанием назначеным для пользователя
-- ===================================================================================================

CREATE PROCEDURE WebApi.GetScheduleInfo
(
  @userName NVARCHAR(64),
  @actionUid UNIQUEIDENTIFIER OUTPUT
)	
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @dateTime DATETIME = GETDATE();
   DECLARE @uid UNIQUEIDENTIFIER = NEWID();
   DECLARE @methodName VARCHAR(64) = 'ScheduleInfo';
   DECLARE @error NVARCHAR(128); 

   SET @actionUid = @uid;

   BEGIN TRY	    	
    SELECT       
      @dateTime [DateTime], 
      @uid [Uid],
      @methodName [MethodName],
      (
        SELECT      
        (
          SELECT [ScheduleItem].[Id] ,
                 [ScheduleItem].[Description] ,
                 [ScheduleItem].[Enabled] ,               
                 (
                    SELECT [ScheduleType].[Id] ,
                           [ScheduleType].[Code] ,
                           [ScheduleType].[Description]
                    FROM [Dictionaries].[ScheduleType] [ScheduleType] WITH (NOLOCK)
                    WHERE [ScheduleType].[Id] = [ScheduleItem].[ScheduleTypeId]
                    FOR XML AUTO, ELEMENTS, TYPE
                 ),
                 [ScheduleItem].[PeriodBegin],
                 [ScheduleItem].[PeriodEnd],
                 [ScheduleItem].[OrdinalNumberOfDay]
                 FROM [Core].[ScheduleItem] [ScheduleItem] WITH (NOLOCK)
        
          INNER JOIN [WebApi].[ArchiveDownloaderLinkScheduleItem] [ArchiveDownloaderLinkScheduleItem] WITH (NOLOCK)
            ON [ArchiveDownloaderLinkScheduleItem].[ScheduleItemId] = [ScheduleItem].[Id]

          INNER JOIN [Admin].[User] [User] WITH(NOLOCK) 
            ON [User].[Id] = [ArchiveDownloaderLinkScheduleItem].[ArchiveDownloaderId] 

          WHERE [User].[UserName] = @userName
          FOR XML AUTO, ELEMENTS, TYPE, ROOT('ScheduleItems')
        )
        FOR XML PATH('Core'), ELEMENTS, TYPE
      )
	  FOR XML PATH('Package')
  END TRY
  BEGIN CATCH
	  SET @error = 'Внутренняя ошибка выполнения запроса. ' + ERROR_MESSAGE();
      SELECT 
         @dateTime [DateTime],
         @uid [Uid], 
         @methodName [MethodName],      
         @error [Message]             
      FOR XML PATH('Error'), ELEMENTS, TYPE;  
  END CATCH
END;
GO