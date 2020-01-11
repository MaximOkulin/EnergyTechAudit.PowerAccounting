SET IDENTITY_INSERT [Core].[Pivot] ON;

INSERT INTO [Core].[Pivot] ([Id],[Code],[Description])
VALUES
  (1,'ChannelDistribution','Распределение каналов измерительных устройств'),  
  (2,'MeasurementDeviceDistribution','Распределение измерительных устройств')
GO

SET IDENTITY_INSERT [Core].[Pivot] OFF;
GO