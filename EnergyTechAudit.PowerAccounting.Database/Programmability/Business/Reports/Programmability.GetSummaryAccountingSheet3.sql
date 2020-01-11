/*Старый вариант с INNER JOIN в финальной выборке*/
CREATE PROCEDURE Programmability.GetSummaryAccountingSheet3
	@userName NVARCHAR(64),
  @resourceSystemTypeId INT,
  @districtId INT,	
	@periodBegin DATETIME,
  @periodEnd DATETIME	
AS
BEGIN
	SET NOCOUNT ON;
  
	SET XACT_ABORT ON;
  
	BEGIN TRY
	
		/* все выборки в составе хранимой процедуры имеют статус "грязных" */
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		BEGIN TRANSACTION;
    
    DECLARE @isDebug BIT = 0;

    /*----------------------------------------------------------------------------------------------------*/
    /* 
      Подготовка входных параметров 
    */

    /* Получаем имя и код роли пользователя */
		DECLARE @userId  INT;    
    DECLARE @roleCode NVARCHAR(64);    

    EXEC [Programmability].[GetUserInfo] 
      @userName = @userName, 
      @userId = @userId OUT, 
      @roleCode = @roleCode OUT;
    				
    /* Выравнивание по границам суток входных параметров */
		SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME ); 
    SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME ); 
   
    /* Имена выходных резульсетов возвращаемых в отчет */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName 
    OUTPUT inserted.[Order], inserted.[Name]
    VALUES
         (1, 'ReportParameter'),
         (2, 'ReportFieldInfo'),
         (3, 'MainData');         
    /*----------------------------------------------------------------------------------------------------*/
    
    
    /*----------------------------------------------------------------------------------------------------*/
    /*
      Формирование таблицы параметрии отчета и имена полей отчета
    */
    
    /* Таблица параметрии отчета */
    
    DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
    INSERT INTO @reportParameter
         SELECT [Name], [Value]
         FROM
		      (
            SELECT                                           
               CAST([ResourceSystemType].[Code] AS NVARCHAR(128)) [ResourceSystemTypeCode],
               CAST([ResourceSystemType].[ShortName] AS NVARCHAR(128)) [ResourceSystemTypeShortName],                             
               CAST([ResourceSystemType].[Description] AS NVARCHAR(128)) [ResourceSystemTypeDescription]
  		      FROM [Dictionaries].[ResourceSystemType] [ResourceSystemType]                
  		      WHERE [ResourceSystemType].[Id] = @resourceSystemTypeId          
         ) [ReportParameterInfo]
         UNPIVOT 
         (  
            [Value] FOR [Name] IN 
            (
              [ResourceSystemTypeShortName],
              [ResourceSystemTypeCode],
              [ResourceSystemTypeDescription]              
            ) 
         ) [ReportParameter];
    
    SELECT [ReportParameter].[Name], [ReportParameter].[Value] FROM @reportParameter [ReportParameter]    
      UNION ALL   
    SELECT 'PeriodBegin' [Name], CONVERT(NVARCHAR(128), @periodBegin, 104) [Value]    
      UNION ALL    
    SELECT 'PeriodEnd' [Name], CONVERT(NVARCHAR(128), @periodEnd, 104) [Value]
      UNION ALL    
    SELECT 'User' [Name], CONVERT(NVARCHAR(128), @userName) [Value]
      UNION ALL
    SELECT 'District' [Name], [District].[Description] [Value] FROM [Dictionaries].[District] [District] WHERE [District].[Id] = @districtId 
      UNION ALL
    SELECT 'City' [Name], [City].[Description] [Value] 
      FROM [Dictionaries].[City] [City]
      INNER JOIN [Dictionaries].[District] [District] ON [City].[Id] = [District].[CityId] AND [District].[Id] = @districtId

    /* Выхлоп имен полей отчета */
    (
      SELECT 
        CONCAT([Parameter].[Code], '.Instant') [Name],
        [Parameter].[IntegrableValue] [IntegrableValue]
      FROM  [Programmability].[GetSummaryAccountingAbstractParameters] (1, @resourceSystemTypeId, @userId, @districtId) [ReportFieldInfo] 
      INNER JOIN [Dictionaries].[Parameter] [Parameter] 
          ON [Parameter].[Id] = [ReportFieldInfo].[Id]
    )
    UNION ALL
    (
      SELECT 
        CONCAT([Parameter].[Code], '.Daily') [Name],
        [Parameter].[IntegrableValue] [IntegrableValue]
      FROM  [Programmability].[GetSummaryAccountingAbstractParameters] (3, @resourceSystemTypeId, @userId, @districtId) [ReportFieldInfo] 
      INNER JOIN [Dictionaries].[Parameter] [Parameter] 
          ON [Parameter].[Id] = [ReportFieldInfo].[Id]    
    )
    UNION ALL 
    (
      SELECT 
        CONCAT([Parameter].[Code], '.FinalInstant') [Name],
        [Parameter].[IntegrableValue] [IntegrableValue]
      FROM  [Programmability].[GetSummaryAccountingAbstractParameters] (5, @resourceSystemTypeId, @userId, @districtId) [ReportFieldInfo] 
      INNER JOIN [Dictionaries].[Parameter] [Parameter] 
          ON [Parameter].[Id] = [ReportFieldInfo].[Id]
    )    
    /*----------------------------------------------------------------------------------------------------*/

        
    /*----------------------------------------------------------------------------------------------------*/
    /* 
      Уточненные предикаты диапазонов дат по типам устройств 
      с учетом времеммных смещений для суточных данных 
    */
    DECLARE @dateRangePredicate NVARCHAR(MAX) = '';
    SELECT 
      @dateRangePredicate = @dateRangePredicate 
      + CONCAT
        (
          '(',
          '(',
            '[Time]>=', '''',
            CONVERT(NVARCHAR,DATEADD(SECOND, [DeviceArchiveTimeConverter].[Interval], @periodBegin), 126 ), '''',
            ' AND ',
            '[Time]<=', '''', 
            CONVERT(NVARCHAR, DATEADD(SECOND, [DeviceArchiveTimeConverter].[Interval], @periodEnd), 126), '''',
            ') AND [Device].[Id]=', [DeviceArchiveTimeConverter].[DeviceId],
          ')'  
        )  + ' OR '
    FROM [Rules].[DeviceArchiveTimeConverter] [DeviceArchiveTimeConverter]
    WHERE EXISTS      
    (
      SELECT DISTINCT [MeasurementDevice].[DeviceId] [DeviceId] 
      FROM [Business].[MeasurementDevice] [MeasurementDevice]

      INNER JOIN [Business].[Channel]  
		  ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
	
			/* фильтр по принадлежности пользователю и по принадлежности к району */
			INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] 
				ON [UserLinkChannel].[ChannelId] = [Channel].[Id] AND [UserLinkChannel].[UserId] = @userId
		
			INNER JOIN [Business].[Placement] [Placement] 
				ON [Placement].[Id] = [Channel].[PlacementId]

			INNER JOIN [Business].[Building] [Building] 
				ON [Building].[Id] = [Placement].[BuildingId] 
					AND [Building].[DistrictId] = @districtId
      
      WHERE [MeasurementDevice].[DeviceId] = [DeviceArchiveTimeConverter].[DeviceId]

    ) AND [DeviceArchiveTimeConverter].[PeriodTypeId] = 3 ;

    
    SET @dateRangePredicate = LEFT(@dateRangePredicate, LEN(@dateRangePredicate) - 3);
    /*----------------------------------------------------------------------------------------------------*/
    

    /*----------------------------------------------------------------------------------------------------*/
		/* 
      Выборка всех возможных абстрактных параметров связанных с шаблонами каналов по пользователю и району
      и формирование строк подстановки для оператора PIVOT
    */      				        

    /*Проверка существования каналов связанных с пользователем по критерию отбора*/

    IF( EXISTS( SELECT 1 FROM [Programmability].[GetSummaryAccountingAbstractParameters] (1, @resourceSystemTypeId, @userId, @districtId) ))
    BEGIN
      /* Суточные */
      DECLARE @abstractParameterFieldsDaily NVARCHAR(MAX) = '';  
      DECLARE @abstractParameterFieldsDailyAlias NVARCHAR(MAX) = '';  
      DECLARE @abstractParameterFieldsWithNextDaily NVARCHAR(MAX) = '';  
      
      SELECT 
         @abstractParameterFieldsDaily = @abstractParameterFieldsDaily + CONCAT('[', [CodePull].[Code], ']') + ', ',       
         
         @abstractParameterFieldsDailyAlias = @abstractParameterFieldsDailyAlias 
          + CONCAT('[ArchiveDailyPivot].[',[CodePull].[Code], '] ', '[', [CodePull].[Code], '.Daily]') + ', ' 
          + CONCAT('[ArchiveDailyPivot].[',[CodePull].[Code], '.Last] ', '[', [CodePull].[Code], '.Last.Daily]') + ', ',    
              
         @abstractParameterFieldsWithNextDaily = @abstractParameterFieldsWithNextDaily 
          + CONCAT('[', [CodePull].[Code], ']') + ', ' 
  		    + CONCAT('LAST_VALUE ([', [CodePull].[Code], ']) OVER(PARTITION BY [ChannelId] ORDER BY [Time] ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) [', [CodePull].[Code], '.Last', ']')
          + ','   
      FROM [Programmability].[GetSummaryAccountingAbstractParameters] (3, @resourceSystemTypeId, @userId, @districtId) [CodePull];
          
      SET @abstractParameterFieldsDaily = LEFT(@abstractParameterFieldsDaily, LEN(@abstractParameterFieldsDaily) - 1);
      SET @abstractParameterFieldsDailyAlias = LEFT(@abstractParameterFieldsDailyAlias, LEN(@abstractParameterFieldsDailyAlias) - 1);
      SET @abstractParameterFieldsWithNextDaily = LEFT(@abstractParameterFieldsWithNextDaily, LEN(@abstractParameterFieldsWithNextDaily) - 1);
          
      /* Итоговые */
      DECLARE @abstractParameterFieldsFinalInstant NVARCHAR(MAX) = '';
      DECLARE @abstractParameterFieldsFinalInstantAlias NVARCHAR(MAX) = '';
  
      SELECT 
        @abstractParameterFieldsFinalInstant = @abstractParameterFieldsFinalInstant + CONCAT('[', [CodePull].[Code], ']') + ', ',
  
        @abstractParameterFieldsFinalInstantAlias = @abstractParameterFieldsFinalInstantAlias 
          + CONCAT('[ArchiveFinalInstantPivot].[',[CodePull].[Code], '] ', '[', [CodePull].[Code], '.FinalInstant]') + ', '
         
      FROM [Programmability].[GetSummaryAccountingAbstractParameters] (5, @resourceSystemTypeId, @userId, @districtId) [CodePull];
          
      SET @abstractParameterFieldsFinalInstant = LEFT(@abstractParameterFieldsFinalInstant, LEN(@abstractParameterFieldsFinalInstant) - 1);
      SET @abstractParameterFieldsFinalInstantAlias = LEFT(@abstractParameterFieldsFinalInstantAlias, LEN(@abstractParameterFieldsFinalInstantAlias) - 1);
      
      /* Мгновенные */
      DECLARE @abstractParameterFieldsInstant NVARCHAR(MAX) = '';   
      DECLARE @abstractParameterFieldsInstantAlias  NVARCHAR(MAX) = '';
         
      SELECT 
         @abstractParameterFieldsInstant = @abstractParameterFieldsInstant + CONCAT('[', [CodePull].[Code], ']') + ', ',
  
         @abstractParameterFieldsInstantAlias = @abstractParameterFieldsInstantAlias 
          + CONCAT('[ArchiveInstantPivot].[',[CodePull].[Code], '] ', '[', [CodePull].[Code], '.Instant]') + ', '
            
      FROM [Programmability].[GetSummaryAccountingAbstractParameters] (1, @resourceSystemTypeId, @userId, @districtId) [CodePull];
          
      SET @abstractParameterFieldsInstant = LEFT(@abstractParameterFieldsInstant, LEN(@abstractParameterFieldsInstant) - 1);
      SET @abstractParameterFieldsInstantAlias = LEFT(@abstractParameterFieldsInstantAlias, LEN(@abstractParameterFieldsInstantAlias) - 1);  
    
    END
    ELSE
    BEGIN
      SELECT [Unknown] FROM ( SELECT NULL [Unknown] ) [MainData] WHERE 1 != 1
    END;

    /*----------------------------------------------------------------------------------------------------*/

  
    /*----------------------------------------------------------------------------------------------------*/
    /* 
      Динамический скрипт с набором CTE для базовых выборок со диапазону суточных данных, 
      последних текущих итоговых и мгновенных данных
    */
	  DECLARE @mainDataQuery NVARCHAR(MAX) =     
    '
    /* Суточные значения за заданный диапазон */
    WITH [ArchiveDaily]
    AS
    (
      SELECT                     
       [Channel].[Id] [ChannelId],
			 [Archive].[Time] [Time],        
  		 [Parameter].[Code] [ParameterCode]           
			 ,[dbo].[ConvertMeasurementUnit]
			  (
				  [Dimension].[Value], 
				  [Muc].[DimensionValue2], 
				  [Archive].[Value], 
				  [Muc].[Expression]
			  ) [Value]
		  FROM [Business].[Archive] [Archive]
			
			INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice]
				ON  [MeasurementDevice].[Id] = [Archive].[MeasurementDeviceId]

			INNER JOIN [Business].[Channel] [Channel]
				ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
			
			/* привязка к шаблону и фильтр по типу ресурсной системы */
			INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate]
				ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId] 
					AND [ChannelTemplate].[ResourceSystemTypeId] = @resourceSystemTypeId

			INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter]
				ON [DeviceParameter].[Id] = [Archive].[DeviceParameterId]
      
    INNER JOIN [Dictionaries].[Device] [Device]
				ON [Device].[Id] = [DeviceParameter].[DeviceId]
         
			INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]
				ON [ParameterMapDeviceParameter].[DeviceParameterId] = [DeviceParameter].[Id] 
					AND [ParameterMapDeviceParameter].[ChannelTemplateId] = [ChannelTemplate].[Id]					
		      AND [ParameterMapDeviceParameter].[PeriodTypeId] = 3

			INNER JOIN [Dictionaries].[Dimension] [Dimension]
				ON [ParameterMapDeviceParameter].[DimensionId] = [Dimension].[Id]

			INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit]
				ON [ParameterMapDeviceParameter].[MeasurementUnitId] = [MeasurementUnit].[Id]

			/* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
			LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc] 			
				ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 

			/* фильтр по принадлежности пользователю и по принадлежности к району */
			INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel]
				ON [UserLinkChannel].[ChannelId] = [Channel].[Id] 
					AND [UserLinkChannel].[UserId] = @userId
			
			INNER JOIN [Business].[Placement] [Placement]
				ON [Placement].[Id] = [Channel].[PlacementId]

			INNER JOIN [Business].[Building] [Building]
				ON [Building].[Id] = [Placement].[BuildingId] 
					AND [Building].[DistrictId] = @districtId
			/**/

			INNER JOIN [Dictionaries].[Parameter] [Parameter]
				ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId]

      WHERE 
        [Archive].[PeriodTypeId] = 3 AND ({dateRangePredicate})     
    ),

    /* Итоговые значения */
    [ArchiveFinalInstant]
    AS
    (
      SELECT       
       [Channel].[Id] [ChannelId],
       [Parameter].[Id] [ParameterId], 			        
  		 [Parameter].[Code] [ParameterCode]               
			 ,[dbo].[ConvertMeasurementUnit]
			  (
				  [Dimension].[Value], 
				  [Muc].[DimensionValue2], 
				  [Archive].[Value], 
				  [Muc].[Expression]
			  ) [Value]
		  FROM [Business].[Archive] [Archive]
			
			INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice]
				ON  [MeasurementDevice].[Id] = [Archive].[MeasurementDeviceId]

			INNER JOIN [Business].[Channel] [Channel]
				ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
			
			/* привязка к шаблону и фильтр по типу ресурсной системы */
			INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate]
				ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId] 
					AND [ChannelTemplate].[ResourceSystemTypeId] = @resourceSystemTypeId

			INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter]
				ON [DeviceParameter].[Id] = [Archive].[DeviceParameterId]
      
    INNER JOIN [Dictionaries].[Device] [Device]
				ON [Device].[Id] = [DeviceParameter].[DeviceId]
         
			INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]
				ON [ParameterMapDeviceParameter].[DeviceParameterId] = [DeviceParameter].[Id] 
					AND [ParameterMapDeviceParameter].[ChannelTemplateId] = [ChannelTemplate].[Id]					          
		      AND [ParameterMapDeviceParameter].[PeriodTypeId] = 5 

			INNER JOIN [Dictionaries].[Dimension] [Dimension]
				ON [ParameterMapDeviceParameter].[DimensionId] = [Dimension].[Id]

			INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit]
				ON [ParameterMapDeviceParameter].[MeasurementUnitId] = [MeasurementUnit].[Id]

			/* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
			LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc] 			
				ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 

			/* фильтр по принадлежности пользователю и по принадлежности к району */
			INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel]
				ON [UserLinkChannel].[ChannelId] = [Channel].[Id] 
					AND [UserLinkChannel].[UserId] = @userId
			
			INNER JOIN [Business].[Placement] [Placement]
				ON [Placement].[Id] = [Channel].[PlacementId]

			INNER JOIN [Business].[Building] [Building]
				ON [Building].[Id] = [Placement].[BuildingId] 
					AND [Building].[DistrictId] = @districtId
			/**/

			INNER JOIN [Dictionaries].[Parameter] [Parameter]
				ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId]

      WHERE 
        [Archive].[PeriodTypeId] = 5         
        AND [Archive].[TimeSignatureId] = [MeasurementDevice].[LastTimeSignatureId]                  
    ),
    
    /* Мгновенные значения */
    [ArchiveInstant]
    AS
    (
      SELECT         
       [Channel].[Id] [ChannelId],
       [Parameter].[Id] [ParameterId], 			 
  		 [Parameter].[Code] [ParameterCode]       
			 ,[dbo].[ConvertMeasurementUnit]
			  (
				  [Dimension].[Value], 
				  [Muc].[DimensionValue2], 
				  [Archive].[Value], 
				  [Muc].[Expression]
			  ) [Value]
		  FROM [Business].[Archive] [Archive]
			
			INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] 
				ON  [MeasurementDevice].[Id] = [Archive].[MeasurementDeviceId]

			INNER JOIN [Business].[Channel] [Channel]
				ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]
			
			/* привязка к шаблону и фильтр по типу ресурсной системы */
			INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate]
				ON [ChannelTemplate].[Id] = [Channel].[ChannelTemplateId] 
					AND [ChannelTemplate].[ResourceSystemTypeId] = @resourceSystemTypeId

			INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter]
				ON [DeviceParameter].[Id] = [Archive].[DeviceParameterId]
      
    INNER JOIN [Dictionaries].[Device] [Device]
				ON [Device].[Id] = [DeviceParameter].[DeviceId]
         
			INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter]
				ON [ParameterMapDeviceParameter].[DeviceParameterId] = [DeviceParameter].[Id] 
					AND [ParameterMapDeviceParameter].[ChannelTemplateId] = [ChannelTemplate].[Id]					
		      AND [ParameterMapDeviceParameter].[PeriodTypeId] = 1        

			INNER JOIN [Dictionaries].[Dimension] [Dimension]
				ON [ParameterMapDeviceParameter].[DimensionId] = [Dimension].[Id]

			INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit]
				ON [ParameterMapDeviceParameter].[MeasurementUnitId] = [MeasurementUnit].[Id]

			/* только те записи из конвертора для которых входная соотвествует архивной (исходной)*/
			LEFT OUTER JOIN [Programmability].[MeasurementUnitConverterWithDefaultMeasurementUnitView] [Muc] 			
				ON [MeasurementUnit].[Id] = [Muc].[MeasurementUnit1Id] 

			/* фильтр по принадлежности пользователю и по принадлежности к району */
			INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel]
				ON [UserLinkChannel].[ChannelId] = [Channel].[Id] 
					AND [UserLinkChannel].[UserId] = @userId
			
			INNER JOIN [Business].[Placement] [Placement]
				ON [Placement].[Id] = [Channel].[PlacementId]

			INNER JOIN [Business].[Building] [Building]
				ON [Building].[Id] = [Placement].[BuildingId] 
					AND [Building].[DistrictId] = @districtId
			/**/

			INNER JOIN [Dictionaries].[Parameter] [Parameter]
				ON [Parameter].[Id] = [ParameterMapDeviceParameter].[ParameterId]

      WHERE 
        [Archive].[PeriodTypeId] = 1         
        AND [Archive].[TimeSignatureId] = [MeasurementDevice].[LastTimeSignatureId]                 
    ),

    /* Разворот суточных данных с добавлением данных из последней строки диапазона */
  	[ArchiveDailyPivot]
    AS
    (
    	 SELECT *
       FROM (
            SELECT 
              ROW_NUMBER() OVER (PARTITION BY [ChannelId] ORDER BY [ChannelId], [Time]) [Num],              
              [ChannelId], 
              [Time] [Time.Daily],
              LAST_VALUE([Time]) OVER(PARTITION BY [ChannelId] ORDER BY [Time] ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) [Time.Last.Daily],
              {abstractParameterFieldsWithNextDaily}          
            FROM
              (
                SELECT                   
                  [ChannelId], 
                  [Time], 
                  {abstractParameterFieldsDaily}           
                FROM [ArchiveDaily]
                    PIVOT
                    (
                      AVG([Value])
                      FOR [ParameterCode] IN ( {abstractParameterFieldsDaily} )                  
                    ) [MainData]
                
              ) [PrePivotArchive]                                 
           ) [PivotData]
          WHERE [PivotData].[Num] = 1
        ),

        /* Извлечение последнего итогового значения и разворот */
        [ArchiveFinalInstantPivot]
        AS
        (
          SELECT [ChannelId], {abstractParameterFieldsFinalInstant} FROM
          (
            SELECT [ChannelId], [ParameterCode], [Value]
            FROM    
            (
              SELECT 
                ROW_NUMBER() OVER
                  (
                    PARTITION BY [ArchiveFinalInstant].[ChannelId], [ArchiveFinalInstant].[ParameterId] 
                    ORDER BY [ArchiveFinalInstant].[ChannelId]
                  ) [Num], 
                *
              FROM [ArchiveFinalInstant]             
            ) 
            [ArchiveFinalInstant]  WHERE [Num] = 1
          ) [MainData] 
          PIVOT
          (
            AVG([Value])
            FOR [ParameterCode] IN ( {abstractParameterFieldsFinalInstant} )                  
          ) [PivotData] 
        ),
        
        /* Извлечение последнего мгновенного значения и разворот */
        [ArchiveInstantPivot]
        AS
        (     
            SELECT [ChannelId],  {abstractParameterFieldsInstant} FROM
            (
              SELECT [ChannelId], [ParameterCode], [Value]
              FROM    
              (
                SELECT 
                  ROW_NUMBER() OVER
                    (
                      PARTITION BY [ArchiveInstant].[ChannelId], [ArchiveInstant].[ParameterId] 
                      ORDER BY [ArchiveInstant].[ChannelId]
                    ) [Num], 
                  *
                FROM [ArchiveInstant]             
              ) 
              [ArchiveInstant]  WHERE [Num] = 1

            ) [MainData]
            PIVOT
            (
              AVG([Value])
              FOR [ParameterCode] IN ( {abstractParameterFieldsInstant} )                  
            ) [PivotData]   
        )
      /**/
      
      /* Итоговые выборки с разыменованным набором полей */ 
      ,[ArchiveDailyPivotSummary] AS
      (
         SELECT           
          [ArchiveDailyPivot].[ChannelId], 
          [ArchiveDailyPivot].[Time.Daily],
          [ArchiveDailyPivot].[Time.Last.Daily],
          {abstractParameterFieldsDailyAlias}
         FROM [ArchiveDailyPivot]          
      ) 
      ,[ArchiveFinalInstantPivotSummary] AS
      (
         SELECT                     
          [ChannelId],            
          {abstractParameterFieldsFinalInstantAlias} 
         FROM [ArchiveFinalInstantPivot] 
      )
      ,[ArchiveInstantPivotSummary] AS
      (        
         SELECT                         
          [ChannelId],           
          {abstractParameterFieldsInstantAlias} 
         FROM [ArchiveInstantPivot]
      )
      /**/
            
       SELECT         
        
        [Building].[Description] [BuildingDescription],
        [MeasurementDevice].[Description] [MeasurementDeviceDescription],
        [MeasurementDevice].[NetworkAddress] [MeasurementDeviceNetworkAddress],
        --[MeasurementDevice].[LastConnectionTime],
        [TimeSignature].[Time] [LastConnectionTime],

        [StatusConnection].[Description] [StatusConnectionDescription],
        [Organization].[Description] [OrganizationDescription],
        [TopChannelLinkAgreementParameter].[Value] [AgreementParameterValue],
        [TechnologicAdjunctionType].[Description] [TechnologicAdjunctionTypeDescription],

        [ArchiveDailyPivotSummary].*, 
        [ArchiveFinalInstantPivotSummary].*, 
        [ArchiveInstantPivotSummary].*

       FROM [ArchiveDailyPivotSummary] 
      
       INNER JOIN [ArchiveFinalInstantPivotSummary] 
          ON [ArchiveFinalInstantPivotSummary].[ChannelId] = [ArchiveDailyPivotSummary].[ChannelId]

       INNER JOIN [ArchiveInstantPivotSummary]
          ON [ArchiveInstantPivotSummary].[ChannelId] = [ArchiveDailyPivotSummary].[ChannelId]
       
       INNER JOIN [Business].[Channel] [Channel]
          ON [Channel].[Id] = [ArchiveFinalInstantPivotSummary].[ChannelId]

       INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice]
          ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

        
       INNER JOIN [Business].[TimeSignature] [TimeSignature]
          ON [TimeSignature].[Id] = [MeasurementDevice].[LastTimeSignatureId]
       
       INNER JOIN [Business].[Placement] [Placement]
				  ON [Placement].[Id] = [Channel].[PlacementId]

			 INNER JOIN [Business].[Building] [Building]
				  ON [Building].[Id] = [Placement].[BuildingId]
       
       INNER JOIN [Dictionaries].[StatusConnection] [StatusConnection] 
          ON [StatusConnection].[Id] = [MeasurementDevice].[LastStatusConnectionId]
             
       INNER JOIN [Dictionaries].[TechnologicAdjunctionType] [TechnologicAdjunctionType] 
          ON [TechnologicAdjunctionType].[Id] = [Channel].[TechnologicAdjunctionTypeId]
              
       LEFT JOIN [Business].[Organization] [Organization]
          ON [Organization].[Id] = [Channel].[OrganizationId]
       
       OUTER APPLY 
       (
          SELECT TOP 1 [AgreementParameter].[Value] [Value]
          FROM [Business].[ChannelLinkAgreementParameter] [ChannelLinkAgreementParameter]
        
          INNER JOIN [Business].[AgreementParameter] [AgreementParameter] 
            ON [AgreementParameter].[Id] = [ChannelLinkAgreementParameter].[AgreementParameterId]
               
          INNER JOIN [Dictionaries].[AgreementParameterType] [AgreementParameterType] 
            ON [AgreementParameterType].[Id] = [AgreementParameter].[AgreementParameterTypeId] 

          WHERE [ChannelLinkAgreementParameter].[ChannelId] = [ArchiveDailyPivotSummary].[ChannelId]
          AND 
          (
            ([AgreementParameter].[AgreementParameterTypeId] = 1 AND @resourceSystemTypeId = 4) OR 
            ([AgreementParameter].[AgreementParameterTypeId] = 2 AND @resourceSystemTypeId = 3)
          )

       ) [TopChannelLinkAgreementParameter]

    ';
     /*----------------------------------------------------------------------------------------------------*/


     /*----------------------------------------------------------------------------------------------------*/ 
     /* Подстановки необходимых строк в динамический скрипт */ 
	   SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsDaily}', @abstractParameterFieldsDaily);
     SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsWithNextDaily}', @abstractParameterFieldsWithNextDaily);           
     SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsFinalInstant}', @abstractParameterFieldsFinalInstant);     
     SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsInstant}', @abstractParameterFieldsInstant);

     SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsDailyAlias}', @abstractParameterFieldsDailyAlias);
     SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsFinalInstantAlias}', @abstractParameterFieldsFinalInstantAlias);
     SET @mainDataQuery = REPLACE(@mainDataQuery, '{abstractParameterFieldsInstantAlias}', @abstractParameterFieldsInstantAlias);

     SET @mainDataQuery = REPLACE(@mainDataQuery, '{dateRangePredicate}', @dateRangePredicate);
     
      
     /* Вызываем динамически сформированный скрипт */ 
     EXEC [sys].[sp_executesql] @mainDataQuery,     
          N'@userId INT, 
            @districtId INT,             
            @resourceSystemTypeId INT,
            @periodBegin DATETIME, 
            @periodEnd DATETIME',

            @userId = @userId,
            @districtId = @districtId,            
            @resourceSystemTypeId = @resourceSystemTypeId,
            @periodBegin = @periodBegin,
            @periodEnd = @periodEnd;
      /*----------------------------------------------------------------------------------------------------*/

    COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
      PRINT ERROR_MESSAGE();
      
      /* транзакция имеет активную внутреннюю ошибку и дожна быть откатится */
      IF (XACT_STATE()) = -1
      BEGIN       
        ROLLBACK TRANSACTION;
      END;
      
      -- !IMPORTANT
      /* транзакция валидна, но подтверждение  не наступило, 	например в силу генерации пользовательской ошибки */ 
      IF (XACT_STATE()) = 1
      BEGIN      
        COMMIT TRANSACTION;   
      END;

      IF (@isDebug = 0)
      BEGIN

        DECLARE @lineFeed CHAR(1) = CHAR(13);
        
        DECLARE @parameterListTrace NVARCHAR(256) = 
        CONCAT
        (  
          '@userName: ' ,            @userName, @lineFeed, 
          '@resourceSystemTypeId: ', @resourceSystemTypeId, @lineFeed, 
          '@districtId: ',           @districtId, @lineFeed, 
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
        
        THROW;
      END;

	END CATCH;

END;
GO