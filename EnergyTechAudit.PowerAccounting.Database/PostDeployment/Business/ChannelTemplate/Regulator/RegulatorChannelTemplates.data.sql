﻿SET IDENTITY_INSERT Business.ChannelTemplate ON;
GO

INSERT Business.ChannelTemplate(Id, Description, ResourceSystemTypeId, DeviceId, MnemoschemeId, Comment, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
  VALUES 
   -- РЕГУЛИРОВАНИЕ
         (43, N'ECL310 - "Система регулирования" (A368.1, ЦО, контур 1)', 6, 8, NULL, N'A368.1, ЦО, контур 1', N'sys', N'sys', N'20171109', N'20171109'),
		 (49, N'ECL310 - "Система регулирования" (A266.1, ЦО, контур 1)', 6, 8, NULL, N'A266.1, ЦО, контур 1', N'sys', N'sys', N'20151103', N'20151103'),
		 (52, N'ECL310 - "Система регулирования" (A266.1, ЦО(к1)+ГВС(к2))', 6, 8, NULL, N'A266.1, ЦО(к1)+ГВС(к2)', N'sys', N'sys', N'20160420', N'20160420'),
		 (53, N'ECL310 - "Система регулирования" (A230.1, ЦО)', 6, 8, 1, N'A230.1, ЦО', N'sys', N'sys', N'20160420', N'20160420'),
		 (54, N'ECL310 - "Система регулирования" (A266.1, ГВС, контур 2)', 6, 8, NULL, N'A266.1, ГВС, контур 2', N'sys', N'sys', N'20160420', N'20160420'),
		 (55, N'ECL 300 - "Система регулирования" (C66 - ЦО+ГВС)', 6, 34, NULL, N'C66 - ЦО+ГВС', N'sys', N'sys', N'20160929', N'20160929'),
		 (56, N'ECL310 - "Система регулирования" (A231.1, ЦО)', 6, 8, NULL, N'A231.1, ЦО', N'sys', N'sys', N'20170213', N'20170213'),
		 (57, N'ECL310 - "Система регулирования" (A331.1, ЦО)', 6, 8, NULL, N'A331.1, ЦО', N'sys', N'sys', N'20170213', N'20170213'),
		 (61, N'ECL310 - "Система регулирования" (A368.1, ГВС, контур 2)', 6, 8, NULL, N'A368.1, ГВС, контур 2', N'sys', N'sys', N'20171213', N'20171213'),
		 (63, N'ECL310 - "Система регулирования" (A368.3, ЦО, контур 1)', 6, 8, NULL, N'A368.3, ЦО, контур 1', N'sys', N'sys', N'20171214', N'20171214'),
		 (64, N'ECL310 - "Система регулирования" (A368.3, ГВС, контур 2)', 6, 8, NULL, N'A368.3, ГВС, контур 2', N'sys', N'sys', N'20171214', N'20171214'),
		 (149, N'ECL310 - "Система регулирования" (A368.6, ЦО, контур 1)', 6, 8, NULL, N'A368.6, ЦО, контур 1', N'sys', N'sys', N'20181005', N'20181005'),
         (174, N'ECL310 - "Система регулирования" (A368.6, ГВС, контур 2)', 6, 8, NULL, N'A368.6, ГВС, контур 2', N'sys', N'sys', N'20181005', N'20181005'),
		 (180, N'DanfossMCX - "Система регулирования" (тем-ра наруж., в помещении, подачи и обратки)', 6, 74, NULL, N'тем-ра наруж., в помещении, подачи и обратки', N'sys', N'sys', N'20181120', N'20181120'),
		 (182, N'ECL 300 - "Система регулирования" (C66(RS485) - ЦО, контур 1)', 6, 34, NULL, N'C66(RS485) - ЦО, контур 1', N'sys', N'sys', N'20181203', N'20181203'),
         (184, N'ECL310 - "Система регулирования" (A217.3, ГВС)', 6, 8, NULL, N'A217.3, ГВС', N'sys', N'sys', N'20181204', N'20181204'),
		 (191, N'ECL 300 - "Система регулирования" (C66(RS485) - ГВС, контур 2)', 6, 34, NULL, N'C66(RS485) - ГВС, контур 2', N'sys', N'sys', N'20181212', N'20181212'),
	     (214, N'Pramer710 - "Система регулирования"', 6, 79, NULL, NULL, N'sys', N'sys', N'20190324', N'20190324'),
		 (217, N'ECL310 - "Система регулирования" (A260.1, ЦО, контур 1)', 6, 8, NULL, N'A260.1, ЦО, контур 1', N'sys', N'sys', N'20190402', N'20190402'),
		 (218, N'ECL310 - "Система регулирования" (A260.1, ЦО, контур 2)', 6, 8, NULL, N'A260.1, ЦО, контур 2', N'sys', N'sys', N'20190402', N'20190402'),
		 (236, N'VegaTP11 - "Система регулирования" (расцепитель эл-ва, квартира 485)', 6, 72, NULL, N'расцепитель эл-ва, квартира 485', N'sys', N'sys', N'20190710', N'20190710'),
		 (251, N'PR200 - "Система регулирования" (уставки)', 6, 85, NULL, N'уставки', N'sys', N'sys', N'20191017', N'20191017'),
		 (257, N'ECL310 - "Система регулирования" (A266.10, ЦО, контур 1)', 6, 8, NULL, N'A266.10, ЦО, контур 1', N'sys', N'sys', N'20191210', N'20191210'),
		 (258, N'ECL310 - "Система регулирования" (A266.10, ГВС, контур 2)', 6, 8, NULL, N'A266.10, ГВС, контур 2', N'sys', N'sys', N'20191210', N'20191210'),

		 --шаблоны I-7000 для регулирования подачи электричества
		 (68, N'I7000 - "Система регулирования" (подача электричества, DO-0)', 6, 28, NULL, 'подача электричества, DO-0', N'sys', N'sys', N'20160113', N'20160113'),
		 (69, N'I7000 - "Система регулирования" (подача электричества, DO-1)', 6, 28, NULL, 'подача электричества, DO-1', N'sys', N'sys', N'20160113', N'20160113'),
		 (70, N'I7000 - "Система регулирования" (подача электричества, DO-2)', 6, 28, NULL, 'подача электричества, DO-2', N'sys', N'sys', N'20160113', N'20160113'),
		 (71, N'I7000 - "Система регулирования" (подача электричества, DO-3)', 6, 28, NULL, 'подача электричества, DO-3', N'sys', N'sys', N'20160113', N'20160113'),
		 (72, N'I7000 - "Система регулирования" (подача электричества, DO-4)', 6, 28, NULL, 'подача электричества, DO-4', N'sys', N'sys', N'20160113', N'20160113'),
		 (73, N'I7000 - "Система регулирования" (подача электричества, DO-5)', 6, 28, NULL, 'подача электричества, DO-5', N'sys', N'sys', N'20160113', N'20160113'),
		 (74, N'I7000 - "Система регулирования" (подача электричества, DO-6)', 6, 28, NULL, 'подача электричества, DO-6', N'sys', N'sys', N'20160113', N'20160113'),
		 (75, N'I7000 - "Система регулирования" (подача электричества, DO-7)', 6, 28, NULL, 'подача электричества, DO-7', N'sys', N'sys', N'20160113', N'20160113'),
		 (76, N'I7000 - "Система регулирования" (подача электричества, DO-8)', 6, 28, NULL, 'подача электричества, DO-8', N'sys', N'sys', N'20160113', N'20160113'),
		 (77, N'I7000 - "Система регулирования" (подача электричества, DO-9)', 6, 28, NULL, 'подача электричества, DO-9', N'sys', N'sys', N'20160113', N'20160113'),
		 (78, N'I7000 - "Система регулирования" (подача электричества, DO-10)', 6, 28, NULL, 'подача электричества, DO-10', N'sys', N'sys', N'20160113', N'20160113'),
		 (79, N'I7000 - "Система регулирования" (подача электричества, DO-11)', 6, 28, NULL, 'подача электричества, DO-11', N'sys', N'sys', N'20160113', N'20160113'),
		 (80, N'I7000 - "Система регулирования" (подача электричества, DO-12)', 6, 28, NULL, 'подача электричества, DO-12', N'sys', N'sys', N'20160113', N'20160113'),
		 (81, N'I7000 - "Система регулирования" (подача электричества, DO-13)', 6, 28, NULL, 'подача электричества, DO-13', N'sys', N'sys', N'20160113', N'20160113'),
		 (82, N'I7000 - "Система регулирования" (подача электричества, DO-14)', 6, 28, NULL, 'подача электричества, DO-14', N'sys', N'sys', N'20160113', N'20160113'),
		 (83, N'I7000 - "Система регулирования" (подача электричества, DO-15)', 6, 28, NULL, 'подача электричества, DO-15', N'sys', N'sys', N'20160113', N'20160113'),

		 -- I-7000 управление клапаном
		 (84, N'I7000 - "Система регулирования" (управление клапаном, DO-0)', 6, 28, NULL, 'управление клапаном, DO-0', N'sys', N'sys', N'20170301', N'20170301'),

		 -- EtaRelay
		 (201, N'EtaRelay - "Система регулирования"', 6, 60, NULL, NULL, N'sys', N'sys', '20180313', '20180313'), 
		 (202, N'EtaRelay - "Система регулирования" (календарь реле 1, невисокосный год)', 6, 60, NULL, N'календарь реле 1, невисокосный год', N'sys', N'sys', '20180314', '20180314'), 
		 (203, N'EtaRelay - "Система регулирования" (календарь реле 2, невисокосный год)', 6, 60, NULL, N'календарь реле 2, невисокосный год', N'sys', N'sys', '20180316', '20180316'), 
		 (204, N'EtaRelay - "Система регулирования" (календарь реле 1, високосный год)', 6, 60, NULL, N'календарь реле 1, високосный год', N'sys', N'sys', '20180321', '20180321'), 
		 (205, N'EtaRelay - "Система регулирования" (календарь реле 2, високосный год)', 6, 60, NULL, N'календарь реле 2, високосный год', N'sys', N'sys', '20180505', '20180505'), 
		 (206, N'EtaRelay - "Система регулирования" (общие настройки)', 6, 60, NULL, N'общие настройки', N'sys', N'sys', '20180329', '20180329'), 
		 (209, N'ECL110 - "Система регулирования" (приложение 130, ЦО)', 6, 78, 69, N'приложение 130, ЦО', N'sys', N'sys', '20190308', '20190308'), 
		 (211, N'ECL110 - "Система регулирования" (приложение 116, ГВС)', 6, 78, 69, N'приложение 116, ГВС', N'sys', N'sys', '20190313', '20190313'), 

		 (4000, N'SigneticsSMH2Gi - "Система регулирования" (карта ЦО+ГВС)', 6, 41, NULL, 'карта ЦО+ГВС', N'sys', N'sys', N'20170323', N'20170323'),
		 (4001, N'SigneticsSMH2Gi - "Система регулирования" (карта ГВС)', 6, 41, NULL, 'карта ГВС', N'sys', N'sys', N'20170323', N'20170323'),
		 (4002, N'SigneticsSMH2Gi - "Система регулирования" (карта ЦО)', 6, 41, NULL, 'карта ЦО', N'sys', N'sys', N'20170323', N'20170323')


GO



SET IDENTITY_INSERT Business.ChannelTemplate OFF;
GO
