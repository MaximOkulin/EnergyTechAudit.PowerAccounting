-- ===================================================================================================
-- Author:  	  Leo
-- Create date: 2014-11-23
-- Description: 
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetDashboardDiagrammArchives]
  @measurementDeviceId INT,  
  @parameterMapDeviceParameterId INT,  
  @periodBegin DATETIME,
  @periodEnd DATETIME  
AS

BEGIN  
  SET NOCOUNT ON;
  
  SET XACT_ABORT ON;

  BEGIN TRY
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN TRANSACTION;
       	 
    DECLARE @resultSetName [Programmability].[ResultSetNameTableType];
    INSERT INTO @resultSetName VALUES 
         (1, 'MainData'),    
         (2, 'ConvertableUnit');   

    SELECT [ResultSetName].[Order], [ResultSetName].[Name]
	  FROM @resultSetName [ResultSetName];
  
    SELECT 
      [Archive].[Time] [Time],
      [Archive].[TimeSignatureId] [TimeSignatureId],
      [dbo].[ConvertMeasurementUnit]
      (
        [ParameterMapDeviceParameterWithUnitCovertor].[DimensionValue], 
        [ParameterMapDeviceParameterWithUnitCovertor].[DimensionValue2], 
        [Archive].[Value], 
        [ParameterMapDeviceParameterWithUnitCovertor].[Expression]
      ) [Value]

    FROM [Business].[Archive] [Archive] 

    CROSS APPLY [Programmability].[GetDashboardDiagrammParameterMapDeviceParameterWithUnitCovertor] 
    (
      @parameterMapDeviceParameterId
    ) [ParameterMapDeviceParameterWithUnitCovertor]
      
    WHERE      
       [Archive].[MeasurementDeviceId] = @measurementDeviceId AND 
       [Archive].[PeriodTypeId] = [ParameterMapDeviceParameterWithUnitCovertor].[PeriodTypeId] AND 
       [Archive].[DeviceParameterId] = [ParameterMapDeviceParameterWithUnitCovertor].[DeviceParameterId] AND 
       ([Archive].[Time] >= @periodBegin AND [Archive].[Time] <= @periodEnd) AND
       [Archive].[IsValid] = 1

    ORDER BY [Archive] .[Time]

    SELECT  
      [ParameterMapDeviceParameterWithUnitCovertor].[Id],
      [Parameter].[Description] [ParameterDescription],
      [ParameterMapDeviceParameterWithUnitCovertor].[MeasurementUnitDescription],
      [ParameterMapDeviceParameterWithUnitCovertor].[DimensionPrefix],
      [PhysicalParameter].[Code] [PhysicalParameterCode]

    FROM [Programmability].[GetDashboardDiagrammParameterMapDeviceParameterWithUnitCovertor]
    (
      @parameterMapDeviceParameterId
    ) [ParameterMapDeviceParameterWithUnitCovertor]

    INNER JOIN [Dictionaries].[Parameter] [Parameter]
      ON [Parameter].[Id] = [ParameterMapDeviceParameterWithUnitCovertor].[ParameterId]
    
    INNER JOIN [Dictionaries].[PhysicalParameter] [PhysicalParameter]
      ON [PhysicalParameter].[Id] = [Parameter].[PhysicalParameterId];

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

  RETURN (0);

END;