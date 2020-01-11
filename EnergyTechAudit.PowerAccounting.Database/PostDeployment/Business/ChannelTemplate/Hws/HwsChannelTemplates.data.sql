﻿SET IDENTITY_INSERT Business.ChannelTemplate ON;
GO

INSERT Business.ChannelTemplate(Id, Description, ResourceSystemTypeId, ResourceSubsystemTypeId, DeviceId, MnemoschemeId, Comment, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
  VALUES 
         (36, N'SGV15D - "Система горячего водоснабжения"', 3, NULL, 24, NULL, NULL, N'sys', N'sys', '20150918', '20150918'),
		 (66, N'Tem104 - "Система горячего водоснабжения" (с циркуляцией, система 1, тр1-тр2)', 3, 1, 54, 39, N'с циркуляцией, система 1, тр1-тр2', N'sys', N'sys', '20171218', '20171218'),
		 (101, N'KM5 - "Система горячего водоснабжения" (с циркуляцией)', 3, 1, 9, 39, N'с циркуляцией', N'sys', N'sys', '20150206', '20150206'),
		 (102, N'KM5 - "Система горячего водоснабжения" (тупиковая схема, подающий трубопровод)', 3, 4, 9, 40, N'тупиковая схема, подающий трубопровод', N'sys', N'sys', '20160208', '20160208'),
		 (103, N'KM5 - "Система горячего водоснабжения" (тупиковая схема, обратный трубопровод)', 3, 4, 9, 41, N'тупиковая схема, обратный трубопровод', N'sys', N'sys', '20160208', '20160208'),
		 (104, N'VKT7 - "Система горячего водоснабжения" (с циркуляцией, ТВ1 тр1-тр2)', 3, 1, 1, 28, N'с циркуляцией, ТВ1 тр1-тр2', N'sys', N'sys', '20160208', '20160208'),
		 (105, N'VKT7 - "Система горячего водоснабжения" (с циркуляцией, ТВ2 тр1-тр2)', 3, 1, 1, 28, N'с циркуляцией, ТВ2 тр1-тр2', N'sys', N'sys', '20160209', '20160209'),
		 (106, N'VKT7 - "Система горячего водоснабжения" (ТВ1 тр1)', 3, 4, 1, 34, N'ТВ1 подающий тр1', N'sys', N'sys', '20160209', '20160209'),
		 (107, N'VKT7 - "Система горячего водоснабжения" (ТВ2 тр1)', 3, 4, 1, 34, N'ТВ2 подающий тр1', N'sys', N'sys', '20160209', '20160209'),
		 (108, N'TV7 - "Система горячего водоснабжения" (с циркуляцией, ТВ1 тр1-тр2)', 3, 1, 27, 28, N'с циркуляцией, ТВ1 тр1-тр2', N'sys', N'sys', '20160209', '20160209'),
		 (109, N'TV7 - "Система горячего водоснабжения" (с циркуляцией, ТВ2 тр1-тр2)', 3, 1, 27, 28, N'с циркуляцией, ТВ2 тр1-тр2', N'sys', N'sys', '20160209', '20160209'),
		 (110, N'TV7 - "Система горячего водоснабжения" (тупиковая схема, ТВ1 тр1)', 3, 4, 27, 34, N'тупиковая схема, ТВ1 тр1', N'sys', N'sys', '20160209', '20160209'),
		 (111, N'TV7 - "Система горячего водоснабжения" (тупиковая схема, ТВ1 тр2)', 3, 4, 27, 34, N'тупиковая схема, ТВ1 тр2', N'sys', N'sys', '20160209', '20160209'),
		 (112, N'TV7 - "Система горячего водоснабжения" (тупиковая схема, ТВ1 тр3)', 3, 4, 27, 34, N'тупиковая схема, ТВ1 тр3', N'sys', N'sys', '20160209', '20160209'),
		 (113, N'TV7 - "Система горячего водоснабжения" (тупиковая схема, ТВ2 тр1)', 3, 4, 27, 34, N'тупиковая схема, ТВ2 тр1', N'sys', N'sys', '20160209', '20160209'),
		 (114, N'TV7 - "Система горячего водоснабжения" (тупиковая схема, ТВ2 тр2)', 3, 4, 27, 34, N'тупиковая схема, ТВ2 тр2', N'sys', N'sys', '20160209', '20160209'),
		 (115, N'TV7 - "Система горячего водоснабжения" (тупиковая схема, ТВ2 тр3)', 3, 4, 27, 34, N'тупиковая схема, ТВ2 тр3', N'sys', N'sys', '20160209', '20160209'),
		 (116, N'VZLJOT_024 - "Система горячего водоснабжения" (с циркуляцией, ТС2 (тр1-тр2), тепло общее)', 3, 1, 12, 28, N'с циркуляцией, ТС2 (тр1-тр2), тепло общее', N'sys', N'sys', '20160209', '20171212'),
		 (117, N'VZLJOT_026M - "Система горячего водоснабжения" (с циркуляцией, тр1-тр2)', 3, 1, 21, 28, N'с циркуляцией, тр1-тр2', N'sys', N'sys', N'20160209', N'20160209'),
		 (118, N'VZLJOT_026M - "Система горячего водоснабжения" (с циркуляцией, тр3-тр4)', 3, 1, 21, 28, N'с циркуляцией, тр3-тр4', N'sys', N'sys', N'20160209', N'20160209'),
		 (119, N'VZLJOT_033-034 - "Система горячего водоснабжения" (с циркуляцией)', 3, 1, 10, 28, N'с циркуляцией', N'sys', N'sys', N'20160422', N'20160422'),
		 (120, N'VZLJOT_024M - "Система горячего водоснабжения" (с циркуляцией, ТС2 (тр1-тр2))', 3, 1, 22, 28, N'с циркуляцией, ТС2 (тр1-тр2)', N'sys', N'sys', N'20160425', N'20160425'),
		 (121, N'VZLJOT_024M - "Система горячего водоснабжения" (с циркуляцией, ТС1 (тр1-тр2))', 3, 1, 22, 28, N'с циркуляцией, ТС1 (тр1-тр2)', N'sys', N'sys', N'20160425', N'20160425'),
		 (123, N'VZLJOT_024M - "Система горячего водоснабжения" (с циркуляцией, ТС2 (тр1-тр2), потребитель 1)', 3, 1, 22, NULL, N'с циркуляцией, ТС2 (тр1-тр2), потребитель 1', N'sys', N'sys', N'20161025', N'20161025'),
		 (125, N'VZLJOT_024M - "Система горячего водоснабжения" (с циркуляцией, ТС2 (тр1-тр2), потребитель 2)', 3, 1, 22, NULL, N'с циркуляцией, ТС2 (тр1-тр2), потребитель 2', N'sys', N'sys', N'20161025', N'20161025'),
		 (126, N'VKT7 - "Система горячего водоснабжения" (ТВ1 тр3)', 3, 4, 1, 34, N'ТВ1 подающий тр3', N'sys', N'sys', '20161228', '20161228'),
		 (127, N'Spt943 - "Система горячего водоснабжения" (тупиковая схема, ТВ1 тр3, учет по Qг)', 3, 4, 38, 34, N'тупиковая схема, ТВ1 тр3, учет по Qг', N'sys', N'sys', '20170116', '20170116'),
		 (128, N'Spt941_10_11 - "Система горячего водоснабжения" (с циркуляцией, тр1-тр2, Гкал)', 3, 1, 37, 28, N'с циркуляцией, тр1-тр2, Гкал', N'sys', N'sys', '20170116', '20170116'),
		 (129, N'Spt943 - "Система горячего водоснабжения" (с циркуляцией, ТВ1 тр1-тр2, учет по Q)', 3, 1, 38, 28, N'с циркуляцией, ТВ1 тр1-тр2, учет по Q', N'sys', N'sys', '20170126', '20170126'),
		 (130, N'Spt943 - "Система горячего водоснабжения" (тупиковая схема, ТВ2 тр1, учет объема)', 3, 4, 38, 34, N'тупиковая схема, ТВ2 тр1, учет объема', N'sys', N'sys', '20170130', '20170130'),
		 (131, N'Spt941 - "Система горячего водоснабжения" (с циркуляцией, тр1-тр2)', 3, 1, 39, 28, N'с циркуляцией, тр1-тр2', N'sys', N'sys', '20170209', '20170209'),
		 (132, N'Spt943 - "Система горячего водоснабжения" (с циркуляцией, ТВ2 тр1-тр2, учет по Q)', 3, 1, 38, 28, N'с циркуляцией, ТВ2 тр1-тр2, учет по Q', N'sys', N'sys', '20170613', '20170613'),
		 (133, N'Spt943 - "Система горячего водоснабжения" (тупиковая схема, ТВ1 тр1, учет по Q)', 3, 4, 38, 34, N'тупиковая схема, ТВ1 тр1, учет по Q', N'sys', N'sys', '20170904', '20170904'),
		 (134, N'Spt943 - "Система горячего водоснабжения" (ТВ2 тр1-тр2, РК2, Альметьевск, обратка)', 3, 4, 38, 34, N'ТВ2 тр1-тр2, РК2, Альметьевск, обратка', N'sys', N'sys', '20170905', '20170905'),
		 (135, N'VKT9 - "Система горячего водоснабжения" (с циркуляцией, ТВ2 тр1-тр2)', 3, 1, 58, 28, N'с циркуляцией, ТВ2 тр1-тр2', N'sys', N'sys', '20180319', '20180319'),
		 (136, N'VKT9 - "Система горячего водоснабжения" (с циркуляцией, ТВ1 тр1-тр2)', 3, 1, 58, 28, N'с циркуляцией, ТВ1 тр1-тр2', N'sys', N'sys', '20180319', '20180319'),
         (147, N'Tem104 - "Система горячего водоснабжения" (с циркуляцией, система 2, тр1-тр2)', 3, 1, 54, 39, N'с циркуляцией, система 2, тр1-тр2', N'sys', N'sys', '20181004', '20181004'),
         (155, N'VZLJOT_024M - "Система горячего водоснабжения" (с циркуляцией, ТС3 (тр1-тр2))', 3, 1, 22, 28, N'с циркуляцией, ТС3 (тр1-тр2)', N'sys', N'sys', N'20180817', N'20180817'),
         (161, N'Tem104 - "Система горячего водоснабжения" (тупиковая схема, система 2, тр1)', 3, 4, 54, 34, N'тупиковая схема, система 2, тр1', N'sys', N'sys', '20180912', '20180912'),
         (173, N'Magika - "Система горячего водоснабжения" (с циркуляцией, система 1, тр1-тр2)', 3, 1, 40, 39, N'с циркуляцией, система 1, тр1-тр2', N'sys', N'sys', '20180926', '20180926'),
		 (175, N'Tem116 - "Система горячего водоснабжения" (с циркуляцией, система 1, тр1-тр2)', 3, 1, 71, 39, N'с циркуляцией, система 1, тр1-тр2', N'sys', N'sys', '20181102', '20181102'),
         (178, N'VZLJOT_024M - "Система горячего водоснабжения" (с циркуляцией, ТС3 (тр1-тр2), мгнов: тем-ра: 5-6, расход 7-8)', 3, 1, 22, 28, N'с циркуляцией, ТС3 (тр1-тр2), мгнов: тем-ра: 5-6, расход 7-8', N'sys', N'sys', N'20181109', N'20181109'),
		 (196, N'EskoTm3E - "Система горячего водоснабжения" (тупиковая схема, система 2, тр1)', 3, 4, 77, 39, N'тупиковая схема, система 2, тр1', N'sys', N'sys', N'20190115', N'20190115'),

		 (219, N'Tem106 - "Система горячего водоснабжения" (с циркуляцией, система 1, тр1-тр2)', 3, 1, 55, 28, N'с циркуляцией, система 1, тр1-тр2', N'sys', N'sys', N'20190603', N'20190603'),
		 
		 (233, N'VegaCI11 - "Система горячего водоснабжения" (вход 1)', 3, NULL, 81, 76, N'вход 1', N'sys', N'sys', N'20190613', N'20190613'),
		 (234, N'VegaCI11 - "Система горячего водоснабжения" (вход 2)', 3, NULL, 81, 76, N'вход 2', N'sys', N'sys', N'20190613', N'20190613'),

		 (701, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 1)', 3, NULL, 65, NULL, N'канал 1', N'sys', N'sys', '20180710', '20180710'),
		 (702, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 2)', 3, NULL, 65, NULL, N'канал 2', N'sys', N'sys', '20180710', '20180710'),
		 (703, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 3)', 3, NULL, 65, NULL, N'канал 3', N'sys', N'sys', '20180710', '20180710'),
		 (704, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 4)', 3, NULL, 65, NULL, N'канал 4', N'sys', N'sys', '20180710', '20180710'),
		 (705, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 5)', 3, NULL, 65, NULL, N'канал 5', N'sys', N'sys', '20180710', '20180710'),
		 (706, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 6)', 3, NULL, 65, NULL, N'канал 6', N'sys', N'sys', '20180710', '20180710'),
		 (707, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 7)', 3, NULL, 65, NULL, N'канал 7', N'sys', N'sys', '20180710', '20180710'),
		 (708, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 8)', 3, NULL, 65, NULL, N'канал 8', N'sys', N'sys', '20180710', '20180710'),
		 (709, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 9)', 3, NULL, 65, NULL, N'канал 9', N'sys', N'sys', '20180710', '20180710'),
		 (710, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 10)', 3, NULL, 65, NULL, N'канал 10', N'sys', N'sys', '20180710', '20180710'),
		 (711, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 11)', 3, NULL, 65, NULL, N'канал 11', N'sys', N'sys', '20180710', '20180710'),
		 (712, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 12)', 3, NULL, 65, NULL, N'канал 12', N'sys', N'sys', '20180710', '20180710'),
		 (713, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 13)', 3, NULL, 65, NULL, N'канал 13', N'sys', N'sys', '20180710', '20180710'),
		 (714, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 14)', 3, NULL, 65, NULL, N'канал 14', N'sys', N'sys', '20180710', '20180710'),
		 (715, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 15)', 3, NULL, 65, NULL, N'канал 15', N'sys', N'sys', '20180710', '20180710'),
		 (716, N'Pulsar16RMM - "Система горячего водоснабжения" (канал 16)', 3, NULL, 65, NULL, N'канал 16', N'sys', N'sys', '20180710', '20180710')
GO

SET IDENTITY_INSERT Business.ChannelTemplate OFF;
GO