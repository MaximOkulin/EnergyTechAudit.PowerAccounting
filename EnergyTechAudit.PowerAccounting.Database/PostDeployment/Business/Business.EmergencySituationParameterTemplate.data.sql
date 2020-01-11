SET IDENTITY_INSERT [Business].[EmergencySituationParameterTemplate] ON;

:setvar xmlQuote "'"

DECLARE @massControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\MassControl.json
$(xmlQuote)

DECLARE @timeNormalControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TimeNormalControl.json
$(xmlQuote)

DECLARE @successConnectionTimeControl NVARCHAR(MAX) = 
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\SuccessConnectionTimeControl.json
$(xmlQuote)

DECLARE @massFlowSupplyPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\MassFlowSupplyPipeControl.json
$(xmlQuote)

DECLARE @massFlowReturnPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\MassFlowReturnPipeControl.json
$(xmlQuote)

DECLARE @massFlowSupplyReturnPipesControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\MassFlowSupplyReturnPipesControl.json
$(xmlQuote)

DECLARE @volumeFlowSupplyPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\volumeFlowSupplyPipeControl.json
$(xmlQuote)

DECLARE @volumeFlowReturnPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\volumeFlowReturnPipeControl.json
$(xmlQuote)

DECLARE @volumeFlowSupplyReturnPipesControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\VolumeFlowSupplyReturnPipesControl.json
$(xmlQuote)

DECLARE @pressureSupplyPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\PressureSupplyPipeControl.json
$(xmlQuote)

DECLARE @pressureReturnPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\PressureReturnPipeControl.json
$(xmlQuote)

DECLARE @pressureSupplyReturnPipesControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\PressureSupplyReturnPipesControl.json
$(xmlQuote)

DECLARE @temperSupplyPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperSupplyPipeControl.json
$(xmlQuote)

DECLARE @temperReturnPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperReturnPipeControl.json
$(xmlQuote)

DECLARE @temperSupplyReturnPipesControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperSupplyReturnPipesControl.json
$(xmlQuote)

DECLARE @deviceTimeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\DeviceTimeControl.json
$(xmlQuote)

DECLARE @barsConnectionControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BarsConnectionControl.json
$(xmlQuote)

DECLARE @heatCurveSupplyPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\HeatCurveSupplyPipeControl.json
$(xmlQuote)

DECLARE @heatCurveReturnPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\HeatCurveReturnPipeControl.json
$(xmlQuote)

DECLARE @heatCurveSupplyReturnPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\HeatCurveSupplyReturnPipeControl.json
$(xmlQuote)

DECLARE @heatCurveReturnPipeMeltDownControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\HeatCurveReturnPipeMeltDownControl.json
$(xmlQuote)

DECLARE @heatCurveReturnPipeCoolDownControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\HeatCurveReturnPipeCoolDownControl.json
$(xmlQuote)

DECLARE @coldWaterConsumptionByLastHour NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\ColdWaterConsumptionByLastHour.json
$(xmlQuote)

DECLARE @boilerStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\BoilerStateControl.json
$(xmlQuote)

DECLARE @boilerEmergencyStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\BoilerEmergencyStateControl.json
$(xmlQuote)

DECLARE @systemPumpStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SystemPumpStateControl.json
$(xmlQuote)

DECLARE @hwsPumpStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\HwsPumpStateControl.json
$(xmlQuote)

DECLARE @makeupPumpStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\MakeupPumpStateControl.json
$(xmlQuote)

DECLARE @recirculatingPumpStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\RecirculatingPumpStateControl.json
$(xmlQuote)

DECLARE @powerStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\PowerStateControl.json
$(xmlQuote)

DECLARE @gasLeaksStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\GasLeaksStateControl.json
$(xmlQuote)

DECLARE @tankLevelStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\TankLevelStateControl.json
$(xmlQuote)

DECLARE @granitGuardStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\GranitGuardStateControl.json
$(xmlQuote)

DECLARE @test NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\Test.json
$(xmlQuote)

DECLARE @entranceDoorStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\EntranceDoorStateControl.json
$(xmlQuote)

DECLARE @accessButtonStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\AccessButtonStateControl.json
$(xmlQuote)

DECLARE @floodingStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\FloodingStateControl.json
$(xmlQuote)

DECLARE @pumpHeatSys1StateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\PumpHeatSys1StateControl.json
$(xmlQuote)

DECLARE @pumpHeatSys2StateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\PumpHeatSys2StateControl.json
$(xmlQuote)

