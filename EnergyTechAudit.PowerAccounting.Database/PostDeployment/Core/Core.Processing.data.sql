SET IDENTITY_INSERT [Core].[Processing] ON;
GO

INSERT INTO [Core].[Processing] 
	(Id, Code, [Description])
VALUES
	(1, 'DoUserLinkChannel', 'Присоединить каналы к пользователю'),
	(2, 'DownloadArchivePackageBy', 'Выгрузить XML-пакет архива устройства'),
	(3, 'DoMeasurementDevicePollingInterval', 'Изменить интервал опроса устройств')

GO
SET IDENTITY_INSERT [Core].[Processing] OFF;
GO