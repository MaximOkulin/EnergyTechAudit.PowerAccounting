CREATE PROC Programmability.GetUserExtendedInfoSummary
  @userName NVARCHAR(32)
AS

BEGIN

  DECLARE @dailyLowerBound DATETIME = CAST(CAST ( GETDATE() AS DATE) AS DATETIME);
  DECLARE @dailyNow DATETIME = GETDATE();  
  DECLARE @userId INT = 0;
  DECLARE @roleCode NVARCHAR(128) = NULL;
  DECLARE @roleDescription NVARCHAR(128) = NULL;


  SELECT TOP(1) @userId = [User].[Id], 
    @roleCode = [Role].[Code], 
    @roleDescription = [Role].[Description]

  FROM [Admin].[User] [User] WITH(NOLOCK) 
    INNER JOIN [Admin].[Role] [Role] WITH(NOLOCK) ON [Role].[Id] = [User].[RoleId]
  WHERE [User].[UserName] = @userName;

  
WITH UserExtendedInfoSummary
  AS
(
  -- 0)
   SELECT 0 [GroupKey],
      'Учетные данные' [GroupName],   
      'Роль' [Description],
      CONVERT(NVARCHAR(128), @roleCode) [Value]    
  
  UNION ALL   
  
  SELECT 0 [GroupKey],
      'Учетные данные' [GroupName],   
      'Учетная запись' [Description],
      CONVERT(NVARCHAR(128), @userName) [Value]    
  
  UNION ALL   
  
    -- 1)
    SELECT      
      1 [GroupKey],
      'Объекты диспетчеризации' [GroupName],   
      'Строения' [Description],
       CONVERT(NVARCHAR(128), COUNT(*)) [Value]    
    FROM 
    (
      SELECT DISTINCT [Placement].[BuildingId]      
      FROM [Business].[Placement] [Placement] WITH(NOLOCK)
          INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) ON [Placement].[Id] = [Channel].[PlacementId]
          INNER JOIN [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK) ON [Channel].[Id] = [UserLinkChannel].[ChannelId] AND [UserLinkChannel].[UserId] = @userId
    ) [Buiding]
  
    UNION ALL
  
    SELECT 
      1 [GroupKey],     
      'Объекты диспетчеризации' [GroupName],       
      'Измерительные устройства' [Description],
      CONVERT(NVARCHAR(128), COUNT(*)) [Value]
  
    FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH(NOLOCK) WHERE [MeasurementDevice].[Id] IN
      (
        SELECT [Channel].[MeasurementDeviceId]       
          FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
          INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) ON [UserLinkChannel].[ChannelId] = [Channel].[Id]
        WHERE [UserLinkChannel].[UserId] = @userId 
      )
  
    UNION ALL
  
    SELECT 
      1 [GroupKey],     
      'Объекты диспетчеризации' [GroupName],   
      'Измерительные каналы' [Description],
      CONVERT(NVARCHAR(128), COUNT(*)) [Value]    
  
    FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
    WHERE [UserLinkChannel].[UserId] = @userId 
             
    -- 2)
    UNION ALL
  
    SELECT   
      2 [GroupKey],
    'Подписка на уведомления' [GroupName], 
      [NotificationTypeByUser].[Description],   
      CONVERT(NVARCHAR(128), [NotificationTypeByUser].[Value]) [Value]     
    FROM
    ( 
      SELECT 
        ROW_NUMBER() OVER(PARTITION BY [NotificationType].[Id] ORDER BY [UserLinkEmergencyNotificationType].[Id] ) [RowNum], 
        COUNT(*) OVER(PARTITION BY [UserLinkEmergencyNotificationType].[NotificationTypeId]) [Value],
        [NotificationType].[Description] [Description]
      
        FROM [Business].[UserLinkEmergencyNotificationType] [UserLinkEmergencyNotificationType] WITH(NOLOCK)
        INNER JOIN [Dictionaries].[NotificationType] [NotificationType] WITH(NOLOCK) ON [UserLinkEmergencyNotificationType].[NotificationTypeId] = [NotificationType].[Id]
         
        WHERE [UserLinkEmergencyNotificationType].[UserAdditionalInfoId] = @userId 
    ) [NotificationTypeByUser]
    WHERE [NotificationTypeByUser].[RowNum] = 1
    
    UNION ALL
    
    -- 3)
    SELECT 
      3 [GroupKey],
      'Нештатные ситуации' [GroupName], 
      'Всего логов за текущие сутки' [Description],
      CONVERT(NVARCHAR(128), COUNT(*))  [Value]      
    FROM [Business].[Channel] [Channel]
      INNER JOIN [Business].[EmergencySituationParameter] [EmergencySituationParameter] WITH(NOLOCK) ON [Channel].[Id] = [EmergencySituationParameter].[ChannelId]
      INNER JOIN [Business].[EmergencyLog] [EmergencyLog] WITH(NOLOCK) ON [EmergencySituationParameter].[Id] = [EmergencyLog].[EmergencySituationParameterId]  
      INNER JOIN [Business].[EmergencyTimeSignature] [EmergencyTimeSignature] WITH(NOLOCK) ON [EmergencyLog].[EmergencyTimeSignatureId] = [EmergencyTimeSignature].[Id]
      
    WHERE [Channel].[Id] IN 
      (
        SELECT [Channel].[MeasurementDeviceId]       
          FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
          INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK) ON [UserLinkChannel].[ChannelId] = [Channel].[Id]
        WHERE [UserLinkChannel].[UserId] = @userId 
      ) AND 
      [EmergencyTimeSignature].[Time] >= @dailyLowerBound AND [EmergencyTimeSignature].[Time] <= @dailyNow
    
    UNION ALL
    
    SELECT 
      3 [GroupKey],
      'Нештатные ситуации' [GroupName],
      'Всего сообщений за текущие сутки' [Description],
      CONVERT(NVARCHAR(128), COUNT(*))  [Value]    
    FROM [Business].[EmergencyMessage] [EmergencyMessage] WITH(NOLOCK)  
      INNER JOIN [Business].[UserAdditionalInfo] [UserAdditionalInfo] WITH(NOLOCK) ON [EmergencyMessage].[UserAdditionalInfoId] = [UserAdditionalInfo].[Id]
      WHERE [UserAdditionalInfo].[Id] = @userId AND 
        [EmergencyMessage].[Time] >= @dailyLowerBound AND [EmergencyMessage].[Time] <= @dailyNow 
    )
  SELECT ROW_NUMBER() OVER(ORDER BY [GroupKey]) [Num], *
  FROM UserExtendedInfoSummary

    
END;