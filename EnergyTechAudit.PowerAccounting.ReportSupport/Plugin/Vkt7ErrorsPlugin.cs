using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Vkt7ErrorsPlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;
        private readonly string _resourceSystemTypeCode;

        public Vkt7ErrorsPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var resourceSystemTypeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSystemTypeCodeColumn));
            if (resourceSystemTypeParam != null)
            {
                _resourceSystemTypeCode = Convert.ToString(resourceSystemTypeParam.Value);
            }
        }

        public override void Execute()
        {
            if (_periodTypeId == 2 || _periodTypeId == 3)
            {
                var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
                
                var errorInfoColumnName = string.Format(StringFormatResources.ErrorInfoColumn,
                    _resourceSystemTypeCode);

                var emergencyParameterColumnName = string.Format(StringFormatResources.EmergencyParameterColumn,
                    _resourceSystemTypeCode);

                if (mainDataTable.Rows.Count > 0)
                {
                    // если в главной таблице есть колонка HeatSys.EmergencyParameter (в зависимости от типа ресурсной системы)
                    // из вещественного преобразуем в байт и этот байт в ASCII-код
                    if (mainDataTable.Columns.Contains(emergencyParameterColumnName))
                    {
                        foreach (DataRow row in mainDataTable.Rows)
                        {
                            try
                            {
                                var emergencyByte = Convert.ToByte(row[emergencyParameterColumnName]);
                                if(emergencyByte != 0x20)
                                {
                                    emergencyByte = 0x2A; // *
                                }
                                row[errorInfoColumnName] = Encoding.ASCII.GetString(new[] { emergencyByte });
                            }
                            catch { }
                        }
                    }
                }
            }
        }
    }
}
