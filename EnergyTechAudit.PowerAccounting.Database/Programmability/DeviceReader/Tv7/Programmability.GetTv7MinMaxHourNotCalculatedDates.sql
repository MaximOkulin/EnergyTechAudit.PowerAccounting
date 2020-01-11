-- ====================================================================================================
-- Author:  	Maxim Okulin
-- Create date: 24 November 2015
-- Update date: 24 November 2015
-- Description: Возвращает диапазон дат, в котором находятся часовые архивы с нерассчитанными интеграторами ТВ-7
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetTv7MinMaxHourNotCalculatedDates]
	@measurementDeviceId INT
	
AS
    --V1Diff
    DECLARE @diffParameterId INT = 4083;
	--V1Sum
	DECLARE @sumParameterId INT = 4049;

	SELECT MIN([ArchiveBase].[Time]) [Min], MAX([ArchiveBase].[Time]) [Max]
	  FROM [Business].[Archive] [ArchiveBase] WITH(NOLOCK)
	  LEFT JOIN [Business].[Archive] [ArchiveSum] WITH(NOLOCK)
	  ON
	  [ArchiveBase].[MeasurementDeviceId] = [ArchiveSum].[MeasurementDeviceId] AND
	  [ArchiveBase].[PeriodTypeId] = [ArchiveSum].[PeriodTypeId] AND
	  [ArchiveBase].[Time] = [ArchiveSum].[Time] AND
	  [ArchiveBase].[DeviceParameterId] = @diffParameterId AND [ArchiveSum].[DeviceParameterId] = @sumParameterId AND [ArchiveBase].[DeviceParameterId] IS NOT NULL
	  WHERE [ArchiveSum].[Time] IS NULL AND
	        [ArchiveBase].[DeviceParameterId] = @diffParameterId AND
			[ArchiveBase].[MeasurementDeviceId] = @measurementDeviceId AND
			[ArchiveBase].[PeriodTypeId] = 2

RETURN 0
