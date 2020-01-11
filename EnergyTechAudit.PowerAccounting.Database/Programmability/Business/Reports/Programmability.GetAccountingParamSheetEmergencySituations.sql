-- ====================================================================================================
-- Author: Maxim Okulin
-- Create date: 26 September 2018
-- Description: Возвращает набор данных для отчета "Нештатные ситуации ведомостей учета ресурсов"
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[GetAccountingParamSheetEmergencySituations]
	@userName NVARCHAR(32),
	@channelId INT,
	@periodBegin DATETIME,
	@periodEnd DATETIME,
	@periodTypeId INT
AS
BEGIN
    SET NOCOUNT ON;
	SET XACT_ABORT ON;
	
	BEGIN TRY
	
	/* все выборки в составе хранимой процедуры имеют статус "грязных" */
      SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

      BEGIN TRANSACTION;
	  
	  DECLARE @measurementDeviceId INT = 
      (
        SELECT TOP(1) [Channel].[MeasurementDeviceId] 
        FROM [Business].[Channel] [Channel] WITH (NOLOCK)
        WHERE [Channel].[Id] = @channelId 
      );
	  DECLARE @channelTemplateId INT = 
      (
        SELECT TOP(1) [Channel].[ChannelTemplateId]
        FROM [Business].[Channel] [Channel] WITH (NOLOCK)
        WHERE [Channel].[Id] = @channelId 
      );

		DECLARE @deviceCode NVARCHAR(64);

	  SELECT TOP(1) 
      @deviceCode = [Device].[Code]
      
      FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)

      INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)
        ON [MeasurementDevice].[DeviceId] = [Device].[Id]

      WHERE [MeasurementDevice].[Id] = @measurementDeviceId

  /* Обнуление временной части */
  SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME);
  SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME);

  IF (@deviceCode = 'Elf' AND @periodTypeId = 2)
    BEGIN
       SET @periodEnd = DATEADD(HOUR, -1, @periodEnd);
    END

  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
      DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

      INSERT INTO @resultSetName VALUES
         (1, 'ReportParameter'),
         (2, 'MainData')
		     
      
	  SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName]

       DECLARE @userId  INT;    
      DECLARE @roleCode NVARCHAR(64);

      EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

     -- если пользователю не принадлежит прибор 
     IF(NOT EXISTS(SELECT 1 FROM [Business].[UserLinkChannel] [Link] WITH(NOLOCK) WHERE [Link].[UserId] = @userId AND [Link].[ChannelId] = @channelId))
     BEGIN    
        DECLARE @errorPermissionMsg  NVARCHAR(2048) 
         = [Programmability].[GetSysMessage](297, 1033);
        -- то возбуждаем исключение с сообщением 297                 
        THROW 500001, @errorPermissionMsg, 1;
     END;

    DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
      INSERT INTO @reportParameter
         SELECT [Name], [Value]
         FROM
		      (SELECT  
			   CAST([D].[Code] AS NVARCHAR(128)) [DeviceCode],           
               CAST([Z].[Description] AS NVARCHAR(128)) [District],
               CAST([B].[FullAddress] AS NVARCHAR(128)) [FullAddress],
               CONVERT(NVARCHAR(128), [Md].[FactoryNumber], 0) [FactoryNumber],
               CONVERT(NVARCHAR(128), [Md].[Id], 0) [MeasurementDeviceId]

		      FROM [Business].[MeasurementDevice] [Md] WITH (NOLOCK)
			      INNER JOIN [Dictionaries].[Device] [D] 
              ON [D].[Id] = [Md].[DeviceId]
			      
            INNER JOIN [Business].[AccessPoint] [Ap] WITH (NOLOCK)
              ON [Ap].[Id] = [Md].[AccessPointId]
			      
            INNER JOIN [Business].[AccessPointLinkBuilding] [ApBL] WITH (NOLOCK)  
              ON [ApBL].[AccessPointId] = [Ap].[Id]
			      
            INNER JOIN [Business].[Building] [B] WITH (NOLOCK)
              ON [B].[Id] = [ApBL].[BuildingId]
			      
            INNER JOIN [Dictionaries].[District] [Z] WITH (NOLOCK)
              ON [Z].[Id] = [B].[DistrictId] 
            
            INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
              ON [Channel].[MeasurementDeviceId] = [Md].[Id] AND [Channel].[Id] = @channelId --!IMPORTANT

		      WHERE [Md].[Id] = @measurementDeviceId) [MeasurementDeviceInfo]
         UNPIVOT 
         (  
            [Value] FOR [Name] IN 
            (
			  [DeviceCode],
              [District], 
              [FullAddress], 
              [FactoryNumber],
              [MeasurementDeviceId]
            ) 
         ) [ReportParameter];

      SELECT 
         [ReportParameter].[Name], 
         [ReportParameter].[Value] 
      FROM @reportParameter [ReportParameter];


      IF @deviceCode = 'Elf'
      BEGIN
      -- поиск девайсового параметра ошибки системы на базе шаблона канала
      DECLARE @deviceParameterId INT = (SELECT pmdp.DeviceParameterId FROM [Business].[ParameterMapDeviceParameter] pmdp WITH (NOLOCK)
        WHERE pmdp.ParameterId = 5000 AND pmdp.ChannelTemplateId = @channelTemplateId AND pmdp.PeriodTypeId = @periodTypeId);

      SELECT a.Time, a.[Value] FROM [Business].[Archive] a WITH (NOLOCK)
        WHERE a.PeriodTypeId = @periodTypeId AND a.MeasurementDeviceId = @measurementDeviceId AND 
              a.Time >= @periodBegin AND a.Time <= @periodEnd AND a.DeviceParameterId = @deviceParameterId
      END
      ELSE
        BEGIN
          SELECT 1;
          END
        
	  COMMIT TRANSACTION;

	  END TRY

  /* Логирование ошибки хранимой процедуры */
  BEGIN CATCH
    DECLARE @lineFeed CHAR(1) = CHAR(13);

       DECLARE @parameterListTrace NVARCHAR(256) = 
             CONCAT
             (  
                '@userName: ' ,            @userName, @lineFeed, 
                '@measurementDeviceId: ',  @measurementDeviceId, @lineFeed, 
                '@channelId: ',            @channelId, @lineFeed
             );

      DECLARE @errorMessage NVARCHAR(MAX) = 
         CONCAT
         (
            'ErrorNumber: ',     ERROR_NUMBER(), @lineFeed,
            'ErrorSeverity: ',   ERROR_SEVERITY(), @lineFeed,
            'ErrorState: ' ,     ERROR_STATE(), @lineFeed,
            'ErrorProcedure: ',  ERROR_PROCEDURE(), @lineFeed,
            'ErrorLine: ',       ERROR_LINE(), @lineFeed,
            'ErrorMessage: ',    ERROR_MESSAGE()
         );

      INSERT INTO [Admin].[ErrorLogEntry] 
         (
            [Time], 
            [Exception], 
            [Message], 
            [UserName],
            [StackTrace]
         )
      VALUES
         (
            GETDATE(), 
            'InternalSqlServerException', 
            @errorMessage, 
            SUSER_NAME(),
           @parameterListTrace
         );
      -- пробрасываем исключение на верх
      THROW;    
  END CATCH;
END;