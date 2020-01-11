﻿SET IDENTITY_INSERT Business.ChannelTemplate ON;
GO

INSERT Business.ChannelTemplate(Id, Description, ResourceSystemTypeId, DeviceId, MnemoschemeId, Comment, CreatedBy, UpdatedBy, CreatedDate, UpdatedDate) 
  VALUES 
         (8, N'Mercury230 - "Система электроснабжения" (учет активной и реактивной энергии по 2 тарифам)', 5, 3, 53, N'учет активной и реактивной энергии по 2 тарифам', N'sys', N'sys', '20150507', '20150507'),
		 (10, N'CET_4TM_03M - "Система электроснабжения" (учет активной и реактивной энергии по 1 тарифу с расчетным коэффициентом)', 5, 47, 53, N'учет активной и реактивной энергии по 1 тарифу с расчетным коэффициентом', N'sys', N'sys', '20170718', '20170718'),
		 (11, N'Tse2726A - "Система электроснабжения" (учет по 2 тарифам)', 5, 36, NULL, N'учет по 2 тарифам', N'sys', N'sys', '20161122', '20161122'),
		 (20, N'Mercury230 - "Система электроснабжения" (учет активной энергии по 2 тарифам)', 5, 3, 53, N'учет активной энергии по 2 тарифам', N'sys', N'sys', '20150507', '20150507'),
		 (21, N'Mercury200 - "Система электроснабжения" (учет по 2 тарифам)', 5, 5, NULL, N'учет по 2 тарифам', N'sys', N'sys', '20150512', '20150512'),
		 (26, N'CE303 - "Система электроснабжения" (учет по всем тарифам)', 5, 16, NULL, N'учет по всем тарифам', N'sys', N'sys', '20150702', '20150702'),
		 (27, N'EltaRs485 - "Система электроснабжения" (учет по 2 тарифам)', 5, 17, NULL, N'учет по 2 тарифам', N'sys', N'sys', '20150706', '20150706'),
		 (28, N'Mercury206 - "Система электроснабжения" (учет по 2 тарифам)', 5, 19, NULL,  N'учет по 2 тарифам', N'sys', N'sys', '20150708', '20150708'),
		 (30, N'CE301 - "Система электроснабжения" (учет по всем тарифам)', 5, 29, NULL, N'учет по всем тарифам', N'sys', N'sys', '20160407', '20150407'),
		 (31, N'Mercury230 - "Система электроснабжения" (учет активной и реактивной энергии (прямой) по 2 тарифам с расчетным коэффициентом)', 5, 3, 53, N'учет активной и реактивной энергии (прямой) по 2 тарифам с расчетным коэффициентом', N'sys', N'sys', '20171016', '20171016'),
		 (38, N'Electro - "Система электроснабжения"', 5, 25, NULL, NULL, N'sys', N'sys', '20151002', '20151002'),
		 (65, N'Mercury234 - "Система электроснабжения" (учет активной и реактивной энергии (прямой) по 2 тарифам с расчетным коэффициентом)', 5, 56, 53, N'учет активной и реактивной энергии (прямой) по 2 тарифам с расчетным коэффициентом', N'sys', N'sys', '20171215', '20171215'),
		 (88, N'CE301 - "Система электроснабжения" (учет потребленной активной энергии по 2 тарифам с расчетным коэффициентом)', 5, 29, NULL, N'учет потребленной активной энергии по 2 тарифам с расчетным коэффициентом', N'sys', N'sys', '20180117', '20180117'),
		 (142, N'Mercury200 - "Система электроснабжения" (квартирный учет)', 5, 5, NULL, N'квартирный учет', N'sys', N'sys', '20180710', '20180710'),
         (158, N'Mercury206 - "Система электроснабжения" (квартирный учет, тариф 1)', 5, 19, NULL, N'квартирный учет, тариф 1', N'sys', N'sys', '20180907', '20180907'),
         (159, N'Mercury206 - "Система электроснабжения" (квартирный учет, тариф 2)', 5, 19, NULL, N'квартирный учет, тариф 2', N'sys', N'sys', '20180907', '20180907'),
		 (193, N'PSCH_4TM_05MK - "Система электроснабжения" (учет активной и реактивной энергии по 1 тарифу с расчетным коэффициентом)', 5, 76, 53, N'учет активной и реактивной энергии по 1 тарифу с расчетным коэффициентом', N'sys', N'sys', '20181219', '20181219'),
         (238, N'Mercury206 - "Система электроснабжения" (учет по 2 тарифам, LoraVega)', 5, 19, 53,  N'учет по 2 тарифам, LoraVega', N'sys', N'sys', '20150708', '20150708'),
		 (250, N'PR200 - "Система электроснабжения"', 5, 85, NULL, NULL, N'sys', N'sys', '20191008', '20191008')
GO

SET IDENTITY_INSERT Business.ChannelTemplate OFF;
GO