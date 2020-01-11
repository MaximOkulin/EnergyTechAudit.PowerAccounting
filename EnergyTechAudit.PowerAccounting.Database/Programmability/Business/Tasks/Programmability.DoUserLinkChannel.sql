CREATE PROCEDURE [Programmability].[DoUserLinkChannel]	
   @userName NVARCHAR(32),

   @operationUniqueId UNIQUEIDENTIFIER,
   @operationType INT,
   @userIdArray NVARCHAR(1024),
   @deviceIdArray NVARCHAR(1024), 
   @districtIdArray NVARCHAR(1024),
   @organizationIdArray NVARCHAR(1024),
   @resourceSystemTypeIdArray NVARCHAR(1024),
   @showOutputLinksInfo BIT = 1,
   @useBriefcase BIT = 0,
   @briefcaseId INT = 0
AS 
BEGIN
   SET NOCOUNT ON;
    	
   /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];

  INSERT INTO @resultSetName VALUES
	  (1, 'MainData'),			-- стандартное имя набора для отображения в решетке
	  (2, 'ColumnCaption');		-- набор с необязательной расшифровкой расшифровка имен столбцов наборов

  SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	  FROM @resultSetName [ResultSetName]
  /**/

  /* 2. Выполнение задачи  */
  DECLARE @rowCountAffected INT = 0;
  DECLARE @statusMessage NVARCHAR(128) = N'Задача не была выполнена';
  DECLARE @errorMessage NVARCHAR(1024) = N'';  
  DECLARE @deliter VARCHAR(4) = ',';

  DECLARE @taskOperation TABLE 
  (
      [Id] INT NOT NULL PRIMARY KEY,
      [StatusMessage] NVARCHAR(128),
      [RowCountAffected] INT,
      [ErrorMessage] NVARCHAR(1024)
  );
     
	 IF(OBJECT_ID('[tempdb].[guest].[DoUserLinkChannelOutput]') IS NULL)
	 BEGIN 
		CREATE TABLE [tempdb].[guest].[DoUserLinkChannelOutput]
		(
			 [Id] INT IDENTITY (1, 1) NOT NULL,

			 [OperationUniqueId] UNIQUEIDENTIFIER NOT NULL,
			 [Reguestor] NVARCHAR(32) NOT NULL,

			 [UserId] INT NOT NULL,
			 [ChannelId] INT NOT NULL,

			 CONSTRAINT PK_Guest_DoUserLinkChannelOutput_Id PRIMARY KEY ([Id])   
		) ;
	 END;

	-- получим уид последней операции текущего реквестора
	DECLARE @lastOperationUniqueId UNIQUEIDENTIFIER =
    (
		SELECT TOP 1 [OperationUniqueId] 
		FROM [tempdb].[guest].[DoUserLinkChannelOutput] WITH(NOLOCK)
		WHERE [Reguestor] = @userName
    );

	-- уид последней операции найден
	IF (@lastOperationUniqueId IS NOT NULL)
	BEGIN  
		-- если уид последней операции не совпадает с уид-ом текущей операции (формируется на стороне клиента)
		IF (@lastOperationUniqueId <> @operationUniqueId)
		BEGIN
			-- сброс таблицы последних результатов для текущего реквестора			
			DELETE FROM [tempdb].[guest].[DoUserLinkChannelOutput]
			WHERE [Reguestor] = @userName;
		END
		ELSE
		BEGIN
			-- если уид не менялся, то обработка повторно не выполняется, 
			-- но возвращаются результаты предыдущей операции
			GOTO ToOut; 
		END;
	END;
     
  BEGIN TRAN

  BEGIN TRY
     SET NOCOUNT OFF;

	 DECLARE @startWatch DATETIME = GETDATE();

     -- присоединение устройств к пользователю
     IF(@operationType = 1)
     BEGIN
		-- using Briefcase 
		IF(@useBriefcase = 1)
		BEGIN
			INSERT INTO [Business].[UserLinkChannel] ([UserId], [ChannelId])        
			OUTPUT @operationUniqueId, @userName, inserted.[UserId], inserted.[ChannelId]
			INTO [tempdb].[guest].[DoUserLinkChannelOutput]
			SELECT  CONVERT(INT, [Item])  [UserId], [BriefcaseChannels].[ChannelId] [ChannelId]    
			FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
			CROSS JOIN
			(
				SELECT 
					[BriefcaseItem].[EntityId] [ChannelId]     
				FROM [Core].[BriefcaseItem] [BriefcaseItem] 
					INNER JOIN [Core].[Briefcase] [Briefcase] ON [BriefcaseItem].[BriefcaseId] = [Briefcase].[Id]
				WHERE 
					[Briefcase].[Id] = @briefcaseId AND 
					[BriefcaseItem].[EntityTypeName] = 'Channel' AND 
					EXISTS 
					(
						SELECT [Channel].[Id] 
						FROM [Business].[Channel] [Channel] 
						WHERE [Channel].[Id] = [BriefcaseItem].[EntityId] AND [Channel].[Activated] = 1
					)
			) [BriefcaseChannels]
			EXCEPT            
			SELECT [Link].[UserId], [Link].[ChannelId]
			FROM [Business].[UserLinkChannel] [Link] 
			WHERE [Link].[UserId] IN 
			(
				SELECT CONVERT(INT, [Item]) [UserId]
				FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
			)
		END
		ELSE
		BEGIN
			INSERT INTO [Business].[UserLinkChannel] ([UserId], [ChannelId])        
			OUTPUT @operationUniqueId, @userName, inserted.[UserId], inserted.[ChannelId]
			INTO [tempdb].[guest].[DoUserLinkChannelOutput]
			  SELECT  CONVERT(INT, [Item]) [UserId], [UserLink].[ChannelId]
				FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)            
						  CROSS JOIN
						  (                 
							SELECT [Ch].[Id] [ChannelId]
              
							FROM [Business].[Channel] [Ch] WITH(NOLOCK)
							  INNER JOIN [Business].[MeasurementDevice] [Md] WITH(NOLOCK)
							  ON [Md].[Id] = [Ch].[MeasurementDeviceId]

							WHERE 
                          
							  /* только активизированные каналы */
							  [Ch].[Activated] = 1 AND
                          
							  /* районы и организации */
							  ISNULL([Md].[AccessPointId], 0) IN 
							  (
								  SELECT DISTINCT([BuildingLink].[AccessPointId]) 
								  FROM [Business].[Building] [Building] WITH(NOLOCK)

								  INNER JOIN Business.AccessPointLinkBuilding [BuildingLink] WITH(NOLOCK)
									 ON [Building].[Id] = [BuildingLink].[BuildingId] 

								  WHERE [Building].[DistrictId] IN 
									 (
										SELECT CONVERT(INT, [Item]) [DistrictId]
										FROM [Business].[StringSplitToArray]  (@districtIdArray, @deliter)
									 ) AND 

									 ISNULL([Building].[OrganizationId], 0) IN
													 (
														  SELECT CONVERT(INT, [Item]) [OrganizarionId]
														  FROM [Business].[StringSplitToArray] (@organizationIdArray, @deliter)
													 )
							   )/**/

							   /* типы измерительных устройств */
							   AND                            
							   [Md].[DeviceId] IN 
							   (
								  SELECT CONVERT(INT, [Item]) [DeviceId]
								  FROM [Business].[StringSplitToArray]  (@deviceIdArray, @deliter)
							   )/**/

							   /* типы ресурсных систем */
							   AND 
							   [Ch].[ResourceSystemTypeId] IN 
							   (
								  SELECT CONVERT(INT, [Item]) [ResourceSystemTypeId]
								  FROM [Business].[StringSplitToArray]  (@resourceSystemTypeIdArray, @deliter)
							   )/**/
				)[UserLink]
                        
				EXCEPT
            
				-- исключим из выборки уже существующие аналогичные ссылки
				SELECT [Link].[UserId], [Link].[ChannelId]
				FROM [Business].[UserLinkChannel] [Link] 
				WHERE [Link].[UserId] IN 
				(
					SELECT CONVERT(INT, [Item]) [UserId]
					FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
				)
			END;
      END
      -- отсоединение устройств от пользователя
     ELSE IF(@operationType = 2)
     BEGIN
		-- using Briefcase 
		IF(@useBriefcase = 1)
		BEGIN
			DELETE [UserLinkChannel]         
			OUTPUT @operationUniqueId, @userName, deleted.[UserId], deleted.[ChannelId]  
			INTO [tempdb].[guest].[DoUserLinkChannelOutput]        
			FROM [Business].[UserLinkChannel] [UserLinkChannel]
			WHERE [UserLinkChannel].[UserId] IN 
				(
					SELECT CONVERT(INT, [Item]) [UserId]
					FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
				)
				AND [UserLinkChannel].[ChannelId] IN
				(
					SELECT       
					[BriefcaseItem].[EntityId] [ChannelId] 
    
					FROM [Core].[BriefcaseItem] [BriefcaseItem] 
						INNER JOIN [Core].[Briefcase] [Briefcase] ON [BriefcaseItem].[BriefcaseId] = [Briefcase].[Id]
					WHERE [Briefcase].[Id] = @briefcaseId AND [BriefcaseItem].[EntityTypeName] = 'Channel'	
				);
		END
		ELSE
		BEGIN 
			DELETE [Link] 
        
			OUTPUT @operationUniqueId, @userName, deleted.[UserId], deleted.[ChannelId]  
			INTO [tempdb].[guest].[DoUserLinkChannelOutput]
        
			FROM [Business].[UserLinkChannel] [Link]

			WHERE 
				[Link].[UserId] IN 
				(
					SELECT CONVERT(INT, [Item]) [UserId]
					FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
				)
				AND 
				[Link].[ChannelId] IN
				(
				   SELECT [Ch].[Id] 

				   FROM [Business].[Channel] [Ch] WITH(NOLOCK)

				   INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType]
					  ON [ResourceSystemType].[Id] = [Ch].[ResourceSystemTypeId]

				   INNER JOIN [Business].[MeasurementDevice] [Md] WITH(NOLOCK)
					  ON [Md].[Id] = [Ch].[MeasurementDeviceId]

				   INNER JOIN [Business].[AccessPoint] [AP] WITH(NOLOCK)
					  ON [Md].[AccessPointId] = [AP].[Id]

				   INNER JOIN [Business].[AccessPointLinkBuilding] [ApBL] WITH(NOLOCK)
					  ON [AP].[Id] = [ApBL].[AccessPointId]

				   INNER JOIN [Business].[Building] [B] WITH(NOLOCK)
					  ON [B].[Id] = [ApBL].[BuildingId]

				   WHERE 
				   /* операция затрагивает только активизированные каналы */
				   [Ch].[Activated] = 1 AND

				   [Md].[DeviceId] IN 
						 (
							SELECT CONVERT(INT, [Item]) [DeviceId]
							FROM [Business].[StringSplitToArray]  (@deviceIdArray, @deliter)
						 ) AND 
				   [B].[DistrictId] IN 
				   (
					  SELECT CONVERT(INT, [Item]) [DistrictId]
					  FROM [Business].[StringSplitToArray]  (@districtIdArray, @deliter)
				   ) AND 
				   ISNULL([B].[OrganizationId], 0) IN
				   (
					  SELECT CONVERT(INT, [Item]) [OrganizationId]
					  FROM [Business].[StringSplitToArray] (@organizationIdArray, @deliter)
				   )
				   AND
				   [Ch].[ResourceSystemTypeId] IN 
				   (
					  SELECT CONVERT(INT, [Item]) [ResourceSystemTypeId]
					  FROM [Business].[StringSplitToArray]  (@resourceSystemTypeIdArray, @deliter)
				   )
				);
			END; 
      END
	  -- detatch all inactive channels or all channels
	  ELSE IF(@operationType = 3 OR @operationType = 4)
	  BEGIN
		DELETE [UserLinkChannel]         
			OUTPUT @operationUniqueId, @userName, deleted.[UserId], deleted.[ChannelId]  
			INTO [tempdb].[guest].[DoUserLinkChannelOutput]        
			FROM [Business].[UserLinkChannel] [UserLinkChannel]
			WHERE [UserLinkChannel].[UserId] IN 
				(
					SELECT CONVERT(INT, [Item]) [UserId]
					FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
				)
				AND [UserLinkChannel].[ChannelId] IN
				(
					SELECT [Channel].[Id] 
					FROM [Business].[Channel] [Channel] WITH (NOLOCK) 
					WHERE [Channel].Activated = 0 OR @operationType = 4				
				);					
	  END;
	  

	  SET @rowCountAffected = @@ROWCOUNT;

	  /**/
	  DECLARE @userId INT;
	  DECLARE @roleCode NVARCHAR(64);

	  EXEC [Programmability].[GetUserInfo] @userName, @userId OUT, @roleCode OUT;

	  DECLARE @actionParameter XML =
	  (
		SELECT   
			@rowCountAffected [RowCountAffected],
			(
				SELECT [User].[Id], [User].[UserName] FROM [Admin].[User] [User] WHERE [User].[Id] IN 
				(
					SELECT CONVERT(INT, [Item]) [Id]
					FROM [Business].[StringSplitToArray]  (@userIdArray, @deliter)
				) FOR XML AUTO, ELEMENTS, TYPE, ROOT('Users')
			), 
			(
				SELECT [Device].[Id], [Device].[Code] FROM [Dictionaries].[Device] [Device] WHERE [Device].[Id] IN 
				(
					SELECT CONVERT(INT, [Item]) [Id]
					FROM [Business].[StringSplitToArray]  (@deviceIdArray, @deliter)
				) FOR XML AUTO, ELEMENTS, TYPE, ROOT('Devices')
			),
			(
				SELECT [District].[Id], [District].[CityId], [District].[Description], [City].[Description] FROM [Dictionaries].[District] [District]
				INNER JOIN [Dictionaries].[City] [City] ON [District].[CityId] = [City].[Id]
				 WHERE [District].[Id] IN 
				(
					SELECT CONVERT(INT, [Item]) [Id]
					FROM [Business].[StringSplitToArray]  (@districtIdArray, @deliter)
				) FOR XML AUTO, ELEMENTS, TYPE, ROOT('Districts')
			),
			(
				SELECT [Organization].[Id], [Organization].[Description] FROM [Business].[Organization] [Organization] WHERE [Organization].[Id] IN 
				(
					SELECT CONVERT(INT, [Item]) [Id]
					FROM [Business].[StringSplitToArray]  (@organizationIdArray, @deliter)
				) FOR XML AUTO, ELEMENTS, TYPE, ROOT('Organizations')
			),
			(
				SELECT [ResourceSystemType].[Id], [ResourceSystemType].[Code] FROM [Dictionaries].[ResourceSystemType] [ResourceSystemType] WHERE [ResourceSystemType].[Id] IN 
				(
					SELECT CONVERT(INT, [Item]) [Id]
					FROM [Business].[StringSplitToArray]  (@resourceSystemTypeIdArray, @deliter)
				) FOR XML AUTO, ELEMENTS, TYPE, ROOT('ResourceSystemTypes')
			)
			FOR XML PATH('RequestParams')
		);

	  INSERT INTO [Admin].[Audit] 
	  (
		[Area],  
		[Controller],  
		[Action],	
		[UserId],	
		[Time],
		[Elapsed],  
		[ActionParams] 
	  )	  
	  VALUES('InternalSqlServer', 'DoUserLinkChannel',  IIF(@operationType = 1, 'AttachUserLinkChannel', 'DetachUserLinkChannel'),  @userId, GETDATE(), DATEDIFF(ms, @startWatch, GETDATE()), CAST( @actionParameter AS NVARCHAR(MAX) ) );

	  /**/

      
      COMMIT TRAN;
      SET @statusMessage = 'Задача успешно выполнена';      
      SET NOCOUNT ON;
   END TRY
   BEGIN CATCH       
      IF(@@TRANCOUNT > 0) ROLLBACK TRAN;
      SET @errorMessage = ERROR_MESSAGE();
   END CATCH;
   /**/
  
  ToOut: 

   /* Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

   /* 3. Формирование статусной информации задачи */

   IF (@showOutputLinksInfo = 0)
   BEGIN
     
      /* Краткий статус операции (сколько записей затронуто операцией) */
      INSERT INTO @taskOperation 
      VALUES (1, @statusMessage, @rowCountAffected, @errorMessage);
   
      SELECT 
        [TaskOperation].[Id], 
        [TaskOperation].[StatusMessage], 
        [TaskOperation].[RowCountAffected], 
        [TaskOperation].[ErrorMessage]  

      FROM @taskOperation [TaskOperation];

      INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES  
		 ('MainData', 'Id', 'Ид', 1, 1)
        ,('MainData', 'StatusMessage', 'Статус', 1, 2)
        ,('MainData', 'RowCountAffected', 'Затронуто записей', 1, 3)
        ,('MainData', 'ErrorMessage', 'Ошибка', 1, 4)
   END
   ELSE
   BEGIN

     /* Полный список присоединенных или отсоединенных ссылок */
     SELECT 
		ROW_NUMBER() OVER (ORDER BY [ProcessingResult].[ChannelId], [ProcessingResult].[UserId]) [Id],
	  
		[ProcessingResult].[ChannelId] [ChannelId],
		[ProcessingResult].[UserId] [UserId],

		[City].[Description] [CityDescription],
		[District].[Description] [DistrictDescription],
		[Building].[FullAddress] [BuildingDescription],

		[User].[Description] [UserDescription],
		[Channel].[Description] [ChannelDescription]

     FROM  [tempdb].[guest].[DoUserLinkChannelOutput] [ProcessingResult] WITH(NOLOCK) 

     INNER  JOIN [Admin].[User] [User] WITH(NOLOCK) 
        ON [User].[Id] = [ProcessingResult].[UserId]

     INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) 
        ON [Channel].[Id] = [ProcessingResult].[ChannelId] 

     INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK) 
        ON [Placement].[Id] = [Channel].[PlacementId]

     INNER JOIN [Business].[Building] [Building] WITH (NOLOCK)
        ON [Building].[Id] = [Placement].[BuildingId]
	
	 INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
		ON [District].[Id] = [Building].[DistrictId]
	
	 INNER JOIN [Dictionaries].[City] [City] WITH(NOLOCK)
		ON [City].[Id] = [District].[CityId]				
    WHERE 
      [ProcessingResult].[OperationUniqueId] = @operationUniqueId AND 
      [ProcessingResult].[Reguestor] = @userName;

    INSERT INTO @columnCaption 
      OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
      VALUES  
        ('MainData', 'Id', 'Ид', 0, 1),		    
        ('MainData', 'ChannelId', 'Ид. канала', 0, 2),
        ('MainData', 'UserId', 'Ид. пользователя', 0, 3),
		
		('MainData', 'CityDescription', 'Населенный пункт', 1, 4),
        ('MainData', 'DistrictDescription', 'Район', 1, 5),
        ('MainData', 'BuildingDescription', 'Строение', 1, 6),
		('MainData', 'ChannelDescription', 'Канал', 1, 7),
        ('MainData', 'UserDescription', 'Пользователь', 1, 8)
  END;
  	  			
END;
