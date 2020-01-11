-- ====================================================================================================
-- Author:  	Maxim Okulin
-- Create date: 24 November 2015
-- Update date: 24 November 2015
-- Description: Возвращает значения часовых накопительных параметров по времени
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetTv7IntegratingParameters]
	@measurementDeviceId INT,
	@time DATETIME,
	@isDiff BIT = 0 -- 0 - возвращать просуммированные значения / 1 - возвращать разностные значения
AS
	CREATE TABLE #Result  (SumParamId INT NOT NULL, DiffParamId INT NOT NULL, 
                          Name VARCHAR(32) NOT NULL, Value DECIMAL(19, 7)) 

    INSERT INTO #Result (SumParamId, DiffParamId, Name)
	VALUES (4049, 4083, 'V1Sum'),
	       (4050, 4084, 'V2Sum'),
		   (4051, 4085, 'V3Sum'),
		   (4052, 4086, 'V4Sum'),
		   (4053, 4087, 'V5Sum'),
		   (4054, 4088, 'V6Sum'),
		   (4055, 4089, 'M1Sum'),
		   (4056, 4090, 'M2Sum'),
		   (4057, 4091, 'M3Sum'),
		   (4058, 4092, 'M4Sum'),
		   (4059, 4093, 'M5Sum'),
		   (4060, 4094, 'M6Sum'),
		   (4061, 4095, 'dM1Sum'),
		   (4062, 4096, 'dM2Sum'),
		   (4063, 4097, 'Qtv1Sum'),
		   (4064, 4098, 'Qtv2Sum'),
		   (4065, 4099, 'Q121Sum'),
		   (4066, 4100, 'Q122Sum'),
		   (4067, 4101, 'Qg1Sum'),
		   (4068, 4102, 'Qg2Sum'),
		   (4069, 4103, 'Tnorm1Sum'),
		   (4070, 4104, 'Tnorm2Sum'),
		   (4071, 4105, 'Tden1Sum'),
		   (4072, 4106, 'Tden2Sum')

	  IF(@isDiff = 1)
	  BEGIN
	  UPDATE #Result SET [Value] = (SELECT [Archive].[Value]
                                      FROM [Business].[Archive] [Archive]
									  WHERE [Archive].[MeasurementDeviceId] = @measurementDeviceId AND [Archive].[PeriodTypeId] = 2 AND [Archive].[Time] = @time AND [Archive].[DeviceParameterId] = DiffParamId) 	  	  
	  END
	  ELSE
	  BEGIN
	   UPDATE #Result SET [Value] = (SELECT [Archive].[Value]
                                      FROM [Business].[Archive] [Archive]
									  WHERE [Archive].[MeasurementDeviceId] = @measurementDeviceId AND [Archive].[PeriodTypeId] = 2 AND [Archive].[Time] = @time AND [Archive].[DeviceParameterId] = SumParamId) 	  
	  END
    
	 DECLARE @PivotFields VARCHAR(512)
     SELECT @PivotFields = ISNULL( @PivotFields + ',' + '[' +Name + ']', '[' +Name + ']')  FROM #Result

  	 DECLARE @query VARCHAR (2048) = 'SELECT ' + @PivotFields + ' FROM (SELECT Name, Value FROM #Result) as MyTable
     PIVOT (AVG(Value) FOR Name IN (' +  @PivotFields +')) PivotTable'
     EXEC ( @query )
RETURN 0
