-- ====================================================================================================
-- Author:  	Maxim Okulin
-- Create date: 18 April 2018
-- Update date: 18 April 2018
-- Description: Возвращает все технические параметры прибора
-- ===================================================================================================

CREATE PROCEDURE [Programmability].[GetAllDeviceTechnicalParameters] @measurementDeviceId INT
AS
  SELECT
    dp.Code [Name]
   ,dtp.StringValue [Value]
  FROM Business.DeviceTechnicalParameter dtp
  INNER JOIN Dictionaries.DeviceParameter dp
    ON dtp.DeviceParameterId = dp.Id
  WHERE dtp.MeasurementDeviceId = @measurementDeviceId
GO