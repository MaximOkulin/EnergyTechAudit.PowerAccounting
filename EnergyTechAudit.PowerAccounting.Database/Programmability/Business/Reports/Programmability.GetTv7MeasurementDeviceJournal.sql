-- ====================================================================================================
-- Author: Maxim Okulin
-- Create date: 21 January 2016
-- Description: Возвращает набор данных для отчета "Асинхронные архивы прибора ТВ7"
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[GetTv7MeasurementDeviceJournal]
	@userName NVARCHAR(32),
	@channelId INT,
	@asyncArchiveTypeId INT
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
	  
	  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
      DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

      INSERT INTO @resultSetName VALUES
         (1, 'ReportParameter'),
         (2, 'MainData'),
		 (3, 'ColumnCaption') -- набор с необязательной расшифровкой имен столбцов наборов
      
	  SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName]

	  /* 2. Проверка соотвествия принадлежность прибора пользователю */
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

	 /* 3. Формирование таблицы параметрии отчета*/
      DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
      INSERT INTO @reportParameter
         SELECT [Name], [Value]
         FROM
		      (SELECT  
			   CAST([D].[Code] AS NVARCHAR(128)) [DeviceCode],           
               CAST([Z].[Description] AS NVARCHAR(128)) [District],
               CAST([B].[FullAddress] AS NVARCHAR(128)) [FullAddress],
               CONVERT(NVARCHAR(128), [Md].[FactoryNumber], 0) [FactoryNumber]

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
              [FactoryNumber]
            ) 
         ) [ReportParameter];
      
	  DECLARE @reportTitle NVARCHAR(48) = N'Неизвестный тип асинхронного архива';
	  DECLARE @internalDeviceEventStartIndex INT = -1;
	  DECLARE @internalDeviceEventEndIndex INT = -1;

	  IF @asyncArchiveTypeId = 0
	  BEGIN
	      SET @reportTitle = N'Архив изменений базы данных';
		  SET @internalDeviceEventStartIndex = 1;
		  SET @internalDeviceEventEndIndex = 49;
	  END
	  IF @asyncArchiveTypeId = 1
	  BEGIN
	      SET @reportTitle = N'Архив событий';
		  SET @internalDeviceEventStartIndex = 50;
		  SET @internalDeviceEventEndIndex = 80;
	  END
	  IF @asyncArchiveTypeId = 2
	  BEGIN
	      SET @reportTitle = N'Диагностический архив';
		  SET @internalDeviceEventStartIndex = 81;
		  SET @internalDeviceEventEndIndex = 86;
      END

      INSERT INTO @reportParameter ([Name],[Value])
	  VALUES ('ReportTitle', @reportTitle);
         
      SELECT 
         [ReportParameter].[Name], 
         [ReportParameter].[Value] 
      FROM @reportParameter [ReportParameter];

	  /* 4. Основная выборка */

	  SELECT [MainData].[Time] [Time],
	         [MainData].[Description] [Event],
			 [MainData].[OriginalValue] [OriginalValue],
			 [MainData].[CurrentValue] [CurrentValue]	  
	  FROM [Business].[MeasurementDeviceJournal] [MainData] WITH (NOLOCK)
	         WHERE [MeasurementDeviceId] = @measurementDeviceId AND 
			       [InternalDeviceEventId] >= @internalDeviceEventStartIndex AND
				   [InternalDeviceEventId] <= @internalDeviceEventEndIndex
      ORDER BY [Time] ASC

	  /* 5. Вспомогательная таблица с расшифровками столбцов */
	  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];
 
	  INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES
        ('MainData', 'Time', 'Время', 1, 1),
		('MainData', 'Event', 'Параметр/Событие', 1, 2),
		('MainData', 'OriginalValue', 'Старое значение', 1, 3),
		('MainData', 'CurrentValue', 'Новое значение', 1, 4)
      /**/

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
                '@channelId: ',            @channelId, @lineFeed, 
                '@asyncArchiveTypeId: ',   @asyncArchiveTypeId, @lineFeed                        
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