using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;


namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class UniversalDeviceSettingsPlugin : ReportPluginBase
    {
        private readonly string _deviceCode;
        public UniversalDeviceSettingsPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
            var deviceCodeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.DeviceCodeColumn));

            if (deviceCodeParam != null)
            {
                _deviceCode = Convert.ToString(deviceCodeParam.Value);
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            if (mainDataTable != null && mainDataTable.Rows.Count > 0)
            {
                foreach (DataRow row in mainDataTable.Rows)
                {
                    AddParameter<string>(Convert.ToString(row[ReportPluginResources.Code]), Convert.ToString(row[ReportPluginResources.StringValue]));
                }
            }

            var parametersNames = GetParametersNames(_deviceCode);
            UpdateParameters();

            foreach(var paramName in parametersNames)
            {
                var param = Parameters.FirstOrDefault(p => p.FullName.Equals(paramName));
                if (param == null)
                {
                    AddParameter<string>(paramName, ReportPluginResources.TripleHyphen);
                }
            }
        }

        private static List<string> SettingsNames = new List<string>
        {
            SettingsResources.WaterCounterType, SettingsResources.ControlV, SettingsResources.ControlWC, SettingsResources.PressureSensor, SettingsResources.ContractTemp, SettingsResources.ContractPressure, SettingsResources.HeightAdjustment,
            SettingsResources.HighLimitSensor, SettingsResources.ImpulseWeight, SettingsResources.VolumeMin, SettingsResources.VolumeMax, SettingsResources.ContractVolume,
            SettingsResources.EmptyPipeAccounting, SettingsResources.EmptyPipeInput, SettingsResources.ReverseInput, SettingsResources.FlowDirection
        };

        private static List<string> TvSettingsNames = new List<string>
        {
            SettingsResources.MeasurementScheme, SettingsResources.UseQtv, SettingsResources.dMmax, SettingsResources.txContract, SettingsResources.PxContract, SettingsResources.Pipe3Config, SettingsResources.FRT, SettingsResources.tControl,
            SettingsResources.dMControl, SettingsResources.QControl, SettingsResources.dtControl, SettingsResources.dtmin, SettingsResources.Usetx, SettingsResources.Usetnv
        };
        

        private static List<string> GetParametersNames(string deviceCode)
        {
            var result = new List<string>();

            // ТВ7
            if (deviceCode.Equals(DictionariesValueResources.DeviceCodeTv7))
            {
                for(var dbNumber = 1; dbNumber <= 2; dbNumber++)
                {
                    for(var tvNumber = 1; tvNumber <= 3; tvNumber++)
                    {
                        for(var pipeNumber = 1; pipeNumber <=3; pipeNumber++)
                        {
                            if (tvNumber == 3 && pipeNumber == 3) continue;
                            foreach(var settingName in SettingsNames)
                            {
                                result.Add(Convert.ToString(typeof(SettingsResources).GetProperty(string.Format(SettingsResources.PipeParameterStringFormat, tvNumber, pipeNumber, settingName, dbNumber)).GetValue(null, null)));
                            }
                        }
                    }
                }

                for (var dbNumber = 1; dbNumber <=2; dbNumber++)
                {
                    for(var tvNumber = 1; tvNumber <= 3; tvNumber++)
                    {
                        foreach(var settingName in TvSettingsNames)
                        {
                            result.Add(Convert.ToString(typeof(SettingsResources).GetProperty(string.Format(SettingsResources.TvParameterStringFormat, tvNumber, settingName, dbNumber)).GetValue(null, null)));
                        }
                    }
                }

                result.AddRange(new string[] { SettingsResources.ReportHour, SettingsResources.ReportDay, SettingsResources.Database2IsUse, SettingsResources.DatabaseSwitchType, SettingsResources.DatabaseSwitchAccess,
                SettingsResources.DatabaseSwitchNetworkAccess, SettingsResources.ThermoSensorType, SettingsResources.MeasurementUnit, SettingsResources.ClockChange, SettingsResources.DisplayInversion, SettingsResources.Database1DayFrom,
                SettingsResources.Database1MonthFrom, SettingsResources.Database1HourFrom, SettingsResources.Database2DayFrom, SettingsResources.Database2MonthFrom, SettingsResources.Database2HourFrom,
                SettingsResources.Firmware, SettingsResources.IsNewFirmware2_20, SettingsResources.ImpulseInputTarget, SettingsResources.ImpulseInputSignalLevel, SettingsResources.ImpulseInputMeasurementUnit,
                SettingsResources.ImpulseInputImpulseWeightOrConfirmTime, SettingsResources.ImpulseInputLow, SettingsResources.ImpulseInputHigh
                });
            }

            return result;
        }
    }

    
}
