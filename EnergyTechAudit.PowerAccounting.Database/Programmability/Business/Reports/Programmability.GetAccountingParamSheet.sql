-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-01-23
-- Description: Возвращает набор данных для отчета 'Ведомость учета параметров'
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[GetAccountingParamSheet]
  @userName NVARCHAR(32),  
  @channelId INT,
  @periodBegin DATETIME,
  @periodEnd DATETIME,
  @includePeriodEnd BIT,
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

	    DECLARE @deviceId INT;
	    DECLARE @deviceCode NVARCHAR(64);
      
      SELECT TOP(1) 
        @deviceId = [MeasurementDevice].[DeviceId], 
        @deviceCode = [Device].[Code]
      
      FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK)

      INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)
        ON [MeasurementDevice].[DeviceId] = [Device].[Id]

      WHERE [MeasurementDevice].[Id] = @measurementDeviceId
      

      /* Обнуление временной части */
	  IF NOT(@periodTypeId = 2 AND (@deviceCode = 'EK270' OR @deviceCode = 'Irvis' OR @deviceCode = 'VIST'))
	  BEGIN
      SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME);
      SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME);
	  END;

	  /* Коррекция времени в стиле архивного времени модели прибора (например, Взлет имеет вид 01.03.2015 23:59:59)*/
	   EXEC [Programmability].[CorrectArchiveTime] @periodTypeId, @deviceId, @measurementDeviceId, @periodBegin OUTPUT, @periodEnd OUTPUT

     IF(@includePeriodEnd = 1 AND @deviceCode <> 'TV7' AND @deviceCode <> 'Elf')
      BEGIN 
         SET @periodEnd = DATEADD (day , 1, @periodEnd);
      END;

	  IF(@includePeriodEnd = 0 AND (@deviceCode = 'VZLJOT_024' OR @deviceCode = 'VZLJOT_024M' OR @deviceCode = 'VZLJOT_026M'))
      BEGIN 
         SET @periodEnd = DATEADD (day , 1, @periodEnd);
      END;

	  IF (@periodTypeId = 3 AND (@deviceCode = 'Spt943' OR @deviceCode = 'Spt941_10_11' OR @deviceCode = 'Spt941_20'))
      BEGIN
         SET @periodEnd = DATEADD (day , 1, @periodEnd);
      END;

	  IF (@periodTypeId = 2 AND (@deviceCode = 'Spt943' OR @deviceCode = 'Spt941_10_11' OR @deviceCode = 'Spt941_20' OR @deviceCode = 'EK270' OR @deviceCode = 'Irvis' OR @deviceCode = 'Pramer710'))
      BEGIN
         SET @periodEnd = DATEADD (hour , 1, @periodEnd);
      END;
     
 
    /* Поиск ближайшей даты к @periodBegin (т.к. не всегда на заданную дату есть архивная запись) */
     DECLARE @realPeriodBegin DATETIME = (SELECT TOP 1 [Archive].[Time] FROM [Business].[Archive] [Archive] WITH(NOLOCK) 
         INNER JOIN [Business].[MeasurementDevice] [Device] WITH(NOLOCK) 
           ON [Device].[Id] = @measurementDeviceId AND [Device].[Id] = [Archive].[MeasurementDeviceId]

         INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
           ON [Channel].[Id] = @channelId AND [Channel].[MeasurementDeviceId] = [Device].[Id]
         
         INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK)
            ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId]

         INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH(NOLOCK)
            ON [DeviceParameter].[Id] = [Archive].[DeviceParameterId]
         
         INNER JOIN [Business].[ParameterMapDeviceParameter] [Map] WITH(NOLOCK)
            ON [Map].[DeviceParameterId] = [DeviceParameter].[Id] 
               AND [Map].[ChannelTemplateId] = [ChannelTemplate].[Id]
               AND [Map].[PeriodTypeId] = @periodTypeId

       WHERE [Archive].[PeriodTypeId] = @periodTypeId AND [Archive].[Time] >= @periodBegin
       ORDER BY [Archive].[Time] ASC)

      /* Если на дату @periodBegin нет архивов, то корректируем на ту, с которой действительно начинаются архивы */
      IF (@periodBegin <> @realPeriodBegin)
      BEGIN
         IF (@periodTypeId = 3)
         BEGIN
            IF(@deviceCode = 'Mercury230' OR @deviceCode = 'Mercury234')
            BEGIN
              SET @periodBegin = @realPeriodBegin
            END
            ELSE
            BEGIN
              SET @periodBegin = DATEADD (day,  1, @realPeriodBegin)
            END
         END
        
         IF (@periodTypeId = 2)
         BEGIN
		    IF(@deviceCode = 'KM5' OR @deviceCode = 'RM5')
			BEGIN
			  SET @periodBegin = @realPeriodBegin
			END
			ELSE
			BEGIN
              SET @periodBegin = DATEADD (hour, 1, @realPeriodBegin)
            END
         END
      END

      /* Сдвиг для безынтеграции накопительных значений */
	  IF (@deviceCode <> 'VZLJOT_033-034' AND @deviceCode <> 'VZLJOT_024' AND @deviceCode <> 'VZLJOT_024M' 
	      AND @deviceCode <> 'VZLJOT_026M' AND @deviceCode <> 'VKT9')
	  BEGIN
		IF (@periodTypeId = 3)
		BEGIN
			SET @periodBegin = DATEADD (day , -1, @periodBegin);
		END
      
		IF (@periodTypeId = 2 AND @deviceCode <> 'EK270' AND @deviceCode <> 'Irvis' AND @deviceCode <> 'VKT7' AND @deviceCode <> 'Pulsar2M' AND @deviceCode <> 'VZLJOT_043' AND @deviceCode <> 'VZLJOT_025'
		                      AND @deviceCode <> 'KM5' AND @deviceCode <> 'RM5' AND @deviceCode <> 'EskoTm3E' AND @deviceCode <> 'VIST')
		BEGIN
			SET @periodBegin = DATEADD (hour, -1, @periodBegin);
		END
	  END
   
      /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
      DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

      INSERT INTO @resultSetName VALUES
         (1, 'ReportParameter'),
         (2, 'ReportFieldInfo'),
         (3, 'MainData'),
         (4, 'SummaryData');

      IF (@deviceCode = 'KM5' OR @deviceCode = 'RM5')
      BEGIN
          INSERT INTO @resultSetName VALUES
            (5, 'ErrorsData')     
		  INSERT INTO @resultSetName VALUES
		    (6, 'DynamicParameters')
      END

      SELECT [ResultSetName].[Order], [ResultSetName].[Name]  FROM @resultSetName [ResultSetName]
      /**/

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
     
      /**/

     /* 3. Отбор параметров архива в соответствии с типом прибора */
     -- код типа устройства
     
     -- проверка существования шаблона канала
     IF(NOT EXISTS (SELECT 1 FROM [Business].[Channel] [Channel] WITH (NOLOCK)
          INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
        WHERE [Channel].[Id] = @channelId)
     )
     BEGIN
      ;THROW 500001, N'Не назначен шаблон канала', 1;
     END;

     -- таблица со списком параметров в соответствии с типом прибора 
     DECLARE @deviceParameterCodePull [Programmability].[CodePullTableType];
            
     INSERT INTO @deviceParameterCodePull 		    
	      SELECT   
          [Parameter].[Id] [Id],
          [Parameter].[Code] [Code]
          FROM [Dictionaries].[Parameter] [Parameter] WITH (NOLOCK)
              INNER JOIN [Business].[ParameterMapDeviceParameter] [Map] WITH (NOLOCK)
              ON [Parameter].[Id] = [Map].[ParameterId] AND [Map].[PeriodTypeId] = @periodTypeId 
              INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
              ON [ChannelTemplate].[Id] = [Map].[ChannelTemplateId]
              INNER JOIN [Business].[Channel]  WITH (NOLOCK)
              ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id] AND [Channel].[Id] = @channelId
          WHERE [Channel].[MeasurementDeviceId] = @measurementDeviceId
     
     -- проверка наличия параметров из матрицы сопоставления
     IF(NOT EXISTS(SELECT 1 FROM @deviceParameterCodePull))
     BEGIN
        ;THROW 500001, N'Отсутствуют параметры в матрице сопоставленния параметров.', 1;
     END
    
     -- собираем строку со списком параметров отчета для возможности динамического из разворота 
     DECLARE @deviceParameterCodeFields NVARCHAR(MAX) = '';  
     DECLARE @deviceParameterCodeFieldsWithNext NVARCHAR(MAX) = '';  

     SELECT 
       @deviceParameterCodeFields = 
         @deviceParameterCodeFields 
           + CONCAT('[', [D].[Code], ']') + ', ',

       @deviceParameterCodeFieldsWithNext = 
         @deviceParameterCodeFieldsWithNext 
           + CONCAT('[', [D].[Code], ']') + ', '
           + CONCAT('LEAD([', [D].[Code], ']) OVER(ORDER BY [Time]) [', [D].[Code], '.Next', ']') + ','   

     FROM @deviceParameterCodePull [D];

     SET @deviceParameterCodeFields = LEFT(@deviceParameterCodeFields, LEN(@deviceParameterCodeFields) - 1);
     SET @deviceParameterCodeFieldsWithNext = LEFT(@deviceParameterCodeFieldsWithNext, LEN(@deviceParameterCodeFieldsWithNext) - 1);
  
     /**/

      /* 4. Формирование таблицы параметрии отчета*/
      DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
      INSERT INTO @reportParameter
         SELECT [Name], [Value]
         FROM
		      (SELECT             
               
               CAST([D].[Code] AS NVARCHAR(128)) [DeviceCode],
			   CAST([Md].[SubModel] AS NVARCHAR(128)) [DeviceSubModel],
			   CAST([Md].[Id] AS NVARCHAR(128)) [MeasurementDeviceId],
			   CAST([D].[IsIntegralArchiveValue] AS NVARCHAR(128)) [IsIntegralArchiveValue],
               CAST([District].[Description] AS NVARCHAR(128)) [District],
               CAST([Building].[FullAddress] AS NVARCHAR(128)) [FullAddress],
			   CAST([Building].[Description] AS NVARCHAR(128)) [BuildingDescription],			   
			   CAST([Building].[BuildingPurposeId] AS NVARCHAR(128)) [BuildingPurposeId],
			   CAST ([BuildingPurpose].[Code] AS NVARCHAR(128) ) [BuildingPurposeCode],

               CONVERT(NVARCHAR(128), [Md].[FactoryNumber], 0) [FactoryNumber],
               CAST([ResourceSystemType].[Code] AS NVARCHAR(128)) [ResourceSystemTypeCode],
			   CAST(ISNULL([ResourceSubsystemType].[Code], 'NULL') AS NVARCHAR(128)) [ResourceSubsystemTypeCode],
			   CAST(ISNULL([ResourceSubsystemType].[Description], 'NULL') AS NVARCHAR(128)) [ResourceSubsystemTypeDescription],
               CAST([D].[ShortName] AS NVARCHAR(128)) [DeviceShortName],
			   CAST([Channel].[ChannelTemplateId] AS NVARCHAR(128)) [ChannelTemplateId],
			   CAST(0 AS NVARCHAR(128)) [InfoBandVisible],
			   CAST('' AS NVARCHAR(128)) [Info]

		      FROM [Business].[MeasurementDevice] [Md] WITH (NOLOCK)
			      INNER JOIN [Dictionaries].[Device] [D] 
              ON [D].[Id] = [Md].[DeviceId]
			      
            INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
              ON [Channel].[MeasurementDeviceId] = [Md].[Id] AND [Channel].[Id] = @channelId --!IMPORTANT

			INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
             ON [Channel].[PlacementId] = [Placement].[Id]

            INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
             ON [Building].[Id] = [Placement].[BuildingId]
			
			INNER JOIN [Dictionaries].[BuildingPurpose] [BuildingPurpose] WITH (NOLOCK)
				ON [Building].[BuildingPurposeId] = [BuildingPurpose].[Id]

            INNER JOIN [Dictionaries].[District] [District] WITH (NOLOCK)
              ON [District].[Id] = [Building].[DistrictId]

            INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] WITH (NOLOCK)
              ON [Channel].[ResourceSystemTypeId] = [ResourceSystemType].[Id]

			LEFT JOIN [Dictionaries].[ResourceSubsystemType] [ResourceSubsystemType] WITH (NOLOCK)
			  ON [Channel].[ResourceSubsystemTypeId] = [ResourceSubsystemType].[Id]

            INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK)
              ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId]

		      WHERE [Md].[Id] = @measurementDeviceId) [MeasurementDeviceInfo]
         UNPIVOT 
         (  
            [Value] FOR [Name] IN 
            (
              [DeviceCode],
			  [DeviceSubModel], 
			  [MeasurementDeviceId],
			  [IsIntegralArchiveValue],
              [District], 
              [FullAddress], 
			  [BuildingDescription],
			  [BuildingPurposeId],
			  [BuildingPurposeCode],
              [FactoryNumber], 
              [ResourceSystemTypeCode],
			  [ResourceSubsystemTypeCode],
			  [ResourceSubsystemTypeDescription],
              [DeviceShortName],
			  [ChannelTemplateId],
			  [InfoBandVisible],
			  [Info]
            ) 
         ) [ReportParameter];
   
      INSERT INTO @reportParameter    
         SELECT TOP(1) 'PeriodTypeCode' [Name], [PeriodType].[Code] [Value]
             FROM [Dictionaries].[PeriodType] [PeriodType] WITH (NOLOCK)
             WHERE [PeriodType].[Id] = @periodTypeId;
            
       IF(@deviceCode = 'Mercury230' OR @deviceCode = 'CET_4TM_03M' OR @deviceCode = 'Mercury234' OR @deviceCode = 'PSCH_4TM_05MK'
	      OR @deviceCode = 'CE301' OR @deviceCode = 'CE303')
	   BEGIN
	        DECLARE @designFactor NVARCHAR(8) = (SELECT  [DPV].[Value] [Value] FROM [Core].[DynamicParameterValue] [DPV]
		          WHERE [DPV].[DynamicParameterId] = 166 AND [DPV].[EntityId] = @measurementDeviceId)
            IF @designFactor IS NULL
	        BEGIN
			   SET @designFactor = 1
			END

			INSERT INTO @reportParameter ([Name],[Value])
			VALUES ('DesignFactor', @designFactor)
	   END

	   DECLARE @buildingId INT = (SELECT [Placement].[BuildingId] FROM [Business].[Placement] [Placement] WITH(NOLOCK)
	            INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
	            ON [Placement].[Id] = [Channel].[PlacementId] AND [Channel].[Id] = @channelId)

       -- поиск динамического параметра "UseDescriptionInReports"
	   DECLARE @useDescriptionInReports NVARCHAR(8) = (SELECT  [DPV].[Value] [Value] FROM [Core].[DynamicParameterValue] [DPV]
		          WHERE [DPV].[DynamicParameterId] = 181 AND [DPV].[EntityId] = @buildingId)
       
	   IF @useDescriptionInReports IS NULL
	   BEGIN
	         SET @useDescriptionInReports = 'false'
       END
	    
	   INSERT INTO @reportParameter ([Name],[Value])
		    VALUES ('UseBuildingDescriptionInReports', @useDescriptionInReports)


	   -- поиск динамического параметра "Начало газового дня" для EK270 и Ирвис
	   IF(@deviceCode = 'EK270' OR @deviceCode = 'Irvis')
	   BEGIN
	        DECLARE @gasHour NVARCHAR(16) = (SELECT  [DPV].[Value] [Value] FROM [Core].[DynamicParameterValue] [DPV]
		          WHERE [DPV].[DynamicParameterId] = 171 AND [DPV].[EntityId] = @measurementDeviceId)
            IF @gasHour IS NULL
	        BEGIN
			   SET @gasHour = CAST(10 as nvarchar(16));
			END

			INSERT INTO @reportParameter ([Name],[Value])
			VALUES ('GasHour', @gasHour)
	   END

      SELECT 
         [ReportParameter].[Name], 
         [ReportParameter].[Value] 
      FROM @reportParameter [ReportParameter];
      /**/
   
      /* 4а. Абстрактные параметры из шаблона канала - фактичестки базовые имена полей отчета */
      SELECT 
             [Parameter].[Code] [Name]
             ,[Parameter].[IntegrableValue] [IntegrableValue]
      FROM  @deviceParameterCodePull [ReportFieldInfo] 

      INNER JOIN [Dictionaries].[Parameter] [Parameter] 
        ON [Parameter].[Id] = [ReportFieldInfo].[Id]
      /**/
            
     /* 5. Основная выборка*/
     DECLARE @minDate DATETIME = 
     (
        SELECT MIN(Time) 
        FROM [Business].[Archive] WITH (NOLOCK)
        WHERE MeasurementDeviceId = @measurementDeviceId AND PeriodTypeId = @periodTypeId
     );

	 DECLARE @shift INT = IIF(@deviceCode = 'TV7' OR @deviceCode = 'VZLJOT_033-034' OR @deviceCode = 'VZLJOT_024' OR @deviceCode = 'VZLJOT_024M' OR @deviceCode = 'VZLJOT_026M' OR @deviceCode = 'EK270' OR @deviceCode = 'VKT9' OR @deviceCode = 'Irvis' OR @deviceCode = 'VIST', 0, IIF(DATEADD(day, 1, @periodBegin) <= @minDate, 0, 1));

     DECLARE @periodTypeBeforeShift INT = IIF(@periodTypeId = 3, @shift, IIF(@deviceCode = 'TV7' OR @deviceCode = 'KM5' OR @deviceCode = 'RM5' OR @deviceCode = 'VZLJOT_033-034' OR @deviceCode = 'VZLJOT_024' OR @deviceCode = 'VZLJOT_024M' OR @deviceCode = 'VZLJOT_026M' OR @deviceCode = 'CET_4TM_03M' OR @deviceCode = 'PSCH_4TM_05MK' OR @deviceCode = 'Mercury230' OR @deviceCode = 'Mercury234' OR @deviceCode = 'CE301' OR @deviceCode = 'CE303' OR @deviceCode = 'VKT9' OR @deviceCode= 'VKT7' OR @deviceCode = 'EskoTm3E' OR @deviceCode = 'Pramer710' OR @deviceCode = 'VIST', 0, IIF(@periodTypeId = 2, 24, 1)));

	 SET @periodTypeBeforeShift = IIF (@periodTypeId = 2 AND (@deviceCode = 'EK270' OR @deviceCode = 'Irvis' OR @deviceCode = 'Pulsar2M' OR @deviceCode = 'VZLJOT_043' OR @deviceCode = 'VZLJOT_025'), 0, @periodTypeBeforeShift);

     DECLARE @mainDataQuery NVARCHAR(MAX) = 
     'WITH [Archive]
     AS
     (
       SELECT 
  	      [Archive].[Time] [Time]	  
  	     ,[Parameter].[Code] [ParameterCode]        
         ,[dbo].[ConvertMeasurementUnit]
          (
              [Dimension].[Value], 
              [Muc].[DimensionValue2], 
              [Archive].[Value], 
              [Muc].[Expression]
          ) [Value]      
       FROM [Business].[Archive] [Archive] WITH(NOLOCK) 
         
         INNER JOIN [Business].[MeasurementDevice] [Device] WITH(NOLOCK) 
           ON [Device].[Id] = @measurementDeviceId AND [Device].[Id] = [Archive].[MeasurementDeviceId]

         INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
           ON [Channel].[Id] = @channelId AND [Channel].[MeasurementDeviceId] = [Device].[Id]
         
         INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK)
            ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId]

         INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH(NOLOCK)
            ON [DeviceParameter].[Id] = [Archive].[DeviceParameterId]
         
         INNER JOIN [Business].[ParameterMapDeviceParameter] [Map] WITH(NOLOCK)
            ON [Map].[DeviceParameterId] = [DeviceParameter].[Id] 
               AND [Map].[ChannelTemplateId] = [ChannelTemplate].[Id]
               AND [Map].[PeriodTypeId] = @periodTypeId

        INNER JOIN [Dictionaries].[Dimension] [Dimension] WITH(NOLOCK)
            ON [Map].[DimensionId] = [Dimension].[Id]

          INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] WITH(NOLOCK)
            ON [Map].[MeasurementUnitId] = [MeasurementUnit].[Id]

        LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc] 

          /* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
          ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 

         INNER JOIN [Dictionaries].[Parameter] [Parameter] WITH(NOLOCK) 
           ON [Parameter].[Id] = [Map].[ParameterId]

         WHERE          
           ([Archive].[Time] >= @periodBegin AND  [Archive].[Time] <= @periodEnd)
           AND [Archive].[PeriodTypeId] = @periodTypeId                   
     )
     SELECT * INTO #ResultPivotArchive FROM (
        SELECT [Time], CAST(1 AS BIT) [IsValidRowState], {deviceParameterCodeFieldsWithNext} FROM
          (
            SELECT [Time], {deviceParameterCodeFields}           
            FROM [Archive]
                PIVOT
                (
                  AVG([Value])
                  FOR [ParameterCode] IN ( {deviceParameterCodeFields} )                  
                ) [MainData]
          ) [PrePivotArchive] ORDER BY [PrePivotArchive].[Time] OFFSET @periodTypeBeforeShift ROW
       ) [PivotArchive];

       /* главная часть выборки */

       DECLARE @resultPivotArchiveCount INT = 
       (
         SELECT COUNT(*) - 1 FROM #ResultPivotArchive
       );

       IF(@resultPivotArchiveCount < 0)
       BEGIN
         SET @resultPivotArchiveCount = 0;
       END;

	   DECLARE @isReturnAllMainDataForVkt7 BIT = 0;
       IF (@deviceCode = ''VKT7'')
         BEGIN
            DECLARE @lastTime DATETIME;
            SELECT @lastTime = [Time] FROM #ResultPivotArchive [R] ORDER BY [Time] ASC
            IF (@periodEnd > @lastTime)
            BEGIN
               SET @isReturnAllMainDataForVkt7 = 1;
            END 
         END

	   IF(@resultPivotArchiveCount = 0 OR (@includePeriodEnd = 1 AND (@deviceCode = ''VZLJOT_026M'' OR @deviceCode = ''VZLJOT_024'' OR @deviceCode = ''VZLJOT_024M'' OR @deviceCode = ''Irvis'' OR @deviceCode = ''Elf'')) 
	     OR @isReturnAllMainDataForVkt7 = 1)
	   BEGIN
	       SELECT * FROM #ResultPivotArchive [R] ORDER BY [Time]
	   END
	   ELSE
	   BEGIN
			-- убираем из выборки последнюю (LEAD) запись 
            SELECT * FROM #ResultPivotArchive [R] 
            ORDER BY [Time] OFFSET IIF(@deviceCode = ''TV7'' OR @deviceCode = ''Spt943'' OR @deviceCode = ''Spt941_10_11'' OR @deviceCode = ''Spt941_20'', 1, 0) ROWS FETCH NEXT @resultPivotArchiveCount ROWS ONLY;
	   END
     
       /* выборка для части "Показания счетчика" */
       SET @periodBegin = 
       (
         SELECT [R].[Time] 
         FROM #ResultPivotArchive [R] 
         ORDER BY [R].[Time] ASC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
       );
       
       -- в качестве конечной даты выберем последнюю дату из основной выборки
       -- для Взлет-26М, когда не включаем конечную дату, отступаем на одну дату 
       IF((@deviceCode = ''VZLJOT_026M'' OR @deviceCode = ''VZLJOT_024'' OR @deviceCode = ''VZLJOT_024M'') AND @includePeriodEnd = 0)
       BEGIN
          SET @periodEnd = 
          (
             SELECT [R].[Time] 
             FROM #ResultPivotArchive [R] 
             ORDER BY [R].[Time] DESC OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY
          );
       END
       ELSE
       BEGIN
         SET @periodEnd = 
         (
             SELECT [R].[Time] 
             FROM #ResultPivotArchive [R] 
             ORDER BY [R].[Time] DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
         );
       END

       SELECT * FROM #ResultPivotArchive [R]
         WHERE [R].[Time] = @periodBegin OR [R].[Time] = @periodEnd
		 ORDER BY [R].[Time];

	   IF(@deviceCode = ''KM5'' OR @deviceCode = ''RM5'')
       BEGIN
          SELECT [Id],[InternalDeviceEventId],[Time],[OriginalValue] FROM [Business].[MeasurementDeviceJournal]
              WHERE [MeasurementDeviceId] = @measurementDeviceId AND [Time] >= @periodBegin AND [Time] <= @periodEnd      
	      SELECT [DynamicParameterId],[Value] FROM [Core].[DynamicParameterValue] 
		      WHERE [DynamicParameterId] = 116 AND [EntityId] = @measurementDeviceId
       END
	   ';

    
       SET @mainDataQuery = REPLACE(@mainDataQuery, '{deviceParameterCodeFields}', @deviceParameterCodeFields);
       SET @mainDataQuery = REPLACE(@mainDataQuery, '{deviceParameterCodeFieldsWithNext}', @deviceParameterCodeFieldsWithNext);
 
       EXEC [sys].[sp_executesql] @mainDataQuery, 
    
          N'@measurementDeviceId INT, @channelId INT, @periodTypeId INT, 
          @periodBegin DATETIME, @periodEnd DATETIME, @periodTypeBeforeShift INT,
          @deviceParameterCodePull [Programmability].[CodePullTableType] READONLY,          
		  @deviceCode NVARCHAR(32), @includePeriodEnd BIT',

          @measurementDeviceId = @measurementDeviceId,
          @channelId = @channelId, 
          @periodTypeId = @periodTypeId,       
          @periodBegin = @periodBegin,
          @periodEnd = @periodEnd,
          @periodTypeBeforeShift = @periodTypeBeforeShift,
          @deviceParameterCodePull = @deviceParameterCodePull,          
		  @deviceCode = @deviceCode,
          @includePeriodEnd = @includePeriodEnd
            
      COMMIT TRANSACTION;
   END TRY
   BEGIN CATCH
       
      /* транзакция имеет активную внутреннюю ошибку и дожна быть откатится */
      IF (XACT_STATE()) = -1
      BEGIN       
        ROLLBACK TRANSACTION;
      END;

      -- !IMPORTANT
      /* транзакция валидна, но подтверждение  не наступило, 
         например в силу генерации пользовательской ошибки */ 
      IF (XACT_STATE()) = 1
      BEGIN      
        COMMIT TRANSACTION;   
      END;
          
      DECLARE @lineFeed CHAR(1) = CHAR(13);

      DECLARE @parameterListTrace NVARCHAR(256) = 
             CONCAT
             (  
                '@userName: ' ,            @userName, @lineFeed, 
                '@measurementDeviceId: ',  @measurementDeviceId, @lineFeed, 
                '@channelId: ',            @channelId, @lineFeed, 
                '@periodBegin: ',          @periodBegin, @lineFeed, 
                '@periodEnd: ',            @periodEnd, @lineFeed, 
                '@periodTypeId: ',         @periodTypeId, @lineFeed
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
      
      THROW;
   END CATCH

/**/

END;