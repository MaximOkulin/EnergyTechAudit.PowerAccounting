

SET IDENTITY_INSERT [Admin].[Role]  ON;
GO
INSERT INTO [Admin].[Role] ([Id], [Code], [Description], [StartupRoute], [MobileDeviceStartupRoute])
VALUES
	(1,'ADMIN', 'Администраторы системы', '/admin/admin', '/'),
	(2, 'OPERADMIN', 'Операционные администраторы', '/operadmin/operadmin', '/operadminmobile/operadminmobile/buildingList'),
	(3, 'ARCHIVEDOWNLOADER', 'Оператор выгрузки архивов', '/', '/'),
	(4, 'GUEST', 'Гости', '/', '/'),
	(5, 'HOLDER', 'Владелец помещения', '/flatholder/flatholder', '/apartmentholdermobile/apartmentholdermobile/channellist'),
	(6, 'DEVICEREADER', 'Считыватель устройств', '/', '/'),
	(7, 'LEADOPERADMIN', 'Ответственные операционные администраторы', '/operadmin/operadmin', '/operadminmobile/operadminmobile/buildingList')
GO
SET IDENTITY_INSERT [Admin].[Role]  OFF;
GO