SET IDENTITY_INSERT Business.ChannelTemplate ON;
GO

INSERT Business.ChannelTemplate(Id, Description, ResourceSystemTypeId, DeviceId, MnemoschemeId, Comment, ResourceSubsystemTypeId, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
	VALUES (5002, N'Meteostation - "Система мониторинга"', 8, 52, NULL, NULL, NULL, N'sys', N'sys', '2017-09-25 11:43:26.997', '2017-09-25 11:43:31.353')
GO

SET IDENTITY_INSERT Business.ChannelTemplate OFF;
GO
