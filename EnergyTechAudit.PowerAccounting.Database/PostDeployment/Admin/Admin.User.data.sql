DELETE FROM [Admin].[User] 

SET IDENTITY_INSERT [Admin].[User]  ON;

INSERT INTO [Admin].[User] ([Id], [RoleId], [UserName], [Description], [Email], [Password],[IsApproved], [IsTemporary], [CreateDate], [ExpiredDate],
									  [CreatedBy], [UpdatedBy], [CreatedDate], [UpdatedDate])
VALUES
	(1, 1, 'sa', 'sa-ADMIN', 'leontev.vyacheslav@yandex.ru', 'GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140421', '20150421', 'sa', 'sa', '20140930', '20140930'),	
	(2, 2, 'oa', 'oa-OPERADMIN', 'eta.development.max@outlook.com',  'GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140421', '20150421', 'sa', 'sa', '20140930', '20140930'),		
	(3, 6, 'Device.Reader', 'Device.Reader-DEVICEREADER', 'eta.development.team@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930'),

	(4, 1, 'eta.sys.leo', 'eta.sys.leo-ADMIN', 'eta.development.leo@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930'),
	(5, 1, 'eta.sys.max', 'eta.sys.max-ADMIN', 'eta.development.max@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930'),
	(6, 1, 'eta.sys.owner', 'eta.sys.owner-ADMIN', 'eta.development.owner@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930'),

	(7, 7, 'eta.oper.leo', 'eta.oper.leo-OPERADMIN', 'eta.development.owner@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930'),
	(8, 7, 'eta.oper.max', 'eta.oper.max-OPERADMIN', 'eta.development.owner@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930'),
	(9, 7, 'eta.oper.owner', 'eta.oper.owner-OPERADMIN', 'eta.development.owner@outlook.com','GWGe8XyPCVqDWEGx/d9Jslz+8Bl7MNKv5qcmAlSUfP4=', 1, 0, '20140509', '20150509', 'sa', 'sa', '20140930', '20140930')
	
SET IDENTITY_INSERT [Admin].[User]  OFF;
