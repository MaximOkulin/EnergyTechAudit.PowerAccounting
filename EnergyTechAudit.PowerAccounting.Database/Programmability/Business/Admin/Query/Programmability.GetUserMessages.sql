-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2015-02-18
-- Description: Выборка из таблицы сообщений
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetUserMessages]  
  @userName NVARCHAR(32)  
AS

BEGIN
   SET NOCOUNT ON;

   /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

   INSERT INTO @resultSetName VALUES
	   (1, 'MainData'),		   -- стандартное имя набора для отображения в решетке
	   (2, 'ColumnCaption');	-- набор с необязательной расшифровкой расшифровка имен столбцов наборов
  
   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName]

  /**/
  DECLARE @monthCount INT = 1;

  /*2. Основная выборка */
   
   DECLARE @eoMonth DATETIME = EOMONTH(GETDATE());
   
   SET @eoMonth = DATEADD(second, 86399,  @eoMonth);

   DECLARE @soMonth DATETIME =
   (
     SELECT DATEADD(month, DATEDIFF(month, 0, DATEADD(month, - (@monthCount -1 ), GETDATE())), 0)
   );

  DECLARE @userId INT;
  DECLARE @roleCode NVARCHAR(64);

  EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

  DECLARE @requestRoleCode NVARCHAR(64) = IIF (@roleCode = 'OPERADMIN', 'HOLDER', NULL);
  -- ([Ci].[Id] = @cityId OR @cityId IS NULL) 

  SELECT        
      [Role].[Code] [RoleCode]
      ,[User].[UserName]
      ,[UserMessage].[Date]                        
      ,[dbo].[GetGridHyperlink] 
      (
            'UserMessage', 
            'Text', 
            [UserMessage].[Id], 
            'show-largetext', 
            'Сообщение...'
      ) [Text]      

   FROM [Admin].[UserMessage] [UserMessage] WITH (NOLOCK)
   
   INNER JOIN [Admin].[User] [User]  WITH (NOLOCK)
    ON [User].[Id] = [UserMessage].[UserId]

   INNER JOIN [Admin].[Role] [Role] WITH (NOLOCK)
    ON [Role].[Id] = [User].[RoleId]

   -- выборка за текущий месяц
   WHERE 
    --([UserMessage].[Date] >= @soMonth AND [UserMessage].[Date] <= @eoMonth) AND 
    ([Role].[Code] = @requestRoleCode OR @requestRoleCode IS NULL) 

   ORDER BY [UserMessage].[Date] DESC

   /**/

   /* 3. Вспомогательная таблица с расшифровками столбцов */
  DECLARE @columnCaption [Programmability].[ColumnCaptionTableType]; 
  
  INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES  
  	('MainData', 'RoleCode', 'Роль', 1, 1)
  	,('MainData', 'UserName', 'Пользователь', 1, 2)
  	,('MainData', 'Date', 'Дата', 1, 3)
  	,('MainData', 'Text', 'Сообщение', 1, 4)
   
  /**/

   RETURN 0;
END;