DECLARE @pumpHwsStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\PumpHwsStateControl.json
$(xmlQuote)

DECLARE @astraStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\AstraStateControl.json
$(xmlQuote)

DECLARE @coldWaterVolumeAccumulationControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\ColdWaterVolumeAccumulationControl.json
$(xmlQuote)

DECLARE @accidentBoilerBurnerControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentBoilerBurnerControl.json
$(xmlQuote)

DECLARE @accidentMakeupPumpControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentMakeupPumpControl.json
$(xmlQuote)

DECLARE @carbonMonoxideControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\CarbonMonoxideControl.json
$(xmlQuote)

DECLARE @methaneControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\MethaneControl.json
$(xmlQuote)

DECLARE @securityAlarmControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SecurityAlarmControl.json
$(xmlQuote)

DECLARE @fireControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\FireControl.json
$(xmlQuote)

DECLARE @accidentThreeWayValveControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentThreeWayValveControl.json
$(xmlQuote)

DECLARE @supplyTemperatureSensorControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyTemperatureSensorControl.json
$(xmlQuote)

DECLARE @returnTemperatureSensorControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnTemperatureSensorControl.json
$(xmlQuote)

DECLARE @supplyTemperatureCrashUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyTemperatureCrashUpperLimitControl.json
$(xmlQuote)

DECLARE @supplyTemperatureWarningUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyTemperatureWarningUpperLimitControl.json
$(xmlQuote)

DECLARE @supplyTemperatureWarningLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyTemperatureWarningLowerLimitControl.json
$(xmlQuote)

DECLARE @supplyTemperatureCrashLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyTemperatureCrashLowerLimitControl.json
$(xmlQuote)

DECLARE @returnTemperatureCrashUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnTemperatureCrashUpperLimitControl.json
$(xmlQuote)

DECLARE @returnTemperatureWarningUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnTemperatureWarningUpperLimitControl.json
$(xmlQuote)

DECLARE @returnTemperatureWarningLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnTemperatureWarningLowerLimitControl.json
$(xmlQuote)

DECLARE @returnTemperatureCrashLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnTemperatureCrashLowerLimitControl.json
$(xmlQuote)

DECLARE @outdoorAirSensorControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\OutdoorAirSensorControl.json
$(xmlQuote)

DECLARE @accidentSystemPumpControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentSystemPumpControl.json
$(xmlQuote)

DECLARE @dryRunningNetworkPumpControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\DryRunningNetworkPumpControl.json
$(xmlQuote)

DECLARE @emergencyStopNetworkPumpsAPCSControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\EmergencyStopNetworkPumpsAPCSControl.json
$(xmlQuote)

DECLARE @emergencyNetworkPumpsAPCSControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\EmergencyNetworkPumpsAPCSControl.json
$(xmlQuote)

DECLARE @supplyPressureSensorControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyPressureSensorControl.json
$(xmlQuote)

DECLARE @returnPressureSensorControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnPressureSensorControl.json
$(xmlQuote)

---
DECLARE @supplyPressureCrashUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyPressureCrashUpperLimitControl.json
$(xmlQuote)

DECLARE @supplyPressureWarningUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyPressureWarningUpperLimitControl.json
$(xmlQuote)

DECLARE @supplyPressureWarningLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyPressureWarningLowerLimitControl.json
$(xmlQuote)

DECLARE @supplyPressureCrashLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SupplyPressureCrashLowerLimitControl.json
$(xmlQuote)

DECLARE @returnPressureCrashUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnPressureCrashUpperLimitControl.json
$(xmlQuote)

DECLARE @returnPressureWarningUpperLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnPressureWarningUpperLimitControl.json
$(xmlQuote)

DECLARE @returnPressureWarningLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnPressureWarningLowerLimitControl.json
$(xmlQuote)

DECLARE @returnPressureCrashLowerLimitControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\ReturnPressureCrashLowerLimitControl.json
$(xmlQuote)

DECLARE @accidentRecirculatingPumpControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentRecirculatingPumpControl.json
$(xmlQuote)

DECLARE @accidentReturnValveControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentReturnValveControl.json
$(xmlQuote)

DECLARE @systemPumpsPressureControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\SystemPumpsPressureControl.json
$(xmlQuote)


DECLARE @makeupPumpsPressureControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\MakeupPumpsPressureControl.json
$(xmlQuote)


DECLARE @accidentDeflatingDieselFuelPumpControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentDeflatingDieselFuelPumpControl.json
$(xmlQuote)

DECLARE @accidentDieselFuelPumpControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentDieselFuelPumpControl.json
$(xmlQuote)

DECLARE @accidentDieselFuelConcentrationControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\AccidentDieselFuelConcentrationControl.json
$(xmlQuote)

DECLARE @carbonMonoxideLevel2Control NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\CarbonMonoxideLevel2Control.json
$(xmlQuote)

DECLARE @gasValveStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\GasValveStateControl.json
$(xmlQuote)

DECLARE @dieselFuelValveStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BoilerRoom\DieselFuelValveStateControl.json
$(xmlQuote)

DECLARE @electricityVoltagePhasesControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\ElectricityVoltagePhasesControl.json
$(xmlQuote)

DECLARE @batteryVoltageControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BatteryVoltageControl.json
$(xmlQuote)

DECLARE @temperSupplyPipeHwsRegulatorMonitoringControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperSupplyPipeHwsRegulatorMonitoringControl.json
$(xmlQuote)


DECLARE @temperReturnPipeHwsRegulatorMonitoringControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperReturnPipeHwsRegulatorMonitoringControl.json
$(xmlQuote)

DECLARE @temperSupplyPipeHeatSysRegulatorMonitoringControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperSupplyPipeHeatSysRegulatorMonitoringControl.json
$(xmlQuote)

DECLARE @temperReturnPipeHeatSysRegulatorMonitoringControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\TemperReturnPipeHeatSysRegulatorMonitoringControl.json
$(xmlQuote)

DECLARE @volumeFlowMakeupPipeControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\volumeFlowMakeupPipeControl.json
$(xmlQuote)

DECLARE @entranceDoorSensorStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\EntranceDoorSensorStateControl.json
$(xmlQuote)

DECLARE @floodingSensorStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\FloodingSensorStateControl.json
$(xmlQuote)

DECLARE @batteryChargeEntranceDoorsControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BatteryChargeEntranceDoorsControl.json
$(xmlQuote)

DECLARE @basementAndAtticDoorsEtaDiscreteInputControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\BasementAndAtticDoorsEtaDiscreteInputControl.json
$(xmlQuote)

DECLARE @floodingWellSensorStateControl NVARCHAR(MAX) =
$(xmlQuote)
:r ..\_Json\EmergencySituationParameterTemplate\FloodingWellSensorStateControl.json
$(xmlQuote)



