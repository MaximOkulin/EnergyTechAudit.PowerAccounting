  
SET IDENTITY_INSERT Business.ChannelTemplate ON;
GO

INSERT Business.ChannelTemplate(Id, Description, ResourceSystemTypeId, DeviceId, MnemoschemeId, Comment, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
  VALUES 
		 -- СМЕШАННАЯ (ЦО+ГВС)
		 (67, N'TV7 - "Система теплоснабжения смешанная" (ЦО+ГВСЦ)', 10, 27, NULL, '(ЦО+ГВСЦ)', N'sys', N'sys', N'20151214', N'20151214')
		 
GO

SET IDENTITY_INSERT Business.ChannelTemplate OFF;
GO


SET IDENTITY_INSERT Business.ParameterMapDeviceParameter ON;
GO

--TV7 - "Система теплоснабжения смешанная" (ЦО+ГВСЦ) Id = 67
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2976, 20000, 2, 7, 5, 4097, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2977, 20002, 2, 18, 12, 4089, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2978, 20003, 2, 18, 12, 4090, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2979, 20006, 2, 21, 12, 4103, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2980, 20007, 2, 5, 12, 4000, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2981, 20008, 2, 5, 12, 4001, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2982, 20009, 2, 7, 5, 4063, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2983, 20011, 2, 18, 12, 4055, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2984, 20012, 2, 18, 12, 4056, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2985, 20015, 2, 21, 12, 4069, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2986, 20001, 2, 7, 5, 4098, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2987, 20004, 2, 18, 12, 4092, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2988, 20005, 2, 18, 12, 4093, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2989, 20010, 2, 7, 5, 4064, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2990, 20013, 2, 18, 12, 4058, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2991, 20014, 2, 18, 12, 4059, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2992, 20000, 3, 7, 5, 4097, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2993, 20002, 3, 18, 12, 4089, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2994, 20003, 3, 18, 12, 4090, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2995, 20006, 3, 21, 12, 4103, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2996, 20007, 3, 5, 12, 4000, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2997, 20008, 3, 5, 12, 4001, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2998, 20009, 3, 7, 5, 4063, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (2999, 20011, 3, 18, 12, 4055, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3000, 20012, 3, 18, 12, 4056, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3001, 20015, 3, 21, 12, 4069, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3002, 20001, 3, 7, 5, 4098, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3003, 20004, 3, 18, 12, 4092, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3004, 20005, 3, 18, 12, 4093, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3005, 20010, 3, 7, 5, 4064, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3006, 20013, 3, 18, 12, 4058, 18, 1, 1, 67)
INSERT Business.ParameterMapDeviceParameter(Id, ParameterId, PeriodTypeId, MeasurementUnitId, DimensionId, DeviceParameterId, SubsystemTypeId, ParameterDictionaryId, [Order], ChannelTemplateId) VALUES (3007, 20014, 3, 18, 12, 4059, 18, 1, 1, 67)


SET IDENTITY_INSERT Business.ParameterMapDeviceParameter OFF
GO


