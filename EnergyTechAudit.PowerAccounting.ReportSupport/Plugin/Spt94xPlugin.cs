using System;
using System.Linq;
using System.Collections.Generic;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using System.Data;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Spt94xPlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;
        private readonly DateTime _periodBegin;
        private readonly DateTime _periodEnd;
        private readonly bool _includePeriodEnd;

        public Spt94xPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var periodBeginParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodBeginColumn));
            if (periodBeginParam != null)
            {
                _periodBegin = Convert.ToDateTime(periodBeginParam.Value).Date;
            }

            var periodEndParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodEndColumn));
            if (periodEndParam != null)
            {
                _periodEnd = Convert.ToDateTime(periodEndParam.Value).Date;
            }

            var includePeriodEndParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.IncludePeriodEndColumn));
            if (includePeriodEndParam != null)
            {
                _includePeriodEnd = Convert.ToBoolean(includePeriodEndParam.Value);
            }
        }


        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];
           
            if (mainDataTable.Rows.Count > 0)
            {
                // смещаем в основной таблице данных все даты на один период назад (час, сутки)
                foreach (DataRow row in mainDataTable.Rows)
                {
                    row[DbTablePermanentResources.TimeColumn] = _periodTypeId == 3 ?
                        Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]).AddDays(-1) :
                        Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]).AddHours(-1);
                }

                List<DateTime> rowsToDelete = new List<DateTime>();

                // находим даты, которые теперь не входят в выбранный диапазон дат
                foreach (DataRow row in mainDataTable.Rows)
                {
                    var currentRowTime = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);

                    if ((currentRowTime < _periodBegin) ||
                        (_includePeriodEnd && currentRowTime > _periodEnd) ||
                        (!_includePeriodEnd && currentRowTime >= _periodEnd))
                    {
                        rowsToDelete.Add(currentRowTime);
                    }
                }

                // удаляем все лишние строчки
                foreach (DateTime time in rowsToDelete)
                {
                    var currentRow = mainDataTable.Select(string.Format(mainDataTable.Locale, "{1} = '{0:o}'", time,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                    if (currentRow != null)
                    {
                        mainDataTable.Rows.Remove(currentRow);
                    }
                }

                // копируем интегрированные значения последней строчки основной таблицы
                // во вторую строчку таблицы "Показания счетчиков"
                if (summaryDataTable.Rows.Count == 2)
                {
                    var lastMainDataRow = mainDataTable.Rows[mainDataTable.Rows.Count - 1];
                    var lastSummaryDataRow = summaryDataTable.Rows[1];

                    var fieldsInfoTable = DataSource.Tables[DbTablePermanentResources.DefaultReportFieldInfoTableName];

                    var integrableFieldsRows = fieldsInfoTable.Select(string.Format(fieldsInfoTable.Locale, "IntegrableValue = true"))
                                                    .Select(fieldsRow => Convert.ToString(fieldsRow[DbTablePermanentResources.NameColumn])).ToList();

                    foreach (var integrableFieldName in integrableFieldsRows)
                    {
                        lastSummaryDataRow[integrableFieldName] = lastMainDataRow[integrableFieldName];
                    }

                    var lastMainDataRowTime = Convert.ToDateTime(lastMainDataRow[DbTablePermanentResources.TimeColumn]);

                    lastSummaryDataRow[DbTablePermanentResources.TimeColumn] = _periodTypeId == 3 ? lastMainDataRowTime.AddDays(1) : lastMainDataRowTime.AddHours(1);
                }
            }
        }
    }
}
