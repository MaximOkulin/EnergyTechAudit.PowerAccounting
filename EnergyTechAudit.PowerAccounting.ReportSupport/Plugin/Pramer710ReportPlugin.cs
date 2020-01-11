using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Pramer710ReportPlugin : ReportPluginBase
    {
        public Pramer710ReportPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
            
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            if (mainDataTable.Rows.Count > 0)
            {
                foreach (DataRow row in mainDataTable.Rows)
                {
                    var time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                    if (time.Minute == 59 && time.Second == 59)
                    {
                        row[DbTablePermanentResources.TimeColumn] = time.AddSeconds(-59).AddMinutes(-59);
                    }
                }
            }
        }
    }
}
