using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class RemoveHourInDayArchivePlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;

        public RemoveHourInDayArchivePlugin(object dataSource, IEnumerable<object> parameters):
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }
        }

        public override void Execute()
        {
            // удаляем часовую компоненту в датах основной таблицы для суточного архива
            if (_periodTypeId == 3)
            {
                var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

                if (mainDataTable.Rows.Count > 0)
                {
                    foreach (DataRow row in mainDataTable.Rows)
                    {
                        var time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                        var newTime = new DateTime(time.Year, time.Month, time.Day);
                        row[DbTablePermanentResources.TimeColumn] = newTime;
                    }
                }
            }
        }
    }
}
