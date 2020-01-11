CREATE PROCEDURE [Programmability].[GetChannelsEmergencySituationParameters]
	@userName NVARCHAR(64),
	@resourceSystemTypeId INT = NULL,
	@districtId INT = NULL,
	@fillAllData BIT = 0
AS
BEGIN
    SET DATEFORMAT dmy;
    SET LANGUAGE N'русский';
    SET NOCOUNT ON;

	  SET @resourceSystemTypeId = ISNULL(@resourceSystemTypeId, 0);

    DECLARE @empty NCHAR(1) = '';

	  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	  DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

    INSERT INTO @resultSetName VALUES
     (1, 'ReportParameter'),
	   (2, 'MainData'),		      -- стандартное имя набора для отображения в решетке
	   (3, 'ColumnCaption')     -- набор с расшифровками имен столбцов
	 
   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	   FROM @resultSetName [ResultSetName]
       
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
    FROM 
	  (
		  SELECT [Id], [Code], [Description] FROM [Dictionaries].[ResourceSystemType] 
			  UNION ALL 
		  SELECT 0, 'All', 'Все типы ресурсных систем'

	  )  [ResourceSystemType] 
    WHERE  [ResourceSystemType].[Id] = @resourceSystemTypeId;
    
   /* 2. Основная выборка */

   DECLARE @userId  INT;    
   DECLARE @roleCode NVARCHAR(64);

   EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

   SET @resourceSystemTypeId = IIF(@resourceSystemTypeId = 0, NULL, @resourceSystemTypeId);
   SET @districtId = IIF(@districtId = 0, NULL, @districtId);

   WITH Result AS
   (
      --выборка по каналам
      SELECT
	   [EntityId],
	   [ChannelId],
	   [ChannelDescription],
     NULL [EmergencyDescription],
     [BuildingId],
     [DistrictId],
     CASE WHEN @fillAllData = 1 THEN [Ch].[Address] ELSE  NULL END [Address],
     [DistrictDescription],
     1 [ChannelMarker],
	   NULL [EmergencyTurnOn],
     NULL [IsEmail],
     NULL [IsWhatsApp],
     NULL [IsBrowser]     
	   FROM
	   (
	    SELECT
      ROW_NUMBER() OVER(PARTITION BY [Ch].[Id] ORDER BY [Ch].[Id]) [ChId],
      [Ch].[Id] [EntityId],
      [Ch].[Id] [ChannelId],
      [Ch].[Description] [ChannelDescription],
      [b].[Id] [BuildingId],
      [b].[DistrictId] [DistrictId],
	  [b].[Description] [Address],
      [d].[Description] [DistrictDescription]  
		  FROM [Business].[Channel] [Ch] WITH(NOLOCK)
		  
      INNER JOIN [Programmability].[GetUserLinkChannel] (@userName) [UserLink]
          ON [UserLink].[ChannelId] = [Ch].[Id] AND 
          ((ISNULL([UserLink].[UserId], 0) = @userId) OR (@roleCode = N'ADMIN'))	

      INNER JOIN [Dictionaries].[ResourceSystemType] [Rst] WITH(NOLOCK)  ON [Rst].[Id] = [Ch].[ResourceSystemTypeId]
      INNER JOIN [Business].[EmergencySituationParameter] [Esp] WITH(NOLOCK)  ON [Esp].[ChannelId] = [Ch].[Id]
      INNER JOIN [Business].[Placement] [P] WITH(NOLOCK)  ON [Ch].[PlacementId] = [P].[Id]
      INNER JOIN [Business].[Building] [b] WITH(NOLOCK)   ON [P].[BuildingId] = [b].[Id]
      INNER JOIN [Dictionaries].[District] d  WITH(NOLOCK) ON b.DistrictId = d.Id 

	  WHERE  (d.Id = @districtId OR @districtId IS NULL) AND ([Rst].[Id] = @resourceSystemTypeId OR @resourceSystemTypeId IS NULL)
     )[Ch]
    WHERE [Ch].[ChId] = 1
   ), 
   Result2 AS
   (
      -- выборка по нештатным ситуациям
     SELECT
	     [EntityId],
	     [ChannelId],
	    CASE WHEN @fillAllData = 1 THEN [B].[ChannelDescription] ELSE  NULL END [ChannelDescription],
       [EmergencyDescription],
       [BuildingId],
       [DistrictId],
       CASE WHEN @fillAllData = 1 THEN [B].[BuildingDescription] ELSE NULL END [Address],
       [DistrictDescription],
       NULL [ChannelMarker],
	    [EmergencyTurnOn],
      [IsEmail],
      [IsWhatsApp],
      [IsBrowser]    
	  FROM
	  (
	     SELECT 
		     ROW_NUMBER() OVER(PARTITION BY [Esp].[Id] ORDER BY [Esp].[Id]) [EspId],
		     [Esp].[Id] [EntityId],
		     [Channel].[Description] [ChannelDescription],
		     [Esp].[ChannelId] [ChannelId],
		     [Esp].[Description] [EmergencyDescription],
             [b].[Id] [BuildingId],
             [b].[DistrictId] [DistrictId],
             [d].[Description] [DistrictDescription],
		     [b].[Description] [BuildingDescription],
		 
         CASE WHEN [Esp].[TurnOn] = 1 THEN  N'Вкл' ELSE  N'Выкл' END [EmergencyTurnOn],
             CASE WHEN emailNotificaion.[Id] IS NOT NULL 
		          THEN CAST(CONCAT('+/', emailNotificaion.RepetitionMinutes) AS NVARCHAR(12)) 
		          ELSE CAST('-' AS NVARCHAR(12)) 
	         END [IsEmail],

         CASE WHEN whatsAppNotificaion.[Id] IS NOT NULL 
		          THEN CAST(CONCAT('+/', whatsAppNotificaion.RepetitionMinutes) AS NVARCHAR(12)) 
		          ELSE CAST('-' AS NVARCHAR(12)) 
	       END [IsWhatsApp],

         CASE WHEN browserNotificaion.[Id] IS NOT NULL 
		          THEN CAST(CONCAT('+/', browserNotificaion.RepetitionMinutes) AS NVARCHAR(12)) 
			      ELSE CAST('-' AS NVARCHAR(12)) 
	       END [IsBrowser]
     
		 FROM [Business].[EmergencySituationParameter] [Esp] WITH(NOLOCK)
		
         INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
			ON [Channel].[Id] = [Esp].[ChannelId]
         INNER JOIN [Business].[Placement] [P] WITH(NOLOCK)
			ON [Channel].[PlacementId] = [P].[Id]
         INNER JOIN [Business].[Building] [b] WITH(NOLOCK)
			ON [P].[BuildingId] = [b].[Id]
         INNER JOIN [Dictionaries].[District] d WITH(NOLOCK) 
		    ON b.DistrictId = d.Id
      LEFT JOIN [Business].[UserLinkEmergencyNotificationType] emailNotificaion WITH(NOLOCK)
        ON emailNotificaion.EmergencySituationParameterId = [Esp].[Id] AND 
           emailNotificaion.UserAdditionalInfoId = @userId AND emailNotificaion.NotificationTypeId = 2        --email
        LEFT JOIN [Business].[UserLinkEmergencyNotificationType] whatsAppNotificaion WITH(NOLOCK)
        ON whatsAppNotificaion.EmergencySituationParameterId = [Esp].[Id] AND 
           whatsAppNotificaion.UserAdditionalInfoId = @userId AND whatsAppNotificaion.NotificationTypeId = 3  --whatsApp
        LEFT JOIN [Business].[UserLinkEmergencyNotificationType] browserNotificaion WITH(NOLOCK)
        ON browserNotificaion.EmergencySituationParameterId = [Esp].[Id] AND 
           browserNotificaion.UserAdditionalInfoId = @userId AND browserNotificaion.NotificationTypeId = 1    --browser

		 WHERE [Esp].[ChannelId] IN (SELECT [EntityId] FROM [Result])
       ) [B]
	   WHERE [B].[EspId] = 1
    ),
    Result3 AS
    (
     SELECT
	   [EntityId],
	   NULL [ChannelId],
	   NULL [ChannelDescription],
     NULL [EmergencyDescription],
     [BuildingId],
     [DistrictId],
     [Address],
     [DistrictDescription],
     NULL [ChannelMarker],
	   NULL [EmergencyTurnOn],
     NULL [IsEmail],
     NULL [IsWhatsApp],
     NULL [IsBrowser]
     FROM (
      SELECT b.Id [EntityId],
             b.Id [BuildingId],
             d.Id [DistrictId],
             b.[Description] [Address],
             d.[Description] [DistrictDescription]
       FROM [Business].[Building] b WITH(NOLOCK)
       INNER JOIN [Dictionaries].[District] d WITH(NOLOCK) ON b.DistrictId = d.Id
       WHERE b.Id IN (SELECT [BuildingId] FROM [Result])
    ) [C]
   ) 
    
   
   SELECT
    [EntityId],
		[ChannelId],
		[ChannelDescription],
    [EmergencyDescription],
    [BuildingId],
    [DistrictId],
    [Address],
    [DistrictDescription],
    [ChannelMarker],
	  [EmergencyTurnOn],
    [IsEmail],
    [IsWhatsApp],
    [IsBrowser]   
   FROM [Result]

   UNION ALL
   SELECT
    [EntityId],
		[ChannelId],
		[ChannelDescription], 
    [EmergencyDescription],
    [BuildingId],
    [DistrictId],
    [Address],
    [DistrictDescription],
    [ChannelMarker],
	  [EmergencyTurnOn],
    [IsEmail],
    [IsWhatsApp],
    [IsBrowser]
   FROM [Result2] 

  UNION ALL
   SELECT
    [EntityId],
    [ChannelId],
	[ChannelDescription], 
    [EmergencyDescription],
    [BuildingId],
    [DistrictId],
    [Address],
    [DistrictDescription],
    [ChannelMarker],
	[EmergencyTurnOn],
    [IsEmail],
    [IsWhatsApp],
    [IsBrowser]
   FROM [Result3] 

  ORDER BY [DistrictId] ASC, [BuildingId] ASC, [ChannelId] ASC, [ChannelMarker] DESC

  /* 3. Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

	INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES
	  ('MainData', 'EntityId', 'Ид объекта', 1, 1)
    ,('MainData', 'DistrictId', 'Ид района', 1, 2)
    ,('MainData', 'DistrictDescription', 'Район', 1, 3)     
	  ,('MainData', 'Address', 'Адрес', 1, 4)    
    ,('MainData', 'ChannelDescription', 'Канал', 1, 5)
	  ,('MainData', 'ChannelId', 'Ид канала', 1, 6)
	  ,('MainData', 'EmergencyDescription', 'Параметр нештатной ситуации', 1, 7)
	  ,('MainData', 'EmergencyTurnOn', 'Вкл/выкл', 1, 8)
    ,('MainData', 'IsEmail', 'Email', 1, 9)
    -- поле WhatsApp временно упразднено, но не удалено
    -- ,('MainData', 'IsWhatsApp', 'WhatsApp', 0, 10)
    ,('MainData', 'IsBrowser', 'Browser', 1, 11)  
	
END;

GO