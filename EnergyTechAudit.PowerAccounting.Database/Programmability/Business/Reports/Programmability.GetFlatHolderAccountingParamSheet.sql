CREATE PROCEDURE [Programmability].[GetFlatHolderAccountingParamSheet]
  @userName NVARCHAR(32),  
  @channelId INT,
  @periodBegin DATETIME,
  @periodEnd DATETIME
AS
BEGIN   
   SET NOCOUNT ON;
  
   BEGIN TRY
    SET @periodEnd = DATEADD(DAY, 1, @periodEnd);

    SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME);
    SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME);
    
    DECLARE @measurementDeviceId INT = 0;
    DECLARE @channelTemplateId INT = 0;
    DECLARE @userId  INT = NULL;
    DECLARE @periodTypeId INT = 5;
        
    /* 1. Определение соответствия между учетной записью и 
          принадлежностью каналов на основе соотвествия "пользователь-помещение"
    */
    
    SELECT @userId = [User].[Id] FROM [Admin].[User] [User] 
      INNER JOIN [Admin].[Role] [Role] ON       
      [User].[RoleId] = [Role].[Id] AND [User].[UserName] = @userName AND [Role].[Code] = 'HOLDER'
    
    IF(@userId IS NULL)
    BEGIN
      -- генерировать исключение    	
      ;THROW 500001, N'Пользователь не существует или не принадлежит к группе "Владелец помещения"', 1;    	    	
    END;
    
    IF NOT EXISTS
    (
    	SELECT 1 [Ch] FROM [Business].[Channel] [Channel] WITH (NOLOCK)
      INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
      ON [Channel].[PlacementId] = [Placement].[Id]
      WHERE (ISNULL([Placement].[UserAdditionalInfoId], 0) = @userId) AND [Channel].[Id] = @channelId
    ) 
    BEGIN
      -- генерировать исключение
      ;THROW 500001, N'Отсутствует привязки канала помещения и владельца помещения.', 1;    	    	
    END;
    
    /* 2. Определение идентификаторов устройства и шаблона канала */
    SELECT 
      @measurementDeviceId = [Channel].[MeasurementDeviceId],
      @channelTemplateId = [Channel].[ChannelTemplateId]
    
      FROM [Business].[Channel] [Channel] WITH (NOLOCK)
    
      INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
        ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
      WHERE [Channel].[Id] = @channelId
    
    IF(NOT EXISTS
      (
        SELECT 1
          FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]
          WHERE [ParameterMapDeviceParameter].[ChannelTemplateId] = @channelTemplateId
      ))
    BEGIN
      	-- генерировать исключение
      ;THROW 500001, N'Отсутствуют параметры в матрице сопоставления параметров.', 1;    	
    END;
    
     /* 1. Таблица с наименованиями результирующих наборов*/
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName VALUES 
      (1, 'ReportParameter')
      ,(2, 'MainData')      
      ,(3, 'ColumnCaption')

    SELECT [ResultSetName].[Order], [ResultSetName].[Name] FROM @resultSetName [ResultSetName]
    /**/
      
    /* 2. Формирование таблицы параметрии отчета*/
    DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
    INSERT INTO @reportParameter
        SELECT [Name], [Value]
        FROM
		    (SELECT                            
              CAST([Device].[Code] AS NVARCHAR(128)) [DeviceCode],
              CAST(CONCAT([UserAdditionalInfo].[LastName], ' ', [UserAdditionalInfo].[FirstName], ' ', [UserAdditionalInfo].[Patronimic]) AS NVARCHAR(128)) [HolderDescription],
              CAST(CONCAT([PlacementPurpose].[Description], ' ', [Placement].[Number]) AS NVARCHAR(128)) [PlacementDescription],
              CAST([Building].[FullAddress] AS NVARCHAR(128)) [FullAddress],
              CONVERT(NVARCHAR(128), [Md].[FactoryNumber], 0) [FactoryNumber],
              CAST([ResourceSystemType].[ShortName] AS NVARCHAR(128)) [ResourceSystemTypeShortName],
              CAST([ResourceSystemType].[Description] AS NVARCHAR(128)) [ResourceSystemTypeDescription]

		    FROM [Business].[MeasurementDevice] [Md] WITH(NOLOCK)

			    INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)
            ON [Device].[Id] = [Md].[DeviceId]
			    
          INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
            ON [Channel].[MeasurementDeviceId] = [Md].[Id] AND [Channel].[Id] = @channelId --!IMPORTANT
          
			    INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK)
            ON [Placement].[Id] = [Channel].[PlacementId]
          
          INNER JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] WITH(NOLOCK)
            ON [UserAdditionalInfo].[Id] = [Placement].[UserAdditionalInfoId]

          INNER JOIN [Dictionaries].[PlacementPurpose] [PlacementPurpose] WITH(NOLOCK)
            ON [PlacementPurpose].[Id] = [Placement].[PlacementPurposeId]
                                  
          INNER JOIN [Business].[Building] [Building] WITH(NOLOCK)
            ON [Building].[Id] = [Placement].[BuildingId]
			      
          INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
            ON [District].[Id] = [Building].[DistrictId] 
          
          INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH(NOLOCK)
            ON [Channel].[ResourceSystemTypeId] = [ResourceSystemType].[Id]

          INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK)
            ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId]

		    WHERE [Md].[Id] = @measurementDeviceId) [ReportParameterInfo]
        UNPIVOT 
        (  
          [Value] FOR [Name] IN 
          (
            [DeviceCode], 
            [HolderDescription], 
            [FullAddress], 
            [FactoryNumber], 
            [ResourceSystemTypeShortName], 
            [ResourceSystemTypeDescription],
            [PlacementDescription]
          ) 
        ) [ReportParameter];
            
    SELECT 
        [ReportParameter].[Name], 
        [ReportParameter].[Value] 
    FROM @reportParameter [ReportParameter];
    /**/
     
    /* 3. Основная выборка данных */
    SELECT [Archive].[Num],
            [Archive].[ParameterId],
            [Archive].[DeviceParameterId],
            [Archive].[Time],
            [Archive].[Value],
            [Archive].[NextValue],
            [Archive].[NextValue] - [Archive].[Value] [Delta],
            [Archive].[ParameterDescription],
            [Archive].[MeasurementUnitDescription],
            [Archive].[DimentionPrefix] INTO #Result  FROM
       (
        SELECT  TOP 100 PERCENT
          [Archive].[Num],
          [Archive].[ParameterId],
          [Archive].[DeviceParameterId],
          [Archive].[Time],
          [Archive].[Value],
          LEAD([Archive].[Value]) OVER (PARTITION BY [Archive].[DeviceParameterId] ORDER BY [Archive].[Time]) [NextValue],
          [Archive].[ParameterDescription],
          [Archive].[MeasurementUnitDescription],
          [Archive].[DimentionPrefix]
        FROM
        (
            SELECT ROW_NUMBER() OVER 
              (
                PARTITION BY [A].[DeviceParameterId], CONVERT(DATE, [A].[Time]) 
                ORDER BY [A].[Time] DESC, [A].[DeviceParameterId] ASC
              ) [Num],
              [A].[Time], 
              [A].[Value], 
              [A].[DeviceParameterId],
              [Parameter].[Id] [ParameterId],
              [Parameter].[Description] [ParameterDescription], 
              [MeasurementUnit].[Description] [MeasurementUnitDescription],
              [Dimention].[Prefix] [DimentionPrefix]
            FROM [Business].[Archive] [A] WITH(NOLOCK)
              
              INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH(NOLOCK)
                ON [A].[DeviceParameterId] = [DeviceParameter].[Id]
    
              INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH(NOLOCK)
                ON [ParameterMapDeviceParameter].[ChannelTemplateId] = @channelTemplateId
                  AND [ParameterMapDeviceParameter].[DeviceParameterId] = [A].[DeviceParameterId]
                  AND [ParameterMapDeviceParameter].[PeriodTypeId] = @periodTypeId
    
              INNER JOIN [Dictionaries].[Parameter] [Parameter] WITH(NOLOCK)
                ON [ParameterMapDeviceParameter].[ParameterId] = [Parameter].[Id]
    
              INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] 
                ON [ParameterMapDeviceParameter].[MeasurementUnitId] = [MeasurementUnit].[Id]
    
              INNER JOIN [Dictionaries].[Dimension] [Dimention] WITH(NOLOCK)
                ON [Dimention].[Id] = [ParameterMapDeviceParameter].[DimensionId]
    
            WHERE 
            	[A].[MeasurementDeviceId] = @measurementDeviceId AND 
            	[A].[DeviceParameterId] IN 
              (
                SELECT [ParameterMapDeviceParameter].[DeviceParameterId]
                FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH(NOLOCK)
                WHERE 
                  [ParameterMapDeviceParameter].[ChannelTemplateId] = @channelTemplateId 
                  AND [ParameterMapDeviceParameter].[PeriodTypeId] = @periodTypeId
              ) 
              AND 
            	[A].[PeriodTypeId] = @periodTypeId 
            	AND	([A].[Time] >= @periodBegin AND [A].[Time] <= @periodEnd)
        ) [Archive] 
        
        WHERE [Archive].[Num] = 1 ORDER BY [Archive].[Time], [Archive].[DeviceParameterId] ASC 
      ) [Archive] 
    ORDER BY [Archive].[DeviceParameterId];

    DECLARE @count INT = 
    (
      SELECT COUNT(*) [Count] FROM #Result
    );

    SELECT [Archive].[Num]
            ,[Archive].[ParameterId]
            ,[Archive].[DeviceParameterId]
            ,[Archive].[Time]
            ,[Archive].[Value]
            ,[Archive].[NextValue]
            ,[Archive].[NextValue] - [Archive].[Value] [Delta]
            ,[Archive].[ParameterDescription]
            ,[Archive].[MeasurementUnitDescription]
            ,[Archive].[DimentionPrefix]
			
        
     FROM #Result [Archive] WHERE [Archive].[NextValue] IS NOT NULL AND [Archive].[Delta] IS NOT NULL;

   /**/ 

   /*4. Наименования столбцов для решетки */
   DECLARE @columnCaption [Programmability].[ColumnCaptionTableType] ;

   INSERT INTO @columnCaption 
   OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
   VALUES
		('MainData', 'ParameterDescription', 'Параметр', 1, 1)       
		,('MainData', 'Value', 'Итоговое значение', 1, 2)		
		,('MainData', 'Delta', 'Значение за период', 1, 3)		
	    ,('MainData', 'Time', 'Время измерения', 1, 4)		
		,('MainData',  'DeviceParameterId', 'Ид параметра прибора', 0, 5)	   
	    ,('MainData',  'ParameterId', 'Ид параметра', 0, 6)	   	   
		,('MainData', 'DimentionPrefix', 'Размерность', 1, 7) 	   
	   ,('MainData', 'MeasurementUnitDescription', 'Единица измерения', 1, 8) 	   
	   
  /**/

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
                '@periodBegin: ',          @periodBegin, @lineFeed, 
                '@periodEnd: ',            @periodEnd, @lineFeed                 
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
