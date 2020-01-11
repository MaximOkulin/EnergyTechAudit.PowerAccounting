SET IDENTITY_INSERT [Core].[ReportSelector] ON;
GO

INSERT INTO [Core].[ReportSelector] ([SelectorReportId], [TargetReportId], [PredicateExpression])
VALUES
    -- ГВС
    (7, 105, '(DeviceCode in ["KM5","VKT7","TV7","VZLJOT_024","VZLJOT_026M","VZLJOT_033-034","VZLJOT_024M","Spt941_10_11","Spt943","Tem104","VKT9","Magika","Tem116","Tem106"]) and (ResourceSystemTypeCode in ["Hws"]) and (ResourceSubsystemTypeCode in ["Hwsc","HwscOpened","HwscClosed"]) and (ChannelTemplateId in ["66","101","104","105","108","109","116","117","118","119","120","121","123","125","128","129","132","135","136","147","155","173","175","178","219"]) and (WithVolume == True)'),
	(7, 106, '(DeviceCode in ["KM5","VKT7","TV7","VZLJOT_024","VZLJOT_026M","VZLJOT_033-034","VZLJOT_024M","Spt941_10_11","Spt943","Tem104","VKT9","Magika","Tem116","Tem106"]) and (ResourceSystemTypeCode in ["Hws"]) and (ResourceSubsystemTypeCode in ["Hwsc","HwscOpened","HwscClosed"]) and (ChannelTemplateId in ["66","101","104","105","108","109","116","117","118","119","120","121","123","125","128","129","132","135","136","147","155","173","175","178","219"]) and (WithVolume == False)'),
	(7, 103, '(DeviceCode in ["KM5","VKT7","TV7","Spt943","Tem104","EskoTm3E"]) and (ResourceSystemTypeCode in ["Hws"]) and (ResourceSubsystemTypeCode in ["HwsLockup"]) and (ChannelTemplateId in ["102","103","106","107","110","111","112","113","114","115","126","127","130","133","161","196"]) and (WithVolume == True)'),
	(7, 104, '(DeviceCode in ["KM5","VKT7","TV7","Spt943","Tem104","EskoTm3E"]) and (ResourceSystemTypeCode in ["Hws"]) and (ResourceSubsystemTypeCode in ["HwsLockup"]) and (ChannelTemplateId in ["102","103","106","107","110","111","112","113","114","115","126","127","130","133","161","196"]) and (WithVolume == False)'),

	--ЦО
	(7, 101, '(DeviceCode in ["KM5","VKT7","VKT9","TV7","VZLJOT_033-034","VZLJOT_024","VZLJOT_026M","VZLJOT_024M","VZLJOT_022-023","Spt943","Spt941","Spt941_10_11","Magika","Elf","Tesma106","Tem104","Tem106","Tem104_Tesmart","VZLJOT_043","VZLJOT_025","Tem116","EskoTm3E","VIST"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId  in ["1001","2","3","5","6","7","50","51","15","32","46","47","48","58","59","85","89","153","160","240","1002","122","124","150","137","177","190","195","220","242","252","505","1003","1005","1007","1009"]) and (WithVolume == True)'),
	(7, 102, '(DeviceCode in ["KM5","VKT7","VKT9","TV7","VZLJOT_033-034","VZLJOT_024","VZLJOT_026M","VZLJOT_024M","VZLJOT_022-023","Spt943","Spt941","Spt941_10_11","Magika","Elf","Tesma106","Tem104","Tem106","Tem104_Tesmart","VZLJOT_043","VZLJOT_025","Tem116","EskoTm3E","VIST"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId  in ["1001","2","3","5","6","7","50","51","15","32","46","47","48","58","59","85","89","153","160","240","1002","122","124","150","137","177","190","195","220","242","252","505","1003","1005","1007","1009"]) and (WithVolume == False)'),

	-- ЦО (только подача, обратки нет в отчете)
	(7, 115, '(DeviceCode in ["VKT7"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId  in ["254","255"]) and (WithVolume == False)'),
	(7, 123, '(DeviceCode in ["VKT7"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId  in ["254","255"]) and (WithVolume == True)'),

	-- ЦО (труба подачи - учет, труба обратки - подпитка)
	(7, 18, '(DeviceCode in ["KM5"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId  in ["44"])'),

	-- Подпитка ЦО
	(7, 109, '(DeviceCode in ["Spt941_10_11","Spt943","VKT7","TV7","Pulsar16M","VZLJOT_024M","VZLJOT_043","KM5","RM5","VZLJOT_026M","VZLJOT_033-034","Tem106","Tem104","Tesma106"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId in ["95","145","146","154","192","194","212","500","501","502","503","504","506","507","508","1004","151","152","172","243","248","249","1008"])'),
	(7, 121, '(DeviceCode in ["VKT9"]) and (ResourceSystemTypeCode in ["HeatSys"]) and (ChannelTemplateId in ["90"])'),

	--ХВС
	(7, 107, '(DeviceCode in ["VKT7","VKT9","KM5","RM5","VZLJOT_033-034","IVK102","VZLJOT_026M","VZLJOT_024","Spt941_10_11","Spt943","TV7","Pulsar2","Echo-R-02","Spt941_20","VZLJOT_024M","Pulsar16M","Pulsar2M","VZLJOT_022-023","Akron"]) and (ResourceSystemTypeCode in ["Cws"]) and ' + 
	          '(ChannelTemplateId  in ["9","91","94","2001","2002","2003","2004","2005","2006","12","13","14","17","23","25","33","34","37","45","86","87","97","98","99","100","215","241","253","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029"])'),
	
	--Смешанная (ЦО+ГВС)
	(7, 22, '(DeviceCode in ["TV7"]) and (ResourceSystemTypeCode in ["HeatSysMix"]) and (ChannelTemplateId in ["67"])'),

	-- Электричество (ведомость с 5 тарифами активной энергии)
	(7, 108, '(DeviceCode in ["CE301","CE303","Mercury230","Tse2726A"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["30","26","20","11"])'),

	-- Электричество (ведомость двухтарифного учета активной и реактивной энергии)
	(7, 110, '(DeviceCode in ["Mercury230"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["8"])'),
	-- Электричество (ведомость двухтарифного учета активной и реактивной энергии с учетом расчетного коэффициента)
	(7, 119, '(DeviceCode in ["Mercury230","Mercury234"]) and (PeriodTypeCode in ["Day"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["31","65"])'),
	-- Электричество (ведомость однотарифного учета активной и реактивной энергии с учетом расчетного коэффициента, прямая и обратная мощность)
	(7, 120, '(DeviceCode in ["CET_4TM_03M","PSCH_4TM_05MK"]) and (PeriodTypeCode in ["Day"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["10","193"])'),

	-- Электричество (ведомость часовых профилей мощности A+,A-,R+,R-)
	(7, 114, '(DeviceCode in ["CET_4TM_03M","Mercury230","Mercury234","PSCH_4TM_05MK"]) and (PeriodTypeCode in ["Hour"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["10","31","65","193"])'),

	-- Электричество (ведомость учета активной электроэнергии по часовым профилям, с итогами внизу)
	(7, 99, '(DeviceCode in ["CE301"]) and (PeriodTypeCode in ["Hour"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["88"])'),

	(7, 98, '(DeviceCode in ["CE301"]) and (PeriodTypeCode in ["Day"]) and (ResourceSystemTypeCode in ["ElectroSys"]) and (ChannelTemplateId in ["88"])'),


	-- ГАЗ
	(7, 111, '(DeviceCode in ["Irvis","EK270"]) and (ResourceSystemTypeCode in ["Gas"]) and (ChannelTemplateId in ["5000","5001"])'),

	-- ГАЗ (c промежуточными итогами)
	(7, 8, '(DeviceCode in ["EK270"]) and (ResourceSystemTypeCode in ["Gas"]) and (ChannelTemplateId in ["5003","5004","5005"])'),

	-- ГАЗ (с объемом, измеренный по импульсному выходу)
	(7, 100, '(DeviceCode in ["Pulsar16M","VKT7"]) and (ResourceSystemTypeCode in ["Gas"]) and (ChannelTemplateId in ["92","93","138","139","244","245","246","247"])'),

	-- ГАЗ (заводской отчет Ирвиса)
	(7, 10, '(DeviceCode in ["Irvis"]) and (ResourceSystemTypeCode in ["Gas"]) and (ChannelTemplateId in ["96"]) and (DeviceSubModel in ["RI5-464-03-1 ","RI5-468-03-1 ","RI5-470-03-1 ","RI5-471-03-1 "])'),
	-- ГАЗ (заводской отчет Ирвиса УЛЬТРА)
	(7, 11, '(DeviceCode in ["Irvis"]) and (ResourceSystemTypeCode in ["Gas"]) and (ChannelTemplateId in ["96"]) and (DeviceSubModel in ["RI5-962-03-1 "])'),

	-- ГВС Альметьевск РК2
	(7, 116, '(DeviceCode in ["Spt943"]) and (ResourceSystemTypeCode in ["Hws"]) and (ChannelTemplateId in ["134"]) and (WithVolume == True)'),
	(7, 117, '(DeviceCode in ["Spt943"]) and (ResourceSystemTypeCode in ["Hws"]) and (ChannelTemplateId in ["134"]) and (WithVolume == False)'),

	-- Удельные показатели котельной
	(7, 118, '(DeviceCode in ["CoalEquivalentVirtualDevice"]) and (ChannelTemplateId in ["1006"])'),

  -- Сводные отчеты по вводным приборам учета
  (24, 25, '(ResourceSystemTypeCode in ["HeatSys"])'),
  (24, 26, '(ResourceSystemTypeCode in ["Hws", "Hwsc", "Hwsco"])'),
  (24, 27, '(ResourceSystemTypeCode in ["Cws"])'),
  (24, 28, '(ResourceSystemTypeCode in ["ElectroSys"])'),
  
  -- Настройки ТВ7
  (39, 39, '(DeviceCode in ["TV7"]) and (SubModel not in ["05"])'),
  (39, 40, '(DeviceCode in ["TV7"]) and (SubModel in ["05","05M"])')




GO
SET IDENTITY_INSERT [Core].[ReportSelector] OFF;
GO