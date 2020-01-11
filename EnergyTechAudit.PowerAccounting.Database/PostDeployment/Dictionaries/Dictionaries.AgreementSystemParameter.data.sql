SET IDENTITY_INSERT [Dictionaries].[AgreementSystemParameter] ON;
GO

INSERT INTO  [Dictionaries].[AgreementSystemParameter]
    ([Id],[Code],[Description],[ResourceSystemTypeId],[PhysicalParameterId])
VALUES
    (1,'ColdWaterVolumeFlow','Объемный расход холодной воды по договору', 2, 7),
	(2,'ColdWaterTemperature','Температура холодной воды по договору', 2, 2),
	(3,'HotWaterVolumeFlow','Объемный расход горячей воды по договору', 3, 7),
	(4,'HotWaterTemperatureIn','Температура горячей воды на входе', 3, 2),
	(5,'HotWaterTemperatureOut','Температура горячей воды на выходе', 3, 2),
	(6,'HeatEnergy','Объем поставки тепловой энергии по договору', 4, 3),
	(7,'CalcOpenAirTemperature','Рассчитанная температура на открытом воздухе', 4, 2),
	(8,'StartOpenAirTemperature','Начальная температура на открытом воздухе', 4, 2),
	(9,'MaxTemperatureIn','Максимальная температура на входе', 4, 2),
	(10,'MaxTemperatureOut','Максимальная температура на выходе', 4, 2),
	(11,'ElectricPower','Объем поставки электрической мощности по договору', 5, 4),
	(12,'VoltageTrans','Коэффициент трасформации напряжения', 5, 12),
	(13,'CurrentTrans','Коэффициент трасформации силы тока', 5, 12)
	
GO

SET IDENTITY_INSERT [Dictionaries].[AgreementSystemParameter] OFF;
GO