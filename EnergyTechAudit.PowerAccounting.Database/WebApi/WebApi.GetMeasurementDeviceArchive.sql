-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2014-11-21
-- Updated date 2015-09-09
-- Description: Конвертор архива в XML
-- ===================================================================================================

CREATE PROCEDURE WebApi.GetMeasurementDeviceArchive 
(
    @userName NVARCHAR(64),
    @measurementDeviceId INT,
	  @periodBegin DATETIME,		-- начальная дата архива 
	  @periodEnd DATETIME,			-- конечная дата архива 
    @includePeriodEnd BIT = 1,  
    @periodTypeId INT,	
	  @withDictionaries BIT = NULL,	-- включать словари 	
    @channelId INT = 0,
    @actionUid UNIQUEIDENTIFIER OUTPUT
)	
AS
BEGIN
   SET NOCOUNT ON;
   SET XACT_ABORT ON;
   
   DECLARE @dateTime DATETIME = GETDATE();
   DECLARE @uid UNIQUEIDENTIFIER = NEWID();  
   DECLARE @methodName VARCHAR(64) = 'MeasurementDeviceArchive';
   DECLARE @error NVARCHAR(256); 
      
   SET @actionUid = @uid;

   BEGIN TRY

     SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
     BEGIN TRANSACTION;             
    
    /* Проверка принадлежности кананала и/или существования устройства */
    IF NOT EXISTS
    (
      -- по ссылкам пользователя на отдельный канал 
      SELECT 1 FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
        INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
          ON [Channel].[Id] = [UserLinkChannel].[ChannelId] 
            AND [Channel].[MeasurementDeviceId] = @measurementDeviceId
        INNER JOIN [Admin].[User] [User] WITH(NOLOCK)
          ON [UserLinkChannel].[UserId] = [User].[Id]
      WHERE [User].[UserName] = @userName

      UNION ALL

      -- по назначеной ресурсоснабжающей организации для канала 
      -- и связи оператора выгрузки с ресурсоснабжающей организацией
      SELECT 1 FROM [WebApi].[ArchiveDownloader] [ArchiveDownloader] WITH(NOLOCK)  
        INNER JOIN [Admin].[User] [User] WITH(NOLOCK)
          ON [User].[Id] = [ArchiveDownloader].[Id]
        INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
          ON [Channel].[OrganizationId] = [ArchiveDownloader].[OrganizationId] 
            AND [Channel].[MeasurementDeviceId] = @measurementDeviceId
      WHERE [User].[UserName] = @userName
    )
    BEGIN
  	    SET @error = N'Нет доступа к устройству или устройство не существует. Обратитесь к администратору системы для определения доступа уровня канала.';
              SELECT
                @dateTime [DateTime], 
                @uid [Uid],
                @methodName [MethodName],      
                @error [Message],
                (
                  SELECT @measurementDeviceId [MeasurementDeviceId]
                  FOR XML PATH('AdditionalInfo'), ELEMENTS, TYPE
                )
                FOR XML PATH('Error'), ELEMENTS;
          IF(@@trancount > 0)
          BEGIN
            COMMIT TRANSACTION;
          END;
          RETURN;     
      END;

     /* Обнуление временной части */
     SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME);
     SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME);

     -- включать граничную дату конечную дату архива
     IF(@includePeriodEnd = 1)
     BEGIN
        SET @periodEnd = DATEADD(day, 1, @periodEnd);
     END;
      
     DECLARE @expectedDateInterval INT = DATEDIFF(DAY, @periodBegin, @periodEnd);   
     DECLARE @selectedRowLimitCount INT = 250000;
     DECLARE @selectedDateInterval INT = 0; 

     IF(@channelId != 0)
     BEGIN
      SELECT TOP(1) @measurementDeviceId = [Channel].[MeasurementDeviceId] 
      FROM [Business].[Channel] [Channel] WHERE [Channel].[Id] = @channelId
     END;
        
     IF (@periodTypeId = 1)
     BEGIN
      SET @error = 'Система ограничивает получение мгновенных данных.';

      SELECT 
           @dateTime [DateTime], 
           @uid [Uid],
           @methodName [MethodName],      
           @error [Message],
           (
            SELECT           
              @periodTypeId [PeriodTypeId]          
            FOR XML PATH('AdditionalInfo'), ELEMENTS, TYPE
           )
        FOR XML PATH('Error'), ELEMENTS;

      IF(@@trancount > 0)
      BEGIN
            COMMIT TRANSACTION;
      END;
      RETURN;
     END;
   
     /* Ограничиваем отдачу по запрашиваемому интервалу */

     /* часовые и текущие итоговые за сутки*/
     IF(@periodTypeId = 2 OR @periodTypeId = 5) 
     BEGIN
        SET @selectedDateInterval = 31; --1;
     END
   
     /* суточные за 1 месяц */
     ELSE IF (@periodTypeId = 3)
     BEGIN
        SET @selectedDateInterval = 31;
     END

     /* месячное архивное значение и итоговое значение */
     ELSE IF (@periodTypeId = 4 OR @periodTypeId = 6)
     BEGIN
        SET @selectedDateInterval = 365;
     END;

     IF(@expectedDateInterval > @selectedDateInterval)
     BEGIN 
      SET @error = 'Временной интервал превышает допустимое значение.';
      SELECT 
           @dateTime [DateTime], 
           @uid [Uid],
           @methodName [MethodName],      
           @error [Message],
           (
            SELECT
              @periodBegin [PeriodBegin],
              @periodEnd [PeriodEnd],
              @periodTypeId [PeriodTypeId],
              @expectedDateInterval [ArchiveEntriesDateInterval],
              @selectedDateInterval [ArchiveEntriesLimitDateInterval] 
            FOR XML PATH('AdditionalInfo'), ELEMENTS, TYPE
           )
        FOR XML PATH('Error'), ELEMENTS;

      IF(@@trancount > 0)
      BEGIN
        COMMIT TRANSACTION;
      END;
      RETURN;
     END;

     DECLARE @expectedRowCount BIGINT = 
     (
        SELECT COUNT([Archive].[Id]) [ExpectedRowCount]
           FROM [Business].[Archive] WITH (NOLOCK)         		   
		     INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK) 
              ON [MeasurementDevice].[Id] = [Archive].[MeasurementDeviceId]	  
		     WHERE 
		        ([Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEnd)		      
		        AND [Archive].PeriodTypeId = @periodTypeId 
              AND [MeasurementDevice].[Id] = @measurementDeviceId 
     );
  
     IF(@expectedRowCount > @selectedRowLimitCount)
     BEGIN
        SET @error = 'Количество выбираемых элементов архива превышает допустимое значение.';
        SELECT 
           @dateTime [DateTime], 
           @uid [Uid],
           @methodName [MethodName],      
           @error [Message],
           (
              SELECT
                @expectedRowCount [ArchiveEntriesTotalCount],
                @selectedRowLimitCount [ArchiveEntriesLimitCount]
              FOR XML PATH('AdditionalInfo'), ELEMENTS, TYPE
           )         
        FOR XML PATH('Error'), ELEMENTS;

        IF(@@trancount > 0)
        BEGIN
          COMMIT TRANSACTION;
        END;
        RETURN;
     END;
 
    SELECT                     
        @dateTime [DateTime],  
        @uid [Uid],
        @methodName [MethodName],      
        -- Business
        (      
          SELECT 
          (
              SELECT 
                [MeasurementDevice].[Id], 
                [MeasurementDevice].[DeviceId],   
                [MeasurementDevice].[FactoryNumber]
                            
		         FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)				
		   
		            WHERE [MeasurementDevice].[Id] = @measurementDeviceId
		         FOR XML PATH('MeasurementDevice'), ELEMENTS, TYPE,  ROOT('MeasurementDevices')

           ), -- MeasurementDevices               
           (     
             SELECT    
                [Archive].[Id]
                ,[Archive].[Time]
                ,[Archive].[DeviceParameterId]
                ,[Archive].[Value]
                ,[Archive].[IsValid] 
              FROM
              (
                SELECT
                  [Archive].[Id]
                 ,[Archive].[Time]
                 ,[Archive].[DeviceParameterId]
                 ,[Archive].[Value]
                 ,[Archive].[IsValid]
                 ,[ParameterMapDeviceParameter].[ChannelTemplateId]
                 ,ROW_NUMBER() OVER
                  (
                    PARTITION BY [Archive].[Id] 
                    ORDER BY [Archive].[Id] 
                  ) [Num] 
                
                FROM [Business].[Archive] [Archive] WITH (NOLOCK)
        
                INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH(NOLOCK) ON 
                  [Archive].[DeviceParameterId] = [ParameterMapDeviceParameter].[DeviceParameterId] 
                  AND [Archive].[PeriodTypeId] = [ParameterMapDeviceParameter].[PeriodTypeId] 
                  AND [ParameterMapDeviceParameter].[PeriodTypeId] = @periodTypeId
        
                INNER JOIN 
                ( 
                  SELECT [ChannelOuter].[Id], [ChannelOuter].[ChannelTemplateId], [ChannelOuter].[MeasurementDeviceId]
                  FROM
                  (
                      SELECT [Channel].[Id] [Id]
  
                      FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
              
                        INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                          ON [Channel].[Id] = [UserLinkChannel].[ChannelId] 
                            AND [Channel].[MeasurementDeviceId] = @measurementDeviceId
              
                        INNER JOIN [Admin].[User] [User] WITH(NOLOCK)
                          ON [UserLinkChannel].[UserId] = [User].[Id]
              
                      WHERE [User].[UserName] = @userName
              
                      UNION
              
                      SELECT [Channel].[Id] [Id]
              
                      FROM [WebApi].[ArchiveDownloader] [ArchiveDownloader] WITH (NOLOCK)
                
                        INNER JOIN [Admin].[User] [User] WITH (NOLOCK)
                          ON [User].[Id] = [ArchiveDownloader].[Id]
              
                        INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
                          ON [Channel].[OrganizationId] = [ArchiveDownloader].[OrganizationId] 
                            AND [Channel].[MeasurementDeviceId] = @measurementDeviceId
              
                      WHERE [User].[UserName] = @userName
                    ) [ChannelInner] INNER JOIN [Business].[Channel] [ChannelOuter] WITH (NOLOCK) ON [ChannelOuter].[Id] = [ChannelInner].[Id]

                ) [Channel] ON [Archive].[MeasurementDeviceId] = [Channel].[MeasurementDeviceId]

                INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
                  ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId] AND [ParameterMapDeviceParameter].[ChannelTemplateId] = [ChannelTemplate].[Id] 

              WHERE 
                [Archive].[MeasurementDeviceId] = @measurementDeviceId AND 
                [Archive].PeriodTypeId = @periodTypeId AND 
                ([Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEnd)
              
              ) [Archive] WHERE [Archive].[Num] = 1
		           
		         FOR XML PATH('Archive'), ELEMENTS, TYPE, ROOT('Archives')
           ) -- Archives
                     
           FOR XML PATH('Business'), ELEMENTS, TYPE) -- Business       

      FOR XML PATH('Package'), ELEMENTS;
     
      COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      IF (XACT_STATE()) = -1
      BEGIN       
        ROLLBACK TRANSACTION;
      END;
      IF (XACT_STATE()) = 1
      BEGIN      
        COMMIT TRANSACTION;   
      END;

      SET @error = 'Внутренняя ошибка выполнения запроса. ' + ERROR_MESSAGE();
      SELECT 
         @dateTime [DateTime],  
         @uid [Uid],
         @methodName [MethodName],      
         @error [Message]             
      FOR XML PATH('Error'), ELEMENTS, TYPE;        
  END CATCH;
  
  RETURN (0); 
 END;
GO