INSERT INTO [Business].[EmergencySituationParameterTemplate] ([Id],[Description],[EntityTypeName],[PredicateExpression])
VALUES
	-- (2, 'Контроль времени наработки за последние сутки', @timeNormalControl)
	(1, 'Контроль качества связи с прибором', 'MeasurementDevice', @successConnectionTimeControl),
	(2, 'Контроль массового расхода в подаче', 'Channel', @massFlowSupplyPipeControl),
	(3, 'Контроль массового расхода в обратке', 'Channel', @massFlowReturnPipeControl),
	(4, 'Контроль массового расхода в подаче и обратке', 'Channel', @massFlowSupplyReturnPipesControl),
	(5, 'Контроль объемного расхода в подаче', 'Channel', @volumeFlowSupplyPipeControl),
	(6, 'Контроль объемного расхода в обратке', 'Channel', @volumeFlowReturnPipeControl),
	(7, 'Контроль объемного расхода в подаче и обратке', 'Channel', @volumeFlowSupplyReturnPipesControl),
	(8, 'Контроль давления в подаче', 'Channel', @pressureSupplyPipeControl),
	(9, 'Контроль давления в обратке', 'Channel', @pressureReturnPipeControl),
	(10, 'Контроль давления в подаче и обратке', 'Channel', @pressureSupplyReturnPipesControl),
	(11, 'Контроль температуры в подаче', 'Channel', @temperSupplyPipeControl),
	(12, 'Контроль температуры в обратке', 'Channel', @temperReturnPipeControl),
	(13, 'Контроль температуры в подаче и обратке', 'Channel', @temperSupplyReturnPipesControl),
	(14, 'Контроль отклонения приборного времени от серверного', 'MeasurementDevice', @deviceTimeControl),
	(15, 'Контроль подключений модема Барс-02', 'AccessPoint', @barsConnectionControl),
	(16, 'Контроль потери массы в системе ЦО за последние сутки', 'Channel', @massControl),
	(17, 'Соблюдение температурного графика в системе ЦО (подающий трубопровод) (ПУ)', 'Channel', @heatCurveSupplyPipeControl),
	(18, 'Соблюдение температурного графика в системе ЦО (обратный трубопровод) (ПУ)', 'Channel', @heatCurveReturnPipeControl),
	(19, 'Соблюдение температурного графика в система ЦО (ПУ)', 'Channel', @heatCurveSupplyReturnPipeControl),
	(20, 'Контроль расхода холодной воды за последний час', 'Channel', @coldWaterConsumptionByLastHour),
	(21, 'Контроль состояния котла', 'Channel', @boilerStateControl),
	(22, 'Контроль аварийности котла', 'Channel', @boilerEmergencyStateControl),
	(23, 'Контроль состояния сетевого насоса', 'Channel', @systemPumpStateControl),
	(24, 'Контроль состояния насоса ГВС', 'Channel', @hwsPumpStateControl),
	(25, 'Контроль состояния насоса подпитки', 'Channel', @makeupPumpStateControl),
	(26, 'Контроль состояния рециркуляционного насоса', 'Channel', @recirculatingPumpStateControl),
	(27, 'Контроль питания', 'Channel', @powerStateControl),
	(28, 'Контроль утечки газа', 'Channel', @gasLeaksStateControl),
	(29, 'Контроль уровня бака', 'Channel', @tankLevelStateControl),
	(30, 'Контроль охраны Гранит', 'Channel', @granitGuardStateControl),
	(31, 'Тестовая нештатная ситуация', 'Channel', @test),
	(32, 'Отслеживание возникновения ПЕРЕТОПОВ в обратном трубопроводе', 'Channel', @heatCurveReturnPipeMeltDownControl),
	(33, 'Отслеживание возникновения НЕДОТОПОВ в обратном трубопроводе', 'Channel', @heatCurveReturnPipeCoolDownControl),
	(34, 'Контроль входной двери', 'Channel', @entranceDoorStateControl),
	(35, 'Контроль нажатия кнопки "Свой/Чужой"', 'Channel', @accessButtonStateControl),
	(36, 'Контроль затопления помещения', 'Channel', @floodingStateControl),
	(37, 'Контроль работы насоса №1 (ЦО)', 'Channel', @pumpHeatSys1StateControl),
	(38, 'Контроль работы насоса №2 (ЦО)', 'Channel', @pumpHeatSys2StateControl),
	(39, 'Контроль работы насоса ГВС', 'Channel', @pumpHwsStateControl),
	(40, 'Контроль состояния пожарного датчика "Астра"', 'Channel', @astraStateControl),
	(41, 'Контроль накопления объема потребленной холодной воды', 'Channel', @coldWaterVolumeAccumulationControl),
    (42, 'Контроль аварийности горелки котла', 'Channel', @accidentBoilerBurnerControl),
    (43, 'Контроль аварийности насоса подпитки', 'Channel', @accidentMakeupPumpControl),
    (44, 'Контроль утечки угарного газа', 'Channel', @carbonMonoxideControl),
    (45, 'Контроль утечки метана', 'Channel', @methaneControl),
    (46, 'Охранная сигнализация', 'Channel', @securityAlarmControl),
	(47, 'Пожарная сигнализация', 'Channel', @fireControl),
	(48, 'Контроль аварии трехходового клапана', 'Channel', @accidentThreeWayValveControl),
    (49, 'Контроль датчика температуры подачи', 'Channel', @supplyTemperatureSensorControl),
	(50, 'Контроль датчика температуры обратки', 'Channel', @returnTemperatureSensorControl),
    (51, 'Температура подачи. Аварийный верхний предел', 'Channel', @supplyTemperatureCrashUpperLimitControl),
	(52, 'Температура подачи. Предупредительный верхний предел', 'Channel', @supplyTemperatureWarningUpperLimitControl),
	(53, 'Температура подачи. Предупредительный нижний предел', 'Channel', @supplyTemperatureWarningLowerLimitControl),
	(54, 'Температура подачи. Аварийный нижний предел', 'Channel', @supplyTemperatureCrashLowerLimitControl),
	(55, 'Температура обратки. Аварийный верхний предел', 'Channel', @returnTemperatureCrashUpperLimitControl),
	(56, 'Температура обратки. Предупредительный верхний предел', 'Channel', @returnTemperatureWarningUpperLimitControl),
	(57, 'Температура обратки. Предупредительный нижний предел', 'Channel', @returnTemperatureWarningLowerLimitControl),
	(58, 'Температура обратки. Аварийный нижний предел', 'Channel', @returnTemperatureCrashLowerLimitControl),	
    (59, 'Контроль датчика температуры наружного воздуха', 'Channel', @outdoorAirSensorControl),
    (60, 'Контроль аварийности сетевого насоса', 'Channel', @accidentSystemPumpControl),
	(61, 'Контроль сухого хода сетевого насоса', 'Channel', @dryRunningNetworkPumpControl),
    (62, 'Контроль аварийного стопа АСУ сетевых насосов', 'Channel', @emergencyStopNetworkPumpsAPCSControl),
    (63, 'Контроль аварийности АСУ сетевых насосов', 'Channel', @emergencyNetworkPumpsAPCSControl),
	(64, 'Контроль датчика давления подачи', 'Channel', @supplyPressureSensorControl),
	(65, 'Контроль датчика давления обратки', 'Channel', @returnPressureSensorControl),
	(66, 'Давление подачи. Аварийный верхний предел', 'Channel', @supplyPressureCrashUpperLimitControl),
	(67, 'Давление подачи. Предупредительный верхний предел', 'Channel', @supplyPressureWarningUpperLimitControl),
	(68, 'Давление подачи. Предупредительный нижний предел', 'Channel', @supplyPressureWarningLowerLimitControl),
	(69, 'Давление подачи. Аварийный нижний предел', 'Channel', @supplyPressureCrashLowerLimitControl),
	(70, 'Давление обратки. Аварийный верхний предел', 'Channel', @returnPressureCrashUpperLimitControl),
	(71, 'Давление обратки. Предупредительный верхний предел', 'Channel', @returnPressureWarningUpperLimitControl),
	(72, 'Давление обратки. Предупредительный нижний предел', 'Channel', @returnPressureWarningLowerLimitControl),
	(73, 'Давление обратки. Аварийный нижний предел', 'Channel', @returnPressureCrashLowerLimitControl),
	(74, 'Контроль аварийности рециркуляционного насоса', 'Channel', @accidentRecirculatingPumpControl),
	(75, 'Контроль аварийности клапана обратки котла', 'Channel', @accidentReturnValveControl),
    (76, 'Контроль давления сетевых насосов', 'Channel', @systemPumpsPressureControl),
	(77, 'Контроль давления подпиточных насосов', 'Channel', @makeupPumpsPressureControl),
    (78, 'Контроль аварийности выкачивающего насоса дизтоплива', 'Channel', @accidentDeflatingDieselFuelPumpControl),
	(79, 'Контроль аварийности перекачивающего насоса дизтоплива', 'Channel', @accidentDieselFuelPumpControl),
	(80, 'Контроль концентрации дизтоплива в хранилище', 'Channel', @accidentDieselFuelConcentrationControl),
	(81, 'Контроль утечки угарного газа (порог 2)', 'Channel', @carbonMonoxideLevel2Control),
	(82, 'Контроль клапана газа', 'Channel', @gasValveStateControl),
	(83, 'Контроль клапана дизтоплива', 'Channel', @dieselFuelValveStateControl),
	(84, 'Контроль напряжения по трем фазам', 'Channel', @electricityVoltagePhasesControl),
	(85, 'Контроль заряда литиевой батареи', 'Channel', @batteryVoltageControl),
	(86, 'Контроль температуры в подаче ГВС (регулятор, мониторинг)', 'Channel', @temperSupplyPipeHwsRegulatorMonitoringControl),
	(87, 'Контроль температуры в обратке ГВС (регулятор, мониторинг)', 'Channel', @temperReturnPipeHwsRegulatorMonitoringControl),
	(88, 'Контроль температуры в подаче ЦО (регулятор, мониторинг)', 'Channel', @temperSupplyPipeHeatSysRegulatorMonitoringControl),
	(89, 'Контроль температуры в обратке ЦО (регулятор, мониторинг)', 'Channel', @temperReturnPipeHeatSysRegulatorMonitoringControl),
    (90, 'Контроль объемного расхода в трубопроводе подпитки', 'Channel', @volumeFlowMakeupPipeControl),
	(91, 'Контроль входной двери (по номеру датчика)', 'Channel', @entranceDoorSensorStateControl),
	(92, 'Контроль затопления (по номеру датчика)', 'Channel', @floodingSensorStateControl),
	(93, 'Контроль заряда батареи на датчиках LoraWan', 'Channel', @batteryChargeEntranceDoorsControl),
	(94, 'Контроль дверей подвала и чердака через модем ЭТА', 'Channel', @basementAndAtticDoorsEtaDiscreteInputControl),
	(96, 'Контроль затопления колодца (по номеру датчика)', 'Channel', @floodingWellSensorStateControl)
GO

SET IDENTITY_INSERT [Business].[EmergencySituationParameterTemplate] OFF;