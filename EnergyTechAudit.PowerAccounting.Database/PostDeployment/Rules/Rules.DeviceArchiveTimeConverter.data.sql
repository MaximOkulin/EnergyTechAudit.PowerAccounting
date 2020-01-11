﻿SET IDENTITY_INSERT [Rules].[DeviceArchiveTimeConverter] ON;
GO

INSERT INTO [Rules].[DeviceArchiveTimeConverter]
([Id], [DeviceId], [PeriodTypeId], [Expression], [Interval])
VALUES
    -- ВКТ-7
   (1, 1, 2, '@date', 0),
   (2, 1, 3, '@date', 0),
   -- КМ-5
   (4, 9, 2, '@date', 0),
   (5, 9, 3, '@date', 0),
   -- Взлет-33/34
   (7, 10, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (8, 10, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- Взлет-24
   (10, 12, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (11, 12, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- РМ-5
   (13, 13, 2, '@date', 0),
   (14, 13, 3, '@date', 0),
   -- Взлет-24М
   (16, 22, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (17, 22, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- Взлет-24М+
   (19, 23, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (20, 23, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- Взлет-26М
   (22, 21, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (23, 21, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- ТВ-7
   (25, 27, 2, '@date', 0),
   (26, 27, 3, 'DATEADD(HOUR, 23, @date)', -3600),
   -- CE-301
   (27, 29, 3, '@date', 0),
   (31, 29, 2, '@date', 0),
   -- CE-303
   (28, 16, 3, '@date', 0),
   (32, 16, 2, '@date', 0),
   -- Взлет-22_23
   (29, 11, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (30, 11, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- Меркурий-230
   (33, 3, 2, '@date', 0),
   (34, 3, 3, '@date', 0),
   -- ИВК-102
   (35, 30, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (36, 30, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- ЦЭ2726А
   (37, 36, 2, '@date', 0),
   (38, 36, 3, '@date', 0),
   -- СПТ943
   (39, 38, 2, '@date', 0),
   (40, 38, 3, '@date', 0),
   -- СПТ941.10(11)
   (41, 37, 2, '@date', 0),
   (42, 37, 3, '@date', 0),
   -- СПТ941
   (43, 39, 2, '@date', 0),
   (44, 39, 3, '@date', 0),
   -- Пульсар-16
   (45, 2, 2, '@date', 0),
   (46, 2, 3, '@date', 0),
   -- Пульсар-2
   (47, 14, 2, '@date', 0),
   (48, 14, 3, '@date', 0),
   -- Магика
   (49, 40, 2, '@date', 0),
   (50, 40, 3, '@date', 0),
   -- ИРВИС (счетчик газа)
   (51, 42, 2, '@date', 0),
   (52, 42, 3, '@date', 0),
   -- EK270
   (53, 35, 2, '@date', 0),
   (54, 35, 3, '@date', 0),
   -- ЭХО-Р-02
   (55, 44, 2, '@date', 0),
   (56, 44, 3, '@date', 0),
   -- СПТ941.20
   (57, 45, 2, '@date', 0),
   (58, 45, 3, '@date', 0),
   -- ЭЛЬФ
   (59, 46, 2, '@date', 0),
   (60, 46, 3, '@date', 0),
   -- СЭТ-4ТМ.03М
   (61, 47, 2, '@date', 0),
   (62, 47, 3, '@date', 0),
   -- ТЭСМА-106
   (63, 48, 2, '@date', 0),
   (64, 48, 3, '@date', 0),
   -- CoalEquivalentVirtualDevice
   (65, 49, 2, '@date', 0),
   (66, 49, 3, '@date', 0),
    -- ТЭМ-104
   (67, 54, 2, '@date', 0),
   (68, 54, 3, '@date', 0),
    -- ТЭМ-106
   (69, 55, 2, '@date', 0),
   (70, 55, 3, '@date', 0),
   -- Меркурий-234
   (71, 56, 2, '@date', 0),
   (72, 56, 3, '@date', 0),
   -- ТЭМ-104 (ТЭСМАРТ)
   (73, 57, 2, '@date', 0),
   (74, 57, 3, '@date', 0),
   -- ВКТ-9
   (75, 58, 2, '@date', 0),
   (76, 58, 3, '@date', 0),
   -- Пульсар-16М
   (77, 59, 2, '@date', 0),
   (78, 59, 3, '@date', 0),
   -- Пульсар-2М
   (79, 62, 2, '@date', 0),
   (80, 62, 3, '@date', 0),
   -- Взлет-43
   (81, 63, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (82, 63, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- Взлет-25
   (83, 64, 2, 'DATEADD(SECOND, -1, @date)', -1),
   (84, 64, 3, 'DATEADD(SECOND, -1, @date)', -1),
   -- ТЭМ-116
   (85, 71, 2, '@date', 0),
   (86, 71, 3, '@date', 0),
   -- ПСЧ-4ТМ.05МК
   (87, 76, 2, '@date', 0),
   (88, 76, 3, '@date', 0),
	-- ЭСКО ТМ-3Э
	(89, 77, 2, '@date', 0),
    (90, 77, 3, '@date', 0),
	-- ПРАМЕР-710
	(91, 79, 2, '@date', 0),
    (92, 79, 3, '@date', 0),
    -- ВИС.Т
	(93, 86, 2, '@date', 0),
	(94, 86, 3, '@date', 0),
	-- АКРОН
	(95, 87, 2, '@date', 0),
	(96, 87, 3, '@date', 0)

 --([Id], [DeviceId], [PeriodTypeId], [Expression], [Interval])
GO

SET IDENTITY_INSERT [Rules].[DeviceArchiveTimeConverter] OFF;
GO