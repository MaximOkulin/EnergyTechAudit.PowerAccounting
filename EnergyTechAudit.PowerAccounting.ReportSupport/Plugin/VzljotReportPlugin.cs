using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class VzljotReportPlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;
        public VzljotReportPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            if (_periodTypeId == 3)
            {
                if (mainDataTable.Rows.Count > 0)
                {
                    foreach (DataRow row in mainDataTable.Rows)
                    {
                        var time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                        if (time.Hour == 23 && time.Minute == 59 && time.Second == 59)
                        {
                            row[DbTablePermanentResources.TimeColumn] = time.AddSeconds(1);
                        }
                    }
                }
            }
            else if (_periodTypeId == 2)
            {
                if (mainDataTable.Rows.Count > 0)
                {
                    foreach (DataRow row in mainDataTable.Rows)
                    {
                        var time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                        if (time.Minute == 59 && time.Second == 59)
                        {
                            row[DbTablePermanentResources.TimeColumn] = time.AddSeconds(1);
                        }
                    }
                }
            }
        }
    }
}
