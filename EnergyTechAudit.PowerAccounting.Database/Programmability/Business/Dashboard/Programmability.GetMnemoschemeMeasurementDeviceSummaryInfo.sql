-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2016-09-05
-- Description: 
-- ===================================================================================================

CREATE PROCEDURE Programmability.GetMnemoschemeMeasurementDeviceSummaryInfo
  @placementId INT,  
  @measurementDeviceId INT,
  @channelId INT  
AS
BEGIN
   SET NOCOUNT ON;
   SET XACT_ABORT ON;

  BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    BEGIN TRANSACTION;

    /* 1. Формирование имен резалтсетов */   	 
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName
    OUTPUT inserted.[Order], inserted.[Name]
    VALUES 
         (1, 'MainData');
    
    /*2. Основная выборка */
      
      SELECT 
        [MeasurementDevice].[Id] [MeasurementDeviceId], 
        [MeasurementDevice].[Description] [MeasurementDeviceDescription], 
        [MeasurementDevice].[LastTimeSignatureId],
        [MeasurementDevice].[FactoryNumber],
        
        [TimeSignature].[Time] [LastTimeSignatureTime],
        
        [Device].[Description] [DeviceDescription],
        [Device].[ShortName] [DeviceShortName],
        [Channel].[Id] [ChannelId],
        [Channel].[Description] [ChannelDescription],

        [Channel].[ChannelTemplateId]

      FROM [Business].[Placement] [Placement]  WITH(NOLOCK)

      INNER JOIN [Business].[Channel] [Channel]  WITH(NOLOCK)
        ON [Channel].[PlacementId] = [Placement].[Id]

      INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice]  WITH(NOLOCK)
        ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]

      INNER JOIN [Dictionaries].[Device] [Device] WITH(NOLOCK)
        ON  [Device].[Id] = [MeasurementDevice].[DeviceId]

      INNER JOIN [Business].[TimeSignature] [TimeSignature] WITH(NOLOCK)
        ON  [TimeSignature].[Id] = [MeasurementDevice].[LastTimeSignatureId] 
        
        WHERE 
          [Placement].[Id] = @placementId 
          OR [Channel].[Id] = @channelId 
          OR [MeasurementDevice].[Id] = @measurementDeviceId
       
       -- ограничение параллелизма на основе исследования 
       OPTION(MAXDOP 2);      
        
       COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
    IF (XACT_STATE()) = -1
    BEGIN       
      ROLLBACK TRANSACTION;
    END;
    IF (XACT_STATE()) = 1
    BEGIN      
      COMMIT TRANSACTION;   
    END;

    RETURN (3); 
  END CATCH;
	   	   	                     
  RETURN 0;

END;
GO