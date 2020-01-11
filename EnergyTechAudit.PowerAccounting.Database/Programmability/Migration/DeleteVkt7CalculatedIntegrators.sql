DELETE FROM Business.Archive 
WHERE MeasurementDeviceId IN (SELECT md.Id FROM Business.MeasurementDevice md WHERE md.DeviceId = 1) AND 
      DeviceParameterId IN (122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143) AND
      PeriodTypeId IN (2, 3) 