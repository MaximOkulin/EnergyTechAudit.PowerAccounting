CREATE PROCEDURE Programmability.GetEmergencySituationSummary
  @userName NVARCHAR(32),
  @resourceSystemTypeId INT,
  @periodBegin DATETIME, 
  @periodEnd DATETIME  
AS
    SET NOCOUNT ON;

    DECLARE @empty NCHAR(1) = '';

    /* Выравнивание по границам суток входных параметров */
    SET @periodBegin = CAST( CAST( @periodBegin AS DATE ) AS DATETIME ); 
    SET @periodEnd = CAST( CAST( @periodEnd AS DATE ) AS DATETIME ); 

    /* Имена выходных резалтсетов возвращаемых в отчет */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

    INSERT INTO @resultSetName 
    OUTPUT inserted.[Order], inserted.[Name]
    VALUES
         (1, 'ReportParameter'),
         (2, 'MainData'),
         (3, 'SummaryData');         
    
    /* Формирование таблицы параметрии отчета */
    DECLARE @reportParameter [Programmability].[CustomParameterTableType]; 
   
    INSERT INTO @reportParameter
    OUTPUT inserted.[Name], inserted.[Value]
    SELECT [Name], [Value] FROM 
    (
        SELECT [Name], [Value] 
        FROM (
            SELECT 
              CAST([User].[UserName] AS NVARCHAR(128)) [UserName]
              ,CAST(ISNULL([UserInfo].[FirstName], @empty) AS NVARCHAR(128)) [FirstName]
              ,CAST(ISNULL([UserInfo].[LastName], @empty) AS NVARCHAR(128)) [LastName]
              ,CAST(ISNULL([UserInfo].[Description], @empty) AS NVARCHAR(128)) [UserInfoDescription]

            FROM [Admin].[User] [User] WITH (NOLOCK) 
            LEFT OUTER JOIN [Business].[UserAdditionalInfo] [UserInfo] WITH (NOLOCK) 
              ON [User].[Id] = [UserInfo].[Id]
            WHERE [User].[UserName] = @userName)
          [A]
          UNPIVOT
          (
            [Value] FOR [Name] IN 
            (
              [UserName], 
              [FirstName], 
              [LastName],
              [UserInfoDescription] 
            )
          ) [B]   
    ) [C]

    UNION ALL
    
    SELECT 
            'ResourceSystemTypeDescription' [Name], 
            [ResourceSystemType].[Description] [Value] 
      FROM [Dictionaries].[ResourceSystemType]  [ResourceSystemType] 
      WHERE [ResourceSystemType].[Id] = @resourceSystemTypeId
    ;
    
    /* Получаем имя и код роли пользователя */
    DECLARE @userId  INT;    
    DECLARE @roleCode NVARCHAR(64);    
  
    EXEC [Programmability].[GetUserInfo] 
          @userName = @userName, 
          @userId = @userId OUT, 
          @roleCode = @roleCode OUT;
    
  /*---------------------------*/
    /* Основная секция */     
    SELECT              
           [MainData].[MeasurementDeviceId]
           ,[MainData].[ChannelId]
           ,[MainData].[EmergencySituationParameterId]
           ,[MainData].[BuildingId]

           ,[MainData].[BuildingDescription]
           ,[MainData].[UserAdditionalInfoDescription]
           ,[MainData].[MeasurementDeviceDescription]
           ,[MainData].[EmergencySituationParameterDescription]

           ,[MainData].[EmergencyTimeSignatureFirstTime]
           ,[MainData].[EmergencyTimeSignatureLastTime]

           ,[MainData].[EmergencyLogLastRecoveryTime]
                       
           ,[MainData].[EmergencyLogCount]           
           ,[MainData].[EmergencyLogIsAcknowledgementCount]

           ,[MainData].[EmergencyLogAcknowledgementUserName]
           ,[MainData].[EmergencyLogAcknowledgementLastTime]
    FROM
    (
      SELECT 
    	  ROW_NUMBER() OVER(PARTITION BY [Channel].[Id], [EmergencySituationParameter].[Id]  ORDER BY [Channel].[Id])	Num, 
    		  
        /* Идентификаторы */
        [MeasurementDevice].[Id] [MeasurementDeviceId]
    
        , [Channel].[Id] [ChannelId]
    
        , [EmergencySituationParameter].[Id] [EmergencySituationParameterId]

        , [Building].[Id] [BuildingId]
        
        , [Building].[FullAddress] [BuildingDescription]

        /* Устройство */
        , [MeasurementDevice].[Description] [MeasurementDeviceDescription]
        , [UserAdditionalInfo].[Description] [UserAdditionalInfoDescription]

        /* Наименование НС */
        , [EmergencySituationParameter].[Description] [EmergencySituationParameterDescription]
      
        /* Время генерации первой НС [EmergencyTimeSignature].[Time]*/
        , FIRST_VALUE ( [EmergencyTimeSignature].[Time] ) OVER ( PARTITION BY [MeasurementDevice].[Id], [EmergencySituationParameter].[Id] ORDER BY [EmergencyTimeSignature].[Time] ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )  [EmergencyTimeSignatureFirstTime]
    
        /* Время генерации последней НС [EmergencyTimeSignature].[Time]*/
        , LAST_VALUE ( [EmergencyTimeSignature].[Time] ) OVER ( PARTITION BY [MeasurementDevice].[Id], [EmergencySituationParameter].[Id] ORDER BY [EmergencyTimeSignature].[Time]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )  [EmergencyTimeSignatureLastTime]
        
        /* Время последнего восстановления [EmergencyLog].[RecoveryTime] */
        , LAST_VALUE ( [EmergencyLog].[RecoveryTime] ) OVER ( PARTITION BY [MeasurementDevice].[Id], [EmergencySituationParameter].[Id] ORDER BY [EmergencyTimeSignature].[Time] ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) [EmergencyLogLastRecoveryTime]
                 
        /* Кол-во регистраций события */
        , COUNT(*) OVER ( PARTITION BY [MeasurementDevice].[Id], [EmergencySituationParameter].[Id] ORDER BY [EmergencyTimeSignature].[Time]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) [EmergencyLogCount]
      
        /* Число квитирований !!!(посчет по "конскому"  скоррелированому запросу)*/        
        ,(
          SELECT COUNT(*) 
          FROM [Business].[EmergencyLog] [InnerEmergencyLog] WITH (NOLOCK)

            INNER JOIN [Business].[EmergencySituationParameter] [InnerEmergencySituationParameter] WITH (NOLOCK)
              ON [InnerEmergencySituationParameter].[Id] = [InnerEmergencyLog].[EmergencySituationParameterId]

            INNER JOIN [Business].[Channel] [InnerChannel] WITH (NOLOCK)
    		      ON [InnerChannel].[Id] = [InnerEmergencySituationParameter].[ChannelId] AND [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId

          WHERE [InnerEmergencyLog].[EmergencySituationParameterId] = [EmergencySituationParameter].[Id] 
              AND [InnerChannel].[Id] = [Channel].[Id]
              AND [InnerEmergencyLog].[IsAcknowledgement] = 1
            -- обязательно учетываем по диапазону времени, когда было квитирование
              
              AND (ISNULL([InnerEmergencyLog].[AcknowledgementDate], '19000101') >= @periodBegin AND ISNULL([InnerEmergencyLog].[AcknowledgementDate], '19000101') <= @periodEnd)

        ) [EmergencyLogIsAcknowledgementCount]

        /* Последний квитировавший */                
        , LAST_VALUE ( [EmergencyLog].[AcknowledgementUserName] ) OVER ( PARTITION BY [MeasurementDevice].[Id], [EmergencySituationParameter].[Id] ORDER BY [EmergencyLog].[AcknowledgementDate]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)  [EmergencyLogAcknowledgementUserName]
        /* Дата последнего квитирования */
        , LAST_VALUE ( [EmergencyLog].[AcknowledgementDate] ) OVER ( PARTITION BY [MeasurementDevice].[Id], [EmergencySituationParameter].[Id] ORDER BY [EmergencyLog].[AcknowledgementDate]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)  [EmergencyLogAcknowledgementLastTime]   
        

      FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
    
        /* Каналы */
    	  INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
    		  ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id] AND [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId
        
        /* Помещение */
        INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
          ON [Placement].[Id] = [Channel].[PlacementId]
        
        /* Строение */
        INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
          ON [Building].[Id] = [Placement].[BuildingId]
        
        /* Ответственное лицо */
        LEFT JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] WITH (NOLOCK)
          ON [UserAdditionalInfo].[Id] = [Building].[UserAdditionalInfoId] 

        /* Ссылки на пользователя */
    	  INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH (NOLOCK)
    		  ON [UserLinkChannel].[ChannelId] = [Channel].[Id] AND [UserLinkChannel].[UserId] = @userId
    
         /* Нештатная ситуация*/
        INNER JOIN [Business].[EmergencySituationParameter] [EmergencySituationParameter] WITH (NOLOCK)
            ON [Channel].[Id] = [EmergencySituationParameter].[ChannelId]
      
        /* Лог нештатной ситуациий */
        INNER JOIN [Business].[EmergencyLog] [EmergencyLog] WITH (NOLOCK)
    
          ON [EmergencySituationParameter].[Id] = [EmergencyLog].[EmergencySituationParameterId] 
        
        /* Временная сигнатура лога нештатной ситуации */
        INNER JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] WITH (NOLOCK)
          ON [EmergencyTimeSignature].[Id] = [EmergencyLog].[EmergencyTimeSignatureId]
          AND ([EmergencyTimeSignature].[Time] >= @periodBegin AND [EmergencyTimeSignature].[Time] <= @periodEnd)      
    ) [MainData]
    
    WHERE [MainData].[Num] = 1

    ORDER BY [MainData].[MeasurementDeviceId], [MainData].[EmergencyTimeSignatureFirstTime]
    
    /* Сведение параллелизма к минимуму (при очень больших наборах имеет смысл пересмотреть)*/
    OPTION (MAXDOP 1);
   
   /*---------------------------*/
    /* Итоговая секция */
  
    SELECT 
      
      [SummaryData].[EmergencySituationParameterId]      
      ,[SummaryData].[EmergencySituationParameterTemplateDescription]
      ,[SummaryData].[BuildingCount]
      ,[SummaryData].[BuildingUserAdditionalInfoId]
      ,[SummaryData].[UserAdditionalInfoDescription]
      ,[SummaryData].[EmergencyLogCount]
      FROM
    (
      SELECT 
        ROW_NUMBER() OVER(PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id] ORDER BY [EmergencySituationParameterTemplate].[Id])	[Num], 
          
          [Building].[UserAdditionalInfoId] [BuildingUserAdditionalInfoId]
                       
          ,[EmergencySituationParameterTemplate].[Id] [EmergencySituationParameterTemplateId]

          ,[EmergencySituationParameter].[Id] [EmergencySituationParameterId]
          
          /*Наименование шаблона НС*/       
         ,[EmergencySituationParameterTemplate].[Description] [EmergencySituationParameterTemplateDescription]
        
         /* Количество объектов, на которых сгенерирована НС*/
         /* Вместо COUNT  по скорреллерованнму запросу  */
         ,(
            DENSE_RANK() OVER (PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id] ORDER BY [Building].[Id]) 
              + DENSE_RANK() OVER (PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id] ORDER BY [Building].[Id] DESC) 
              - 1
          ) [BuildingCount] 

          /*Кол-во объектов с действием НС на текущий момент*/
          
          /* Кол-во регистраций события */
        , COUNT(*) OVER ( PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id] ORDER BY [Building].[Id]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) [EmergencyLogCount]

          /* Ответственное лицо */
          ,[UserAdditionalInfo].[Description] [UserAdditionalInfoDescription]

        FROM [Business].[EmergencySituationParameterTemplate] [EmergencySituationParameterTemplate] WITH (NOLOCK)
        
        INNER JOIN [Business].[EmergencySituationParameter] [EmergencySituationParameter] WITH (NOLOCK)
          ON [EmergencySituationParameterTemplate].[Id] = [EmergencySituationParameter].[EmergencySituationParameterTemplateId]

        INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
          ON [Channel].[Id] = [EmergencySituationParameter].[ChannelId] AND [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId
        
        /* Ссылки на пользователя */
      	  INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH (NOLOCK)
      		  ON [UserLinkChannel].[ChannelId] = [Channel].[Id] AND [UserLinkChannel].[UserId] = @userId
  
        
        INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
          ON [Placement].[Id] = [Channel].[PlacementId]
        
        INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
          ON [Building].[Id] = [Placement].[BuildingId]
        
        LEFT JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo]  WITH (NOLOCK)
          ON [UserAdditionalInfo].[Id] = [Building].[UserAdditionalInfoId]

        INNER JOIN [Business].[EmergencyLog] [EmergencyLog] WITH (NOLOCK)
          ON [EmergencySituationParameter].[Id] = [EmergencyLog].[EmergencySituationParameterId]
  
        /* Временная сигнатура лога нештатной ситуации */
          INNER JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] WITH (NOLOCK)
            ON [EmergencyTimeSignature].[Id] = [EmergencyLog].[EmergencyTimeSignatureId]
            AND ([EmergencyTimeSignature].[Time] >= @periodBegin AND [EmergencyTimeSignature].[Time] <= @periodEnd)
    ) [SummaryData]

    WHERE [SummaryData].[Num] = 1  
    OPTION (MAXDOP 1);

    /*
      Основа для поиска  
      "Кол-во объектов с действием НС на текущий момент"
    */

  SELECT 
	   [BuildingUserAdditionalInfoId]
                       
	  ,[EmergencySituationParameterTemplateId] 
		
	  ,[BuildingId]

	  ,[EmergencySituationParameterTemplateDescription]
	
	  ,[EmergencyTimeSignatureLastTime]	

	  ,[EmergencyLogLastRecoveryTime]

	  , COUNT (*) OVER (PARTITION BY  [BuildingUserAdditionalInfoId], [EmergencySituationParameterTemplateId] ) [Count]

	  ,ROW_NUMBER() OVER (PARTITION BY  [BuildingUserAdditionalInfoId], [EmergencySituationParameterTemplateId] ORDER BY [BuildingId] ) [Num]
  FROM 
  (
	  SELECT 	
		  ROW_NUMBER() OVER
		  (
			  PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id], [Building].[Id] 
			  ORDER BY [EmergencySituationParameterTemplate].[Id]
		  ) [Num],	

		  [Building].[UserAdditionalInfoId] [BuildingUserAdditionalInfoId]
                       
		  ,[EmergencySituationParameterTemplate].[Id] [EmergencySituationParameterTemplateId] 
		
		  ,[Building].[Id] [BuildingId]

		  ,[EmergencySituationParameterTemplate].[Description] [EmergencySituationParameterTemplateDescription]

		  /* Время последеного восстановления */
		  , LAST_VALUE ( [EmergencyLog].[RecoveryTime]) 
		  OVER 
		  ( 
			  PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id], [Building].[Id] 
			  ORDER BY [EmergencyLog].[RecoveryTime]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
		  ) 
		  [EmergencyLogLastRecoveryTime]


		  /* Время генерации последней НС [EmergencyTimeSignature].[Time] */
      ,LAST_VALUE ([EmergencyTimeSignature].[Time] ) 
		  OVER 
		  ( 
			  PARTITION BY [Building].[UserAdditionalInfoId], [EmergencySituationParameterTemplate].[Id], [Building].[Id] 
			  ORDER BY [EmergencyTimeSignature].[Time]  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
		  )  [EmergencyTimeSignatureLastTime]
		
			
          FROM [Business].[EmergencySituationParameterTemplate] [EmergencySituationParameterTemplate] WITH (NOLOCK)
        
          INNER JOIN [Business].[EmergencySituationParameter] [EmergencySituationParameter] WITH (NOLOCK)
            ON [EmergencySituationParameterTemplate].[Id] = [EmergencySituationParameter].[EmergencySituationParameterTemplateId]

          INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
            ON [Channel].[Id] = [EmergencySituationParameter].[ChannelId] AND [Channel].[ResourceSystemTypeId] = 4
        
          /* Ссылки на пользователя */
      	    INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH (NOLOCK)
      		    ON [UserLinkChannel].[ChannelId] = [Channel].[Id] AND [UserLinkChannel].[UserId] = 7
          
          INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
            ON [Placement].[Id] = [Channel].[PlacementId]
        
          INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
            ON [Building].[Id] = [Placement].[BuildingId]
        
          LEFT JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo]  WITH (NOLOCK)
            ON [UserAdditionalInfo].[Id] = [Building].[UserAdditionalInfoId]

          INNER JOIN [Business].[EmergencyLog] [EmergencyLog] WITH (NOLOCK)
            ON [EmergencySituationParameter].[Id] = [EmergencyLog].[EmergencySituationParameterId]
  
          /* Временная сигнатура лога нештатной ситуации */
            INNER JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] WITH (NOLOCK)
              ON [EmergencyTimeSignature].[Id] = [EmergencyLog].[EmergencyTimeSignatureId]
              AND ([EmergencyTimeSignature].[Time] >= '20160801' AND [EmergencyTimeSignature].[Time] <= '20161220')
		
  ) [A] 
  WHERE [A].[Num] = 1

  RETURN 0;
GO