
-- ====================================================================================================
-- Author:  	Maxim Okulin
-- Create date: 25 April 2018
-- Update date: 25 April 2018
-- Description: Рассчитывает интегратор на заданную дату, относительно заданной даты итогового архива, находящегося раньше рассчитываемой даты
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[CalculateVkt7IntegratorAfterFinalDate]
	@measurementDeviceId INT,
	@periodTypeId INT,
	@diffParameterId INT,
	@sumParameterId INT,
	@date DATETIME,
	@finalDate DATETIME
AS
	DECLARE @FaultValue DECIMAL(19, 7) = -2000000.0;

  DECLARE @periodBegin DATETIME;
  DECLARE @periodEnd DATETIME;


  SET @periodBegin = DATEADD(DAY, 1, @finalDate);

  IF @periodBegin = @date 
    BEGIN
      SELECT
        [FinalArchive].[Value]
      FROM [Business].[Archive] [FinalArchive] WITH (NOLOCK)
      WHERE [FinalArchive].[MeasurementDeviceId] = @measurementDeviceId
      AND [FinalArchive].[PeriodTypeId] = 6
      AND [FinalArchive].[Time] = @finalDate
      AND [FinalArchive].[DeviceParameterId] = @sumParameterId
    END
  
  ELSE
  BEGIN

  SET @periodEnd = DATEADD(DAY, -1, @date);


  -- из итогового значения вычитаем сумму разностных значений, которые были до периода итогового значения
  SELECT
    (SELECT
        [FinalArchive].[Value]
      FROM [Business].[Archive] [FinalArchive] WITH (NOLOCK)
      WHERE [FinalArchive].[MeasurementDeviceId] = @measurementDeviceId
      AND [FinalArchive].[PeriodTypeId] = 6
      AND [FinalArchive].[Time] = @finalDate
      AND [FinalArchive].[DeviceParameterId] = @sumParameterId)
    + (SELECT
        SUM([SumArchive].[Value])
      FROM [Business].[Archive] [SumArchive] WITH (NOLOCK)
      WHERE [SumArchive].[MeasurementDeviceId] = @measurementDeviceId
      AND [SumArchive].[PeriodTypeId] = 3
      AND [SumArchive].[Time] > @finalDate
      AND [SumArchive].[Time] <= @periodEnd
      AND [SumArchive].[DeviceParameterId] = @diffParameterId
      AND [SumArchive].[Value] > @FaultValue)
  END

RETURN 0
