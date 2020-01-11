CREATE   PROCEDURE Programmability.GetEmergencyLogList
  @userName NVARCHAR(32),
  @filterType NVARCHAR(32),
  @top INTEGER  
AS
  
BEGIN

  SET DATEFORMAT dmy;
  SET LANGUAGE N'русский';
  SET NOCOUNT ON;
  
  /* 1. Формирование таблицы с именами результирующих наборов возвращаемых их ХП */
	DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
  
  DECLARE @periodBegin DATETIME = GETDATE();
  DECLARE @periodEnd DATETIME = GETDATE();
  
  IF (@filterType = 'ByLastDay' OR @filterType = 'ByLastDayTop1')
  BEGIN
    SET @periodBegin = DATEADD(DAY,DATEDIFF(DAY, 0, GETDATE()), 0);
  END
  ELSE IF (@filterType = 'ByLastWeek')
  BEGIN     
     SET @periodBegin = DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()) / 7 * 7, 0);
  END
  ELSE IF (@filterType = 'By7Days')
  BEGIN 
     SET @periodBegin = DATEADD(DAY, -7, GETDATE());    
  END;
  ELSE IF (@filterType = 'ByLast10MinutesTop1')
  BEGIN
    SET @periodBegin = DATEADD(MINUTE, -10, GETDATE())
  END;

  IF (@filterType != 'ByCount')
  BEGIN
  	SET @top = 10000;
  END;
  IF (@filterType = 'ByLastDayTop1' OR @filterType = 'ByLast10MinutesTop1')
  BEGIN
  	SET @top = 1;
  END;

  INSERT INTO @resultSetName VALUES
	(1, 'MainData'),		    -- стандартное имя набора для отображения в решетке
	(2, 'ColumnCaption');	    -- набор с необязательной расшифровкой расшифровка имен столбцов наборов

  SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	FROM @resultSetName [ResultSetName]
  /**/
  
  /* 2. Формирование основной выборки*/

  SELECT 
    [EmergencySituationParameter].[Description] [EmergencySituationParameterDescription]
    
    ,[Channel].[Id] [ChannelId]
    ,[Channel].[MeasurementDeviceId] [MeasurementDeviceId]
    ,[Channel].[Description] [ChannelDescription]
    ,[Channel].[ResourceSystemTypeId] [ResourceSystemTypeId]

    ,[MeasurementDevice].[AccessPointId] [AccessPointId]
    ,[MeasurementDevice].[SuccessConnectionPercent] [MeasurementDeviceSuccessConnectionPercent]
    ,[MeasurementDevice].[LastSuccessConnectionTime] [MeasurementDeviceLastSuccessConnectionTime]
    ,[MeasurementDevice].[LastStatusConnectionId] [LastStatusConnectionId]

    ,[ChannelTemplate].[Description] [ChannelTemplateDescription]

    
    ,[Building].[Description] [BuildingDescription]
	,[Building].[Id] [BuildingId]
    
    ,[EmergencyLog].[EmergencyLogId] [Id]
    ,[EmergencyLog].[EmergencyLogTime] [EmergencyLogTime]
    ,[EmergencyLog].[EmergencyLogDescription] [EmergencyLogDescription]
    ,[EmergencyLog].[IsAcknowledgement] [IsAcknowledgement]
    ,[EmergencyLog].[AcknowledgementDate] [AcknowledgementDate]
    ,[EmergencyLog].[AcknowledgementUserName] [AcknowledgementUserName]
    
    FROM [Business].[EmergencySituationParameter] [EmergencySituationParameter] WITH (NOLOCK)
        
    INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) 
      ON [Channel].[Id] = [EmergencySituationParameter].[ChannelId]
  
    INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK) ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]

    INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK) ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
   
    INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK) 
      ON [Placement].[Id] = [Channel].[PlacementId]
    
    INNER JOIN [Business].[Building] [Building] WITH(NOLOCK) 
      ON [Building].[Id] = [Placement].[BuildingId]
  
    INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK) 
      ON [Channel].[Id] = [UserLinkChannel].[ChannelId]
  
    INNER JOIN [Admin].[User] [User]  WITH(NOLOCK) 
      ON [User].[Id] = [UserLinkChannel].[UserId]
  
    CROSS APPLY 
    (
      SELECT                 
        [EmergencyLog].[Id] [EmergencyLogId],
        [EmergencyLog].[Value] [EmergencyLogDescription], 
        [EmergencyTimeSignature].[Time] [EmergencyLogTime],
        [EmergencyLog].[IsAcknowledgement] [IsAcknowledgement],
        [EmergencyLog].[AcknowledgementDate] [AcknowledgementDate],
        [EmergencyLog].[AcknowledgementUserName] [AcknowledgementUserName] 

        FROM [Business].[EmergencyLog] [EmergencyLog] WITH(NOLOCK) 

        /* INNER JOIN трансформируется оптимизатором MERGE JOIN, про приводит к просадке для TOP 1 */
        /* помогает замена на HASH MATCH или, еще лучще, пока немного элементов LOOP */

        INNER  JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] WITH(NOLOCK) 
          ON [EmergencyTimeSignature].[Id] = [EmergencyLog].[EmergencyTimeSignatureId]
        
        WHERE 
        [EmergencyLog].[RecoveryTime] IS NULL AND
        [EmergencyLog].[EmergencySituationParameterId] = [EmergencySituationParameter].[Id] AND 
        (
              @filterType = 'ByCount' OR ([EmergencyTimeSignature].[Time] BETWEEN @periodBegin AND @periodEnd )          
        )

        ORDER BY [EmergencyLogTime] DESC OFFSET 0 ROWS FETCH NEXT @top ROWS ONLY
        --ORDER BY [EmergencyLogTime] DESC OFFSET 0 ROWS FETCH FIRST @top ROWS ONLY

    ) [EmergencyLog]

    WHERE [User].[UserName] = @userName

    --OPTION ( OPTIMIZE FOR ( @filterType = 'ByCount', @top = 1) );
    
    /* 3. Вспомогательная таблица с расшифровками столбцов */
	DECLARE @columnCaption [Programmability].[ColumnCaptionTableType];

	INSERT INTO @columnCaption 
  OUTPUT inserted.[Table], inserted.[Name], inserted.[Caption], inserted.[Visible], inserted.[Order]
  VALUES
	  ('MainData', 'Id', 'Ид', 1, 1)      
      ,('MainData', 'ChannelId', 'Ид. канала', 1, 2)      
      ,('MainData', 'ChannelDescription', 'Наименование канала', 1, 3)		 
	  ,('MainData', 'EmergencyLogDescription', 'Наименование', 1, 4)  
      ,('MainData', 'IsAcknowledgement', 'Квитирование', 1, 5)            
      ,('MainData', 'EmergencyLogTime', 'Время возникновения', 1, 6)          
      ,('MainData', 'AcknowledgementDate', 'Время квитирования', 1, 7)            
      ,('MainData', 'AcknowledgementUserName', 'Пользователь', 1, 8)

	/**/
END;
GO