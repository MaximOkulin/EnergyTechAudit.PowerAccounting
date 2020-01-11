-- ====================================================================================================
-- Author:  	Leo
-- Create date: 2019-07-22
-- Update date: 2019-07-23
-- Description: 
-- ====================================================================================================

CREATE PROCEDURE [Programmability].[GetIndividualAccountingBalanceSheet] 
    @userName NVARCHAR(64),
    @buildingId INT,
    @resourceSystemTypeId INT,
    @periodBegin DATETIME,
    @periodEnd DATETIME
AS
BEGIN

  DECLARE @finalInstancePeriodType INT = 5;       -- const
  SET NOCOUNT ON;
  SET XACT_ABORT ON;
    
  BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  	BEGIN TRANSACTION;    
  
    DECLARE @isDebug BIT = 1;
  
    SET @periodBegin = CAST(CAST(@periodBegin AS DATE) AS DATETIME);
    SET @periodEnd = CAST(CAST(@periodEnd AS DATE) AS DATETIME);
    
    DECLARE @periodEndWithInclude DATETIME = DATEADD(DAY, 1, @periodEnd);
    
    DECLARE 
      @resourceSystemTypeMapParametrer TABLE 
      (
        ResourceSystemType INT NOT NULL,
        ParameterId INT NOT NULL    
      );
      
      INSERT INTO @resourceSystemTypeMapParametrer VALUES 
        (2, 40), 
        (5, 469);
    
    /* Let's build table with result sets names that will be returned from the stored procedure */
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    
    INSERT INTO @resultSetName 
    OUTPUT inserted.[Order], inserted.[Name]
    VALUES    
        (1, 'ReportParameter'),
        (2, 'MainData'),
        (3, 'SummaryData');
          
    /* Report parameters resultset */    
    
    DECLARE @reportParameter [Programmability].[CustomParameterTableType];
    
    INSERT INTO @reportParameter SELECT [Name], [Value] FROM
      (        
        SELECT TOP 1
          CAST([Dimension].[Prefix] AS NVARCHAR(128)) [DimensionPrefix],
          CAST([MeasurementUnit].[Description] AS NVARCHAR(128)) [MeasurementUnitDescription],
          CAST([ResourceSystemType].[ShortName] AS NVARCHAR(128)) [ResourceSystemTypeShortName],
          CAST([ResourceSystemType].[Description] AS NVARCHAR(128)) [ResourceSystemTypeDescription]
      
        FROM [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] 
        INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [ChannelTemplate].[Id]
        INNER JOIN [Dictionaries].[ResourceSystemType] [ResourceSystemType] ON [ChannelTemplate].[ResourceSystemTypeId] = [ResourceSystemType].[Id]

        INNER JOIN [Dictionaries].[Parameter] [Parameter] ON [ParameterMapDeviceParameter].[ParameterId] = [Parameter].[Id]
        INNER JOIN [Dictionaries].[MeasurementUnit] [MeasurementUnit] ON [ParameterMapDeviceParameter].[MeasurementUnitId] = [MeasurementUnit].[Id]
        INNER JOIN [Dictionaries].[Dimension] [Dimension] ON [ParameterMapDeviceParameter].[DimensionId] = [Dimension].[Id]
      
        WHERE  [ParameterMapDeviceParameter].[ParameterId] IN      
            (
              SELECT [ResourceSystemTypeMapParametrer].[ParameterId] 
                FROM @resourceSystemTypeMapParametrer [ResourceSystemTypeMapParametrer] 
              WHERE [ResourceSystemTypeMapParametrer].[ResourceSystemType] =  @resourceSystemTypeId
            )        
      ) [MeasurementUnitInfo]
      UNPIVOT 
      (  
        [Value] FOR [Name] IN 
        (
          [DimensionPrefix],
    			[MeasurementUnitDescription],
          [ResourceSystemTypeShortName],
        [ResourceSystemTypeDescription]		  
        ) 
    ) [ReportParameter];
    
    INSERT INTO @reportParameter SELECT [Name], [Value] FROM
    (
      SELECT 
        CAST([Building].[Description] AS NVARCHAR(128)) [BuildingDescription] , 
        CAST([District].[Description] AS NVARCHAR(128)) [District]          
      FROM [Business].[Building] [Building] WITH(NOLOCK)
      INNER JOIN [Dictionaries].[District] [District] WITH(NOLOCK)
        ON [Building].[DistrictId] = [District].[Id]
    
      WHERE [Building].[Id] = @buildingId
    ) [BuildingInfo]   
    UNPIVOT 
    (
    	[Value] FOR [Name] IN ([BuildingDescription], [District])
    ) [ReportParameter];
          
    SELECT [ReportParameter].[Name], [ReportParameter].[Value]  FROM @reportParameter [ReportParameter];
    
    ;WITH [IndividualAccountingArchive]
     AS
     (
        SELECT
          [Archive].[Id]
         ,[Archive].[Time]
         ,[Archive].[Value]
         ,[Archive].[MeasurementDeviceId]
         ,[Archive].[DeviceParameterId]
         ,[Archive].[TimeSignatureId]
        FROM [Business].[Archive] [Archive] WITH (NOLOCK)
        WHERE [Archive].[PeriodTypeId] = @finalInstancePeriodType AND 
          -- the most preferred and the fastest way (excluding TimeSignature) 
          [Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEndWithInclude  
      )
      SELECT 
            [IndividualAccountingResult].[PlacementNumber]
            ,[IndividualAccountingResult].[ChannelDescription]
            ,[IndividualAccountingResult].[Diff]
            ,[IndividualAccountingResult].[Value]        
               
        FROM
      (
        SELECT       
        ROW_NUMBER() OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [IndividualAccountingArchive].[Time] DESC) [Num]    

       ,LAST_VALUE([IndividualAccountingArchive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [IndividualAccountingArchive].[Time] ASC) 
          - FIRST_VALUE([IndividualAccountingArchive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [IndividualAccountingArchive].[Time] ASC) [Diff]   
       ,LAST_VALUE([IndividualAccountingArchive].[Value]) OVER (PARTITION BY [Channel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [IndividualAccountingArchive].[Time] ASC) [Value]
       ,[IndividualAccountingArchive].[Time]   
       ,[Channel].[Description] [ChannelDescription]  
       ,[Placement].[Number] [PlacementNumber]   
           	 
      FROM [Business].[Channel] [Channel] WITH (NOLOCK)
    
    
      INNER JOIN [Business].[Placement] [Placement] WITH (NOLOCK)
        ON [Placement].[BuildingId] = @buildingId
          AND [Placement].[HasIndividualAccounting] = 1
          AND [Placement].[Id] = [Channel].[PlacementId]
      
      INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
        ON [MeasurementDevice].[Id] = [Channel].[MeasurementDeviceId]
    
      INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
        ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [Channel].[ChannelTemplateId]
          AND [ParameterMapDeviceParameter].[PeriodTypeId] = @finalInstancePeriodType
        
        -- Let them be selected achive values for the given ParamerterId's from ResourceSystemTypeMapParametrer
          AND [ParameterMapDeviceParameter].[ParameterId] IN      
          (
            SELECT [ResourceSystemTypeMapParametrer].[ParameterId] 
              FROM @resourceSystemTypeMapParametrer [ResourceSystemTypeMapParametrer] 
            WHERE [ResourceSystemTypeMapParametrer].[ResourceSystemType] =  @resourceSystemTypeId
          )  
    
      
      INNER JOIN [Dictionaries].[DeviceParameter] [DeviceParameter] WITH (NOLOCK)
        ON [DeviceParameter].[Id] = [ParameterMapDeviceParameter].[DeviceParameterId]
     
      LEFT JOIN [IndividualAccountingArchive] WITH (NOLOCK)
        ON [IndividualAccountingArchive].[MeasurementDeviceId] = [Channel].[MeasurementDeviceId]
          AND [IndividualAccountingArchive].[DeviceParameterId] = [DeviceParameter].[Id]
    
      WHERE [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId
      )[IndividualAccountingResult] WHERE [IndividualAccountingResult].[Num] = 1
    
    /* Channels list of measuring devices of common house accounting */
    
    ;WITH [CommonHouseAccountingChannel]
    AS
    (
      SELECT 
      
        [Channel].[Id], 
        [Channel].[ChannelTemplateId],
        [Channel].[MeasurementDeviceId], 
        [Channel].[Description] [ChannelDescription], 
           
        [ParameterMapDeviceParameter].[ParameterId] [ParameterId]
     
      FROM [Business].[Channel] [Channel] WITH(NOLOCK)
      
      INNER JOIN [Business].[Placement] [Placement] WITH(NOLOCK) 
        ON [Channel].[PlacementId] = [Placement].[Id] AND [Placement].[PlacementPurposeId] = 2
    
      INNER JOIN [Business].[Building] [Building] WITH(NOLOCK) 
        ON [Placement].[BuildingId] = [Building].[Id] AND [Building].[Id] = @buildingId
      
      INNER JOIN [Business].[ChannelTemplate] [ChannelTemplate] WITH(NOLOCK) 
        ON [Channel].[ChannelTemplateId] = [ChannelTemplate].[Id]
    
      INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH(NOLOCK) 
        ON [ChannelTemplate].[Id] = [ParameterMapDeviceParameter].[ChannelTemplateId] 
        
        AND [ParameterMapDeviceParameter].[PeriodTypeId] = @finalInstancePeriodType 
        AND [ParameterMapDeviceParameter].[ParameterId]  IN 
        (
            SELECT [ResourceSystemTypeMapParametrer].[ParameterId] 
              FROM @resourceSystemTypeMapParametrer [ResourceSystemTypeMapParametrer] 
            WHERE [ResourceSystemTypeMapParametrer].[ResourceSystemType] =  @resourceSystemTypeId
        )
    
      WHERE [Channel].[ResourceSystemTypeId] = @resourceSystemTypeId
    ),
    
    /* Measuring results of common house accounting devices */
    [CommonHouseAccountingArchive]
    AS
    (
       SELECT       
         [Archive].[Time]
         ,[Archive].[Value]
         ,[Archive].[MeasurementDeviceId]
         ,[Archive].[DeviceParameterId]
         
        FROM [Business].[Archive] [Archive] WITH (NOLOCK)
        WHERE [Archive].[PeriodTypeId] = @finalInstancePeriodType AND
          -- the most preferred and the fastest way (excluding TimeSignature) 
          [Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEndWithInclude  
    )
     
    SELECT 
      [CommonHouseAccountingResult].[Num] [MeasurementDeviceNumber]
      ,[CommonHouseAccountingResult].[ChannelDescription]
      ,[CommonHouseAccountingResult].[Diff]
      ,[CommonHouseAccountingResult].[Value]  
           
    FROM 
    (
    SELECT    
      ROW_NUMBER() OVER (PARTITION BY [CommonHouseAccountingChannel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [CommonHouseAccountingArchive].[Time] DESC) [Num]          
      
      ,LAST_VALUE([CommonHouseAccountingArchive].[Value]) OVER (PARTITION BY [CommonHouseAccountingChannel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [CommonHouseAccountingArchive].[Time] ASC) 
        - FIRST_VALUE([CommonHouseAccountingArchive].[Value]) OVER (PARTITION BY [CommonHouseAccountingChannel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [CommonHouseAccountingArchive].[Time] ASC) [Diff]
      
      ,LAST_VALUE([CommonHouseAccountingArchive].[Value]) OVER (PARTITION BY [CommonHouseAccountingChannel].[Id], [ParameterMapDeviceParameter].[Id] ORDER BY [CommonHouseAccountingArchive].[Time] ASC)  [Value]
      ,[CommonHouseAccountingArchive].[Time]      
      ,[CommonHouseAccountingChannel].[ChannelDescription]
      
    
      FROM [CommonHouseAccountingArchive]
    
      INNER JOIN [Business].[MeasurementDevice] [MeasurementDevice] WITH (NOLOCK)
        ON [MeasurementDevice].[Id] = [CommonHouseAccountingArchive].[MeasurementDeviceId]
    
      INNER JOIN [CommonHouseAccountingChannel] 
        ON [MeasurementDevice].[Id] = [CommonHouseAccountingChannel].[MeasurementDeviceId]
    
      INNER JOIN [Business].[ParameterMapDeviceParameter] [ParameterMapDeviceParameter] WITH (NOLOCK)
        ON [ParameterMapDeviceParameter].[ChannelTemplateId] = [CommonHouseAccountingChannel].[ChannelTemplateId]
    
          AND [ParameterMapDeviceParameter].[PeriodTypeId] = @finalInstancePeriodType 
          AND [CommonHouseAccountingArchive].[DeviceParameterId] = [ParameterMapDeviceParameter].[DeviceParameterId]
    
          -- Let them be selected achive values for the given ParamerterId's from ResourceSystemTypeMapParametrer
          AND [ParameterMapDeviceParameter].[ParameterId] IN      
          (
            SELECT [ResourceSystemTypeMapParametrer].[ParameterId] 
              FROM @resourceSystemTypeMapParametrer [ResourceSystemTypeMapParametrer] 
            WHERE [ResourceSystemTypeMapParametrer].[ResourceSystemType] =  @resourceSystemTypeId
          )  
    ) [CommonHouseAccountingResult] WHERE [CommonHouseAccountingResult].[Num] = 1
    ;
  
    COMMIT TRANSACTION;
  END TRY

  BEGIN CATCH
    PRINT ERROR_MESSAGE();
         
    IF (XACT_STATE()) = -1
    BEGIN       
      ROLLBACK TRANSACTION;
    END;
        
   
    IF (XACT_STATE()) = 1
    BEGIN      
      COMMIT TRANSACTION;   
    END;
  
    IF (@isDebug = 0)
    BEGIN
  
          DECLARE @lineFeed CHAR(1) = CHAR(13);
          
          DECLARE @parameterListTrace NVARCHAR(256) = 
          CONCAT
          (  
            '@userName: ' ,            @userName, @lineFeed, 
            '@resourceSystemTypeId: ', @resourceSystemTypeId, @lineFeed, 
            '@buildingId: ',           @buildingId, @lineFeed, 
            '@periodBegin: ',          @periodBegin, @lineFeed, 
            '@periodEnd: ',            @periodEnd, @lineFeed
          );
          
          DECLARE @errorMessage NVARCHAR(MAX) = 
          CONCAT
          (
            'ErrorNumber: ',     ERROR_NUMBER(), @lineFeed,
            'ErrorSeverity: ',   ERROR_SEVERITY(), @lineFeed,
            'ErrorState: ' ,     ERROR_STATE(), @lineFeed,
            'ErrorProcedure: ',  ERROR_PROCEDURE(), @lineFeed,
            'ErrorLine: ',       ERROR_LINE(), @lineFeed,
            'ErrorMessage: ',    ERROR_MESSAGE()
          );
          
          INSERT INTO [Admin].[ErrorLogEntry] 
          (
            [Time], 
            [Exception], 
            [Message], 
            [UserName],
            [StackTrace]
          )
          VALUES
          (
            GETDATE(), 
            'InternalSqlServerException', 
            @errorMessage, 
            SUSER_NAME(),
           @parameterListTrace
          );
          
          THROW;
    END;
  
  END CATCH;
END;
 