using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.ReportSupport.Helpers;
using EnergyTechAudit.PowerAccounting.ReportSupport.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class ElfEmergencySituationsPlugin : ReportPluginBase
    {
        private readonly DateTime _periodBegin;
        private readonly DateTime _periodEnd;
        private readonly int _periodTypeId;

        public ElfEmergencySituationsPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];
            var periodBeginRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodBeginColumn);

            if (periodBeginRow != null)
            {
                _periodBegin = Convert.ToDateTime(periodBeginRow[DbTablePermanentResources.ValueColumn]);
                // обнуление часовой-минутной-секундой компонент
                _periodBegin = _periodBegin.Date;
            }

            var periodEndRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodEndColumn);

            if (periodEndRow != null)
            {
                _periodEnd = Convert.ToDateTime(periodEndRow[DbTablePermanentResources.ValueColumn]);
                // обнуление часовой-минутной-секундой компонент
                _periodEnd = _periodEnd.Date;

                var nowDate = DateTime.Now.Date;

                if (_periodEnd >= nowDate)
                {
                    _periodEnd = nowDate.AddDays(-1);
                }
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            mainDataTable.Columns.Add(new DataColumn(ReportPluginResources.Event, typeof(string)));

            int timeStepInHours = _periodTypeId == 2 ? 1 : 24;

            for(var dt = _periodBegin; dt < _periodEnd; dt = dt.AddHours(timeStepInHours))
            {
                var currentRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, dt,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                if (currentRow == null)
                {
                    var newRow = mainDataTable.NewRow();
                    newRow[DbTablePermanentResources.TimeColumn] = dt;
                    newRow[DbTablePermanentResources.ValueColumn] = -1;
                    mainDataTable.Rows.Add(newRow);
                }
            }

            mainDataTable.DefaultView.Sort = string.Format(StringFormatResources.ASC, DbTablePermanentResources.TimeColumn);
            mainDataTable = mainDataTable.DefaultView.ToTable();
            DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
            DataSource.Tables.Add(mainDataTable);

            foreach(DataRow row in mainDataTable.Rows)
            {
                var emergencyList = new List<string>();
                if (row[DbTablePermanentResources.ValueColumn] != DBNull.Value)
                {
                    var value = Convert.ToInt32(row[DbTablePermanentResources.ValueColumn]);
                    if (value != -1)
                    {
                        if (value == 0)
                        {
                            emergencyList.Add(ReportPluginResources.DashSymbol);
                        }
                        else
                        {
                            var fcf = (ElfFailCauseFlags)value;

                            foreach (ElfFailCauseFlags flags in (ElfFailCauseFlags[])Enum.GetValues(typeof(ElfFailCauseFlags)))
                            {
                                if (fcf.HasFlag(flags))
                                {
                                    emergencyList.Add(BaseHelper.GetEnumDescription(flags));
                                }
                            }
                        }
                    }
                    else
                    {
                        emergencyList.Add("Отсутствует информация о наличии нештатной ситуации");
                    }
                }
                else
                {
                    emergencyList.Add("Отсутствует информация о наличии нештатной ситуации");
                }

                row[ReportPluginResources.Event] = string.Join(ReportPluginResources.CommaDelimiter, emergencyList);
            }
        }
    }
}
