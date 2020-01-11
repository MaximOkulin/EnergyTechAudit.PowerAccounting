-- ====================================================================================================
-- Author:  	Leo
-- Create date: 20150902
-- Description: Возвращает XML-ответ метода Web API со списком устройств системы 
-- с привязками к строению и списком каналов 
-- ===================================================================================================

CREATE PROCEDURE WebApi.GetMeasurementDeviceInfo
(
  @userName NVARCHAR(64),
  @name NVARCHAR(128) = 'MesurementDevice',
  @actionUid UNIQUEIDENTIFIER OUTPUT
)	
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @dateTime DATETIME = GETDATE();
   DECLARE @uid UNIQUEIDENTIFIER = NEWID();
   DECLARE @methodName VARCHAR(64) = 'MeasurementDeviceInfo';
   DECLARE @error NVARCHAR(128); 
   SET @actionUid = @uid;

   BEGIN TRY	    	
    SELECT     
    @dateTime [DateTime], 
    @uid [Uid],
    @methodName [MethodName],     
    (
	    SELECT 
      (
          SELECT 
            [MeasurementDevice].[Id], 
            [MeasurementDevice].[DeviceId],
            [MeasurementDevice].[FactoryNumber],
            (
              SELECT TOP(1)
                [Building].[Id] [Id], 
                [Building].[FullAddress] [FullAddress],         
                CAST([Building].[Location] AS VARCHAR(MAX)) [Location]                 
              FROM [Business].[Building] [Building] WITH (NOLOCK)                  
              INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK) 
                ON [Building].[Id] = [Placement].[BuildingId]
  		        INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)	
                ON [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id] AND [Placement].[Id] = [Channel].[PlacementId]
              FOR XML AUTO, ELEMENTS, TYPE
            ), 
            (
              SELECT 
                [Channel].[Id], 
                [Channel].[ChannelTemplateId],
                [Channel].[ResourceSystemTypeId]
              FROM [Business].[Channel] [Channel] WITH (NOLOCK) 

              INNER JOIN  
              (
                SELECT [Channel].[Id] [Id]
  
                      FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
              
                        INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                          ON [Channel].[Id] = [UserLinkChannel].[ChannelId] 
                                          
                        INNER JOIN [Admin].[User] [User] WITH(NOLOCK)
                          ON [UserLinkChannel].[UserId] = [User].[Id]
              
                      WHERE [User].[UserName] = @userName
              
                      UNION
              
                      SELECT [Channel].[Id] [Id]
              
                      FROM [WebApi].[ArchiveDownloader] [ArchiveDownloader] WITH (NOLOCK)
                
                        INNER JOIN [Admin].[User] [User] WITH (NOLOCK)
                          ON [User].[Id] = [ArchiveDownloader].[Id]
              
                        INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
                          ON [Channel].[OrganizationId] = [ArchiveDownloader].[OrganizationId] 
                            
                      WHERE [User].[UserName] = @userName
              ) [Ch] ON [Ch].[Id] = [Channel].[Id]

              WHERE [Channel].[MeasurementDeviceId] = [MeasurementDevice].[Id]

              FOR XML AUTO, ELEMENTS, TYPE, ROOT('Channels')
            )
          FROM (
          SELECT 
            ROW_NUMBER() OVER(PARTITION BY [MeasurementDevice].[Id] ORDER BY  [MeasurementDevice].[Id]) [Num],
            [MeasurementDevice].[Id], 
            [MeasurementDevice].[DeviceId],
            [MeasurementDevice].[FactoryNumber]
  
            FROM [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK) 
            
            INNER JOIN 
                ( 
                  SELECT [ChannelOuter].[MeasurementDeviceId]
                  FROM
                  (
                      SELECT [Channel].[Id] [Id]
  
                      FROM [Business].[UserLinkChannel] [UserLinkChannel] WITH(NOLOCK)
              
                        INNER JOIN [Business].[Channel] [Channel] WITH(NOLOCK)
                          ON [Channel].[Id] = [UserLinkChannel].[ChannelId] 
                                          
                        INNER JOIN [Admin].[User] [User] WITH(NOLOCK)
                          ON [UserLinkChannel].[UserId] = [User].[Id]
              
                      WHERE [User].[UserName] = @userName
              
                      UNION
              
                      SELECT [Channel].[Id] [Id]
              
                      FROM [WebApi].[ArchiveDownloader] [ArchiveDownloader] WITH (NOLOCK)
                
                        INNER JOIN [Admin].[User] [User] WITH (NOLOCK)
                          ON [User].[Id] = [ArchiveDownloader].[Id]
              
                        INNER JOIN [Business].[Channel] [Channel] WITH (NOLOCK)
                          ON [Channel].[OrganizationId] = [ArchiveDownloader].[OrganizationId] 
                            
                      WHERE [User].[UserName] = @userName
                    ) [ChannelInner] INNER JOIN [Business].[Channel] [ChannelOuter] WITH (NOLOCK) ON [ChannelOuter].[Id] = [ChannelInner].[Id]

                ) [Channel] ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]
            
            ) [MeasurementDevice] 
            WHERE [MeasurementDevice].[Num] = 1
  
            FOR XML AUTO, ELEMENTS, TYPE, ROOT('MeasurementDevices')
          ),
          (
            SELECT [ParameterMapDeviceParameter].[Id], [ParameterMapDeviceParameter].[DeviceParameterId], 
                  [ParameterMapDeviceParameter].[ParameterId], [ParameterMapDeviceParameter].[PeriodTypeId],
                  [ParameterMapDeviceParameter].[DimensionId], [ParameterMapDeviceParameter].[MeasurementUnitId],
                  [ParameterMapDeviceParameter].[ChannelTemplateId]
			       FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK) 
			                   
			       FOR XML AUTO, ELEMENTS, TYPE,  ROOT('ParameterMapDeviceParameters')
          )          
	    FOR XML PATH('Business'), ELEMENTS, TYPE 
	  ), 
    (
         SELECT 'Не все словари могут быть доступны через Web API.' AS '@notAllDictionaryAvailible',          
          (
            SELECT [Dictionary].[Id], [Dictionary].[Code], [Dictionary].[Description]
            FROM [Core].[Dictionary] [Dictionary] 
            WHERE [Dictionary].[Id] NOT IN (21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 5)

            FOR XML PATH('DictionaryEntityName'), ELEMENTS, TYPE
          )
          FOR XML PATH('Dictionaries'), ELEMENTS, TYPE
    )
	  FOR XML PATH('Package')
  END TRY
  BEGIN CATCH
	  SET @error = 'Внутренняя ошибка выполнения запроса. ' + ERROR_MESSAGE();
      SELECT 
         @dateTime [DateTime], 
         @uid [Uid],
         @methodName [MethodName],      
         @error [Message]             
      FOR XML PATH('Error'), ELEMENTS, TYPE;  
  END CATCH
END;
GO