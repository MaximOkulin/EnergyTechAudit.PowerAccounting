-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2014-10-28
-- Description: Возвращает архивные данные устройства
-- ===================================================================================================


CREATE PROCEDURE [Programmability].[MeasurementDeviceArchiveData]
	@userName NVARCHAR(32),
	@periodBegin DATETIME,
    @periodEnd DATETIME,
	@channelId INT,
	@periodTypeId INT
AS
BEGIN
	SET DATEFORMAT dmy;
	SET LANGUAGE N'русский';
  SET NOCOUNT ON;
	
	SET @periodTypeId = IIF(@periodTypeId = 0, NULL, @periodTypeId);
	
   -- получаем идентификатор пользователя по его уникальному имени
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

   -- проверка существования шаблона канала
     IF(NOT EXISTS (SELECT 1 FROM [Business].[Channel] [Channel] 
          INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH (NOLOCK) ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
        WHERE [Channel].[Id] = @channelId)
     )
     BEGIN
      ;THROW 500001, N'Не назначен шаблон канала', 1;
     END;

   /* 1. Формирование имен резалтсетов для отчета*/
   DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
   INSERT INTO @resultSetName VALUES 
       (1, 'MainData')
      ,(2, 'ColumnCaption');
   
   SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	   FROM @resultSetName [ResultSetName]

   
   /**/
   
   -- получаем идентификатор измерительного прибора
   DECLARE @measurementDeviceId INT = 
     (SELECT [MeasurementDeviceId] FROM [Business].[Channel] [Channel] WITH (NOLOCK) WHERE [Channel].[Id] = @channelId)

   -- получаем идентификатор шаблона
   DECLARE @channelTemplateId INT =
     (SELECT [ChannelTemplateId] FROM [Business].[Channel] [Channel] WITH (NOLOCK) WHERE [Channel].[Id] = @channelId)


   /* 2. Основная выборка данных */  
	SELECT
		[Archive].[Id] [ArchiveId], 
		[PeriodType].[Description] [PeriodTypeDescription], 		
		[DeviceParameter].[Description] [DeviceParameterDescription], 
		[Archive].[Value] [ArchiveValue],
		[Archive].[Time] [ArchiveTime]
		
	FROM [Business].[Archive] [Archive] WITH(NOLOCK)
				
		INNER JOIN [Business].[MeasurementDevice] [Device] WITH(NOLOCK)
         ON [Device].[Id] = [Archive].[MeasurementDeviceId] 

    INNER JOIN [Business].[Channel] [Channel]  WITH(NOLOCK)
        ON [Channel].[Id] = @channelId AND [Device].[Id] = [Channel].[MeasurementDeviceId]

		INNER JOIN [Business].[UserLinkChannel] [UserLink] WITH(NOLOCK)
         ON [Channel].[Id] = [UserLink].[ChannelId] AND [UserLink].[UserId] = @userId

		INNER JOIN [Dictionaries].[PeriodType] [PeriodType] WITH(NOLOCK)
         ON [Archive].[PeriodTypeId] = [PeriodType].[Id]

		INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH(NOLOCK)
         ON [Archive].[DeviceParameterId] = [DeviceParameter].[Id]
				
	WHERE	[Device].[Id] = @measurementDeviceId 
			AND ([Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEnd)					
			AND ([Archive].PeriodTypeId = @periodTypeId OR @periodTypeId IS NULL)
			--отбираем только те девайсовые параметры, которые есть в шаблоне канала
			AND [Archive].[DeviceParameterId] IN 
      (
        SELECT [DeviceParameterId] 
        FROM [Business].[ParameterMapDeviceParameter] [PMDP] WITH (NOLOCK)
				WHERE ([PMDP].[ChannelTemplateId] = @channelTemplateId AND ([PMDP].[PeriodTypeId] = @periodTypeId OR @periodTypeId IS NULL))
      )

   ORDER BY [Archive].[Time] DESC OFFSET 0 ROWS FETCH NEXT 5000 ROWS ONLY;

	/* 3. Вспомогательная таблица с расшифровками столбцов */
   DECLARE @columnCaption [Programmability].[ColumnCaptionTableType] ;

   INSERT INTO @columnCaption 
   OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
   VALUES
      ('MainData', 'ArchiveId', 'Ид', 1, 1)
	   ,('MainData', 'PeriodTypeDescription', 'Период', 1, 2)
	   ,('MainData',  'DeviceParameterDescription', 'Параметр прибора', 1, 3)	   
	   ,('MainData', 'ArchiveValue', 'Значение', 1, 4) 
	   ,('MainData', 'ArchiveTime', 'Время', 1, 5) 	   

END;		
