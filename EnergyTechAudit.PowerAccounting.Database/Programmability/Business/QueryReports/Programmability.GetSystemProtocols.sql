CREATE PROCEDURE Programmability.GetSystemProtocols
	@userName NVARCHAR(64),
	@periodBegin DATETIME = NULL,
	@periodEnd DATETIME = NULL,
	@intervalByDay INT = 31,
	@protocolType NVARCHAR(16) = 'EntityHistory',
	@entityCodeArray NVARCHAR(MAX),
	@selectAllEntity BIT
AS

BEGIN
 
  SET NOCOUNT ON;
  
  IF (@intervalByDay != 0)
  BEGIN

    SET @periodBegin = CAST(DATEDIFF(DAY, @intervalByDay, GETDATE()) AS DATETIME);
    
    /* в течении суток */
    IF(@intervalByDay = -1)
    BEGIN
      SET @periodBegin = CAST(CAST (GETDATE() AS DATE) AS DATETIME);
    END;

    SET @periodEnd = GETDATE();
  END;
  
  DECLARE @userId INT;  
  DECLARE @roleCode NVARCHAR(64);
  EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;
  
  /* 1. Формирование имен резалтсетов для отчета*/
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
   INSERT INTO @resultSetName VALUES 
       (1, 'MainData')
      ,(2, 'ColumnCaption');
   
   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	   FROM @resultSetName [ResultSetName];
  /**/

  /* 2. Основная выборка данных */  
  
  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType] ;

  IF(@protocolType = 'EntityHistory')
  BEGIN
    SELECT  [EntityHistory].[Id]
           ,[EntityHistory].[EntityId]
           ,[EntityHistory].[EntityTypeName]
           ,[EntityHistory].[EntityTypeDescription]
           ,[EntityHistory].[PropertyName]
           ,[EntityHistory].[PropertyDescription]
           ,[EntityHistory].[OriginalValue]
           ,[EntityHistory].[CurrentValue]
           ,[EntityHistory].[User]
           ,[EntityHistory].[DateTime] 
      FROM [Admin].[EntityHistory] [EntityHistory] WITH (NOLOCK)
  
      WHERE 
        ([EntityHistory].[User] = @userName OR @roleCode = N'ADMIN') AND 
        ([EntityHistory].[DateTime] BETWEEN @periodBegin AND @periodEnd) AND 

        -- убираем дискрипционную "паразитку"
        NOT ([EntityHistory].[CurrentValue] = [EntityHistory].[OriginalValue] AND [EntityHistory].[PropertyName] = 'Description')
        AND 
        (
          [EntityHistory].[EntityTypeName] IN
          (
             SELECT CONVERT(NVARCHAR(64), [Item]) [EnyityCode]
             FROM [Business].[StringSplitToArray]  (@entityCodeArray, ',')
          ) 
          OR @selectAllEntity = 1
        )
        ORDER BY [EntityHistory].[DateTime] DESC;
        
      INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES
        ('MainData', 'Id', 'Ид', 0, 1),	        
        ('MainData', 'EntityTypeName', 'Ид типа', 1, 2),
        ('MainData', 'EntityTypeDescription', 'Наименование типа', 1, 3),
        ('MainData', 'EntityId', 'Ид сущности', 1, 4),    
        ('MainData', 'PropertyName', 'Ид свойства', 1, 5),
        ('MainData', 'PropertyDescription', 'Наименование свойства', 1, 6),
        ('MainData', 'OriginalValue', 'Исходное значение', 1, 7),
        ('MainData', 'CurrentValue', 'Текущее значение', 1, 8),
        ('MainData', 'User', 'Пользователь', 1, 9),
        ('MainData', 'DateTime', 'Дата и время', 1, 10);
  END  

  ELSE IF (@protocolType = 'DeletedEntity')
  BEGIN
    SELECT 
      [DeletedEntityLogEntry].[Id]
      ,[DeletedEntityLogEntry].[EntityId]
      ,[DeletedEntityLogEntry].[EntityDescription]
      ,[DeletedEntityLogEntry].[EntityTypeName]
      ,[DeletedEntityLogEntry].[EntityTypeDescription]
      
      ,[DeletedEntityLogEntry].[User]
      ,[DeletedEntityLogEntry].[DateTime]   
    FROM [Admin].[DeletedEntityLogEntry] [DeletedEntityLogEntry] WITH (NOLOCK)

    WHERE 
        ([DeletedEntityLogEntry].[User] = @userName OR @roleCode = N'ADMIN') AND 
        ([DeletedEntityLogEntry].[DateTime] BETWEEN @periodBegin AND @periodEnd)
        AND 
        (
          [DeletedEntityLogEntry].[EntityTypeName] IN
          (
             SELECT CONVERT(NVARCHAR(64), [Item]) [EnyityCode]
             FROM [Business].[StringSplitToArray]  (@entityCodeArray, ',')
          ) 
          OR @selectAllEntity = 1
        )

        ORDER BY [DeletedEntityLogEntry].[DateTime] DESC;

    INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES
        ('MainData', 'Id', 'Ид', 0, 1),	        
        ('MainData', 'EntityTypeName', 'Ид типа', 1, 2),
        ('MainData', 'EntityTypeDescription', 'Наименование типа', 1, 3),
        ('MainData', 'EntityId', 'Ид сущности', 1, 4),
        ('MainData', 'EntityDescription', 'Наименование сущности', 1, 5),        
        ('MainData', 'User', 'Пользователь', 1, 6),
        ('MainData', 'DateTime', 'Дата и время', 1, 7);
  END

  ELSE IF (@protocolType = 'CreatedBy')
  BEGIN 
    
    DECLARE @queries NVARCHAR(MAX);

    SELECT @queries = STUFF(CAST((
      SELECT [text()] = 'UNION ALL ' + 
		'('
		    +'SELECT ' 
			+ CAST([EntityOrder] AS NVARCHAR(4)) +' [EntityOrder], ' 
			+ '''' + [EntityTypeName] + ''' [EntityTypeName], '
			+ '''' + [EntityTypeDescription] + ''' [EntityTypeDescription]'
			+ ' ,[Entity].[Id] [EntityId]' + 
            IIF
    		(	
    			EXISTS -- Does it have Description property?  
    			(
    				SELECT 1 
    				FROM Core.[Entity] [EntityInfo]
    				WHERE 
    					EXISTS
    					(
    						SELECT 1 
    						FROM Core.[EntityProperty] [EntityPropertyInfo] 
    						WHERE 
								[EntityPropertyInfo].[PropertyName] = 'Description' 
								AND [EntityPropertyInfo].[EntityId] = [EntityInfo].[Id]
    					)
    					AND [EntityInfo].[Code] = [EntityTypeName]
    			),			
    			' ,[Entity].[Description] [EntityDescription]',
    			' ,NULL [EntityDescription]'				
    		  )         
              + ' ,[Entity].[CreatedBy] [User]'
    		  + ' ,[Entity].[CreatedDate] [DateTime] ' 
    		  + 'FROM [' + [EntityScheme] + '].[' + [EntityTypeName] + '] [Entity] WITH (NOLOCK)'
    		  + ' WHERE ([Entity].[CreatedBy] = @userName OR @roleCode = N''ADMIN'') AND ([Entity].[CreatedDate] BETWEEN @periodBegin AND @periodEnd)'
          + ')' 
      FROM 
      (        
          SELECT      
          [Entity].[Id] [EntityOrder]
          ,[Entity].[Schema] [EntityScheme]
          ,[Entity].[Code] [EntityTypeName]
          ,[Entity].[Description] [EntityTypeDescription]
          
          FROM [Core].[Entity] [Entity] 
          
          WHERE [Entity].[Code] IN 
          (
              SELECT CONVERT(NVARCHAR(64), [Item]) [EnyityCode]
                FROM [Business].[StringSplitToArray]  (@entityCodeArray, ',')
          )                         
      ) [Entity]
    
    FOR XML PATH(''), TYPE) AS NVARCHAR(MAX)), 1, 9, '')
    
    SET @queries = 
      'SELECT  
          ROW_NUMBER() OVER(ORDER BY [EntityOrder]) [Id]
          ,[Entity].[EntityTypeName]
          ,[Entity].[EntityTypeDescription]
          ,[Entity].[EntityId]
          ,[Entity].[EntityDescription]
          ,[Entity].[User] 
          ,[Entity].[DateTime]      
        FROM
        ( ' + @queries + ') [Entity] ORDER BY [Entity].[DateTime] DESC';

    IF(@queries IS NULL)
    BEGIN

      DECLARE @emptyStub NVARCHAR(MAX) = 
        'SELECT *
        FROM 
          (
            SELECT  
                   NULL [Id]
                  ,NULL [EntityTypeName]
                  ,NULL [EntityTypeDescription]
                  ,NULL [EntityId]
                  ,NULL [EntityDescription]
                  ,NULL [User] 
                  ,NULL [DateTime]                       
          ) [Entity] 
        WHERE NULL IS NOT NULL';
                 
      SET @queries = @emptyStub;
    END;
         
    EXEC [sys].[sp_executesql] 
      @queries,
      N'@userName NVARCHAR(32), @roleCode NVARCHAR(32), @periodBegin DATETIME, @periodEnd DATETIME',
      @userName = @userName, 
      @roleCode = @roleCode, 
      @periodBegin = @periodBegin, 
      @periodEnd = @periodEnd 
    ;

    INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES
        ('MainData', 'Id', 'Ид', 0, 1),	        
        ('MainData', 'EntityTypeName', 'Ид типа', 1, 2),
        ('MainData', 'EntityTypeDescription', 'Наименование типа', 1, 3),
        ('MainData', 'EntityId', 'Ид сущности', 1, 4),
        ('MainData', 'EntityDescription', 'Наименование сущности', 1, 5),        
        ('MainData', 'User', 'Пользователь', 1, 6),
        ('MainData', 'DateTime', 'Дата и время', 1, 7);
  END

  ELSE IF(@protocolType = 'ErrorLog')
  BEGIN
  	SELECT        
      [Err].[UserName] [User]
      ,[Err].[Time] [DateTime]      
      ,[Err].[Exception]
      
      ,IIF( LEN([Err].[Message]) > 128, [dbo].[GetGridHyperlink] 
      (
            'ErrorLogEntry', 
            'Message', 
            [Err].[Id], 
            'show-largetext', 
            'Сообщение...'
      ), [Err].[Message]) [Message] 

      ,[Err].[UserAgent]      
      ,[dbo].[GetGridHyperlink] 
      (
            'ErrorLogEntry', 
            'StackTrace', 
            [Err].[Id], 
            'show-largetext', 
            'Трассировка стека...'
      ) [StackTrace]
      ,[dbo].[GetGridHyperlink] 
      (
            'ErrorLogEntry', 
            'RequestParams', 
            [Err].[Id], 
            IIF( [Err].[RequestParams] IS NOT NULL, 'show-largetext', ''),
            'Параметры запроса...'
      ) [RequestParams]       

     FROM [Admin].[ErrorLogEntry] [Err] WITH (NOLOCK)
    
     WHERE  
        ([Err].[UserName] = @userName OR @roleCode = N'ADMIN') AND 
        ([Err].[Time] BETWEEN @periodBegin AND @periodEnd)

     ORDER BY [Err].[Time] DESC
         
    INSERT INTO @columnCaption 
    OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
    VALUES  
    	 ('MainData', 'User', 'Пользователь', 1, 1)    	
    	,('MainData', 'Exception', 'Исключение', 1, 3)
      ,('MainData', 'Message', 'Сообщение', 1, 4)
      ,('MainData', 'UserAgent', 'Браузер', 1, 5)
      ,('MainData', 'StackTrace', 'Стек', 1, 6)
      ,('MainData', 'RequestParams', 'Параметры запроса', 1, 7)
      ,('MainData', 'DateTime', 'Время', 1, 7);    
  END

  ELSE IF(@protocolType = 'Audit')
  BEGIN
    SELECT 
      [Audit].[Id] [Id], 
      [Role].[Code] [Role],
      [User].[UserName] [UserName],
      [Audit].[Time] [Time],
      [Audit].[Elapsed] [Elapsed],
      
      [Audit].[Area],
      [Audit].[Controller],
      [Audit].[Action] [Action],

      IIF( LEN([Audit].[ActionParams]) > 128, [dbo].[GetGridHyperlink] 
      (
            'Audit', 
            'ActionParams', 
            [Audit].[Id], 
            'show-largetext', 
            'Параметры действия...'
      ), [Audit].[ActionParams]) [ActionParams] 

      
    FROM [Admin].[Audit] [Audit] WITH (NOLOCK)
      INNER JOIN [Admin].[User] [User] WITH (NOLOCK) ON [Audit].[UserId] = [User].[Id]
      INNER JOIN [Admin].[Role] [Role] WITH (NOLOCK) ON [Role].[Id] = [User].[RoleId]
      
    WHERE  
      ([User].[UserName] = @userName OR @roleCode = N'ADMIN') AND 
      ([Audit].[Time] BETWEEN @periodBegin AND @periodEnd)

    ORDER BY [Audit].[Time] DESC

  
    INSERT INTO @columnCaption 
    OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
    VALUES  
  	  ('MainData', 'Id', 'Ид', 1, 1)
  	  ,('MainData', 'Role', 'Роль', 1, 2)
  	  ,('MainData', 'UserName', 'Пользователь', 1, 3)  	  
  	  ,('MainData', 'Elapsed', 'Время исполнения', 1, 5)
      ,('MainData', 'Area', 'Область', 1, 6)
  	  ,('MainData', 'Controller', 'Контроллер', 1, 7)
  	  ,('MainData', 'Action', 'Действие', 1, 8)
  	  ,('MainData', 'ActionParams', 'Параметры действия', 1, 8)
      ,('MainData', 'Time', 'Время', 1, 9)
  END;

END;
GO