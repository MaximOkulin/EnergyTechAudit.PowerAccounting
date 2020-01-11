using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class DiffCalculatorPlugin : ReportPluginBase 
    {
        private readonly string _resourceSystemTypeCode;
        public DiffCalculatorPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var resourceSystemTypeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSystemTypeCodeColumn));

            if (resourceSystemTypeParam != null)
            {
                _resourceSystemTypeCode = Convert.ToString(resourceSystemTypeParam.Value);
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            var reportFieldInfo = DataSource.Tables[DbTablePermanentResources.DefaultReportFieldInfoTableName];
            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];

            var deviceCode = reportParameterTable.AsEnumerable()
                .Where(r => Convert.ToString(r[DbTablePermanentResources.NameColumn]) == DbTablePermanentResources.DeviceCodeColumn)
                .Select(r => Convert.ToString(r[DbTablePermanentResources.ValueColumn]))
                .FirstOrDefault();

            var periodTypeCode = reportParameterTable.AsEnumerable()
                .Where(r => Convert.ToString(r[DbTablePermanentResources.NameColumn]) == DbTablePermanentResources.PeriodTypeCodeColumn)
                .Select(r => Convert.ToString(r[DbTablePermanentResources.ValueColumn]))
                .FirstOrDefault();

            var integrableFieldsRows = reportFieldInfo
                .Select(string.Format(reportFieldInfo.Locale, "IntegrableValue = true"))
                .Select(fieldsRow => Convert.ToString(fieldsRow[DbTablePermanentResources.NameColumn]))
                .ToList();

            var errorInfoColumnName = string.Format(StringFormatResources.ErrorInfoColumn,
                    _resourceSystemTypeCode);

            // если в главной таблице нет еще колонки HeatSys.ErrorInfo (в зависимости от типа ресурсной системы)
            if (!mainDataTable.Columns.Contains(errorInfoColumnName))
            {
                // добавляем кастомный столбец для хранения информации об ошибках
                mainDataTable.Columns.Add(new DataColumn(errorInfoColumnName, typeof(string)));
            }

            if (mainDataTable.Rows.Count > 0)
            {
                foreach (DataRow dataRow in mainDataTable.Rows)
                {
                    foreach (var integrableFieldsRow in integrableFieldsRows)
                    {
                        var nextValueColumnName = string.Format("{0}.Next", integrableFieldsRow);
                        var diffValueColumnName = string.Format("{0}.Diff", integrableFieldsRow);

                        if (dataRow[integrableFieldsRow] != DBNull.Value && dataRow[nextValueColumnName] != DBNull.Value)
                        {
                            if (deviceCode == DictionariesValueResources.DeviceCodeKm5 ||
                                deviceCode == DictionariesValueResources.DeviceCodeRm5)
                            {
                                var time = Convert.ToDateTime(dataRow[DbTablePermanentResources.TimeColumn]);

                                var month = time.Month;
                                var day = time.Day;
                                var hour = time.Hour;

                                if (periodTypeCode == DictionariesValueResources.PeriodTypeCodeDay)
                                {
                                    if (month == 1 && day == 1)
                                    {
                                        dataRow[integrableFieldsRow] = default(decimal);
                                    }

                                }
                                else if (periodTypeCode == DictionariesValueResources.PeriodTypeCodeHour)
                                {
                                    if (month == 1 && day == 1 && hour == default)
                                    {
                                        dataRow[integrableFieldsRow] = default(decimal);
                                    }
                                }
                            }

                            dataRow[diffValueColumnName] =
                                Convert.ToDecimal(dataRow[nextValueColumnName]) -
                                Convert.ToDecimal(dataRow[integrableFieldsRow]);

                        }
                    }
                }
            }
        }
    }
}
