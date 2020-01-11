using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Vzljot26MReportPlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;
        private readonly string _resourceSystemTypeCode;
        private readonly DateTime _periodBegin;
        private readonly int _channelTemplateId;
        private readonly string _resourceSubsystemTypeCode;

        public Vzljot26MReportPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var channelTemplateParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ChannelTemplateIdColumn));
            if (channelTemplateParam != null)
            {
                _channelTemplateId = Convert.ToInt32(channelTemplateParam.Value);
            }

            var resourceSystemTypeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSystemTypeCodeColumn));

            if (resourceSystemTypeParam != null)
            {
                _resourceSystemTypeCode = Convert.ToString(resourceSystemTypeParam.Value);
            }

            // тип подсистемы
            var resourceSubsystemTypeCodeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSubsystemTypeCodeColumn));
            if (resourceSubsystemTypeCodeParam != null)
            {
                _resourceSubsystemTypeCode = Convert.ToString(resourceSubsystemTypeCodeParam.Value);
            }

            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];
            var periodBeginRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodBeginColumn);

            if (periodBeginRow != null)
            {
                _periodBegin = Convert.ToDateTime(periodBeginRow[DbTablePermanentResources.ValueColumn]);
                // обнуление часовой-минутной-секундой компонент
                _periodBegin = _periodBegin.Date;
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            if (_periodTypeId == 3)
            {
                if (mainDataTable.Rows.Count > 0)
                {
                    // коррекция времени
                    foreach (DataRow row in mainDataTable.Rows)
                    {
                        var time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                        if (time.Hour == 23 && time.Minute == 59 && time.Second == 59)
                        {
                            row[DbTablePermanentResources.TimeColumn] = time.AddSeconds(-59).AddMinutes(-59).AddHours(-23);
                        }
                    }

                    // пропускаем Теплоту для отчетов "Подпитка ЦО", в котором нет тепла
                    if (_resourceSubsystemTypeCode == null || 
                        (_resourceSubsystemTypeCode != null && !_resourceSubsystemTypeCode.Equals(ReportPluginResources.HeatSysMakeupResourceSubsystemTypeCode, StringComparison.Ordinal)))
                    {
                        // Для ЦО и ГВС нужно рассчитать дифференс полной теплоты, т.к. она идет у них интегратором
                        if (!_resourceSystemTypeCode.Equals(ReportPluginResources.CwsResourceSystemTypeCode))
                        {
                            int rowNumber = 0;
                            decimal? heatTotalValue = null;

                            foreach (DataRow row in mainDataTable.Rows)
                            {
                                var nextValueColumnName = string.Format(StringFormatResources.HeatTotalNext, _resourceSystemTypeCode);
                                var currentValueColumnName = string.Format(StringFormatResources.HeatTotal, _resourceSystemTypeCode);
                                var diffValueColumnName = string.Format(StringFormatResources.HeatTotalDiff, _resourceSystemTypeCode);

                                if (rowNumber > 0 && heatTotalValue != null)
                                {
                                    row[diffValueColumnName] = heatTotalValue.Value;
                                }

                                if (row[nextValueColumnName] != DBNull.Value && row[currentValueColumnName] != DBNull.Value)
                                {
                                    heatTotalValue = Convert.ToDecimal(row[nextValueColumnName]) -
                                                                   Convert.ToDecimal(row[currentValueColumnName]);
                                }
                                rowNumber++;
                            }
                        }
                    }

                    var rowsForDelete = mainDataTable.Rows.Cast<DataRow>().Where(row => _periodBegin > Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn])).ToList();

                    foreach (var dataRow in rowsForDelete)
                    {
                        mainDataTable.Rows.Remove(dataRow);
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
                            row[DbTablePermanentResources.TimeColumn] = time.AddSeconds(-59).AddMinutes(-59);
                        }
                    }
                }
            }
        }
    }
}
