using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class IslandDataSourceReportPlugin: ReportPluginBase
    {
        public MetaObjectEx ParentMetaObjectEx { get; set; }
        private readonly int _periodTypeId;
        private readonly int _channelTemplateId;
        private readonly string _deviceCode;

        public IslandDataSourceReportPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var channelTemplateParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ChannelTemplateIdColumn));

            if (channelTemplateParam != null)
            {
                _channelTemplateId = Convert.ToInt32(channelTemplateParam.Value);
            }

            var deviceCodeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.DeviceCodeColumn));

            if (deviceCodeParam != null)
            {
                _deviceCode = Convert.ToString(deviceCodeParam.Value);
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];

            var fieldsInfoTable = DataSource.Tables[DbTablePermanentResources.DefaultReportFieldInfoTableName];

            var integrableFieldsRows = fieldsInfoTable.Select(string.Format(fieldsInfoTable.Locale, ReportPluginResources.IntegrableValueTrue))
                                            .Select(fieldsRow => Convert.ToString(fieldsRow[DbTablePermanentResources.NameColumn])).ToList();

            var instantFieldsRows = fieldsInfoTable.Select(string.Format(fieldsInfoTable.Locale, ReportPluginResources.IntegrableValueFalse))
                                            .Select(fieldsRow => Convert.ToString(fieldsRow[DbTablePermanentResources.NameColumn])).ToList();

            var errorInfoField = integrableFieldsRows.FirstOrDefault(p => p.Contains(ReportPluginResources.ErrorInfo));

            if (errorInfoField != null)
            {
                integrableFieldsRows.Remove(errorInfoField);
            }

            var nonIntegrableFieldsRows = fieldsInfoTable.Select(string.Format(fieldsInfoTable.Locale, ReportPluginResources.IntegrableValueFalse))
                                            .Select(fieldsRow => Convert.ToString(fieldsRow[DbTablePermanentResources.NameColumn])).ToList();


            PrepareMainDataForTem();

            if (mainDataTable.Rows.Count > 0)
            {
                // для шаблонов КМ-5 ХВС (25) и РМ-5 ХВС (17) через импульсный вход обнуляем параметры давления, которые не смапаны на реальный параметр прибора
                if (_channelTemplateId == 25 || _channelTemplateId == 17)
                {
                    foreach (DataRow dataRow in mainDataTable.Rows)
                    {
                        dataRow[FieldsNamesResources.CwsPressureSupplyPipe] = 0;
                        dataRow[FieldsNamesResources.CwsPressureSupplyPipeNext] = 0;
                    }
                }

                // для шаблона КМ-5 ЦО Подпитка (243) через импульсный вход обнуляем параметр давления, который не смапан на реальный параметр прибора
                if (_channelTemplateId == 243)
                {
                    foreach (DataRow dataRow in mainDataTable.Rows)
                    {
                        dataRow[FieldsNamesResources.HeatSysPressureSupplyPipe] = 0;                        
                    }
                }

                var firstDate = Convert.ToDateTime(mainDataTable.Rows[0][DbTablePermanentResources.TimeColumn]);
                var lastDate =
                    Convert.ToDateTime(mainDataTable.Rows[mainDataTable.Rows.Count - 1][DbTablePermanentResources.TimeColumn]);

                Stack<DateTime> mainDataDates = new Stack<DateTime>();

                mainDataTable.DefaultView.Sort = string.Format(StringFormatResources.DESC, DbTablePermanentResources.TimeColumn);
                mainDataTable = mainDataTable.DefaultView.ToTable();

                foreach (DataRow dataRow in mainDataTable.Rows)
                {
                    mainDataDates.Push(Convert.ToDateTime(dataRow[DbTablePermanentResources.TimeColumn]));
                }

                var currentTime = mainDataDates.Pop();

                while (mainDataDates.Count > 0)
                {
                    var nextTime = mainDataDates.Pop();

                    var currentRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, currentTime,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                    var nextRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, nextTime,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                    bool isNeedToDeleteNextRow = false;

                    foreach (var fieldsRow in integrableFieldsRows)
                    {
                        var nextFieldName = string.Format(StringFormatResources.Next, fieldsRow);
                        if (currentRow[nextFieldName] == DBNull.Value)
                        {
                            currentRow[nextFieldName] = nextRow[nextFieldName];
                        }
                    }

                    foreach (var nonIntegrableFieldsRow in nonIntegrableFieldsRows)
                    {
                        if (currentRow[nonIntegrableFieldsRow] == DBNull.Value)
                        {
                            if (IsHwsLookupPassReturnParams(nonIntegrableFieldsRow)) continue;

                            currentRow[nonIntegrableFieldsRow] = nextRow[nonIntegrableFieldsRow];
                            isNeedToDeleteNextRow = true;
                        }
                    }

                    if (isNeedToDeleteNextRow)
                    {
                        mainDataTable.Rows.Remove(nextRow);
                        if (mainDataDates.Count > 0)
                        {
                            nextTime = mainDataDates.Pop();
                        }
                    }

                    currentTime = nextTime;
                }

                // добавляем пропущенные дни и метим их невалидными
                
                // находим реальную дату последней строчки, которая должна быть в таблице 
                // (расчет на основании даты второй строчки таблицы итогов)
                foreach (DataRow summaryRow in summaryDataTable.Rows)
                {
                    if (Convert.ToDateTime(summaryRow[DbTablePermanentResources.TimeColumn]) > GetNextDate(lastDate))
                    {
                        lastDate = GetPreviousDate(Convert.ToDateTime(summaryRow[DbTablePermanentResources.TimeColumn]));
                    }
                }

                // для КМ-5 (РМ-5) ищем строки, в которых время наработки больше, чем 24 часа
                if (IsKm5())
                {
                    var timeNormalField = integrableFieldsRows.FirstOrDefault(p => p.Contains(FieldsNamesResources.TimeNormalFieldName));

                    if (timeNormalField != null)
                    {
                        var diffTimeNormalField = string.Format(StringFormatResources.DiffParameter, timeNormalField);
                        
                        foreach (DataRow row in mainDataTable.Rows)
                        {
                            if (row[diffTimeNormalField] != DBNull.Value)
                            {
                                var timeNormal = Convert.ToDecimal(row[diffTimeNormalField]);
                                if (timeNormal > 24)
                                {
                                    var time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                                    var calculatedDataRow = CalculateKm5DayDiffViaHour(time, integrableFieldsRows, instantFieldsRows);

                                    if (calculatedDataRow != null)
                                    {
                                        foreach (DataColumn col in calculatedDataRow.Table.Columns)
                                        {
                                            var columnName = col.ColumnName;
                                            if (row.Table.Columns.Contains(columnName))
                                            {
                                                row[columnName] = calculatedDataRow[columnName];
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                AddAbsentRows(mainDataTable, firstDate, lastDate, integrableFieldsRows, instantFieldsRows);
                
                // повторный просмотр строк
                foreach (DataRow dataRow in mainDataTable.Rows)
                {
                    mainDataDates.Push(Convert.ToDateTime(dataRow[DbTablePermanentResources.TimeColumn]));
                }

                while (mainDataDates.Count > 0)
                {
                    currentTime = mainDataDates.Pop();
                    var currentRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, currentTime,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                    if (Convert.ToBoolean(currentRow[DbTablePermanentResources.IsValidRowStateColumn]))
                    {
                        foreach (var fieldsRow in integrableFieldsRows)
                        {
                            var nextFieldName = string.Format(StringFormatResources.Next, fieldsRow);
                            if (IsHwsLookupPassReturnParams(nextFieldName)) continue;

                            if (currentRow[nextFieldName] == DBNull.Value)
                            {
                                mainDataTable.Rows.Remove(currentRow);
                                break;
                            }
                        }
                    }
                }

                mainDataTable.DefaultView.Sort = string.Format(StringFormatResources.ASC, DbTablePermanentResources.TimeColumn);
                mainDataTable = mainDataTable.DefaultView.ToTable();
                DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
                DataSource.Tables.Add(mainDataTable);
            }
        }

        /// <summary>
        /// Параметры обратки, которые надо пропускать для шаблонов ГВС-тупиковая
        /// </summary>
        /// <param name="fieldName"></param>
        /// <returns></returns>
        private bool IsHwsLookupPassReturnParams(string fieldName)
        {
            // 161 - шаблон ТЭМ-104
            return _channelTemplateId == 161 && fieldName.Contains(ReportPluginResources.Return);
        }

        private DateTime GetNextDate(DateTime dt)
        {
            if (_periodTypeId == 2)
            {
                return dt.AddHours(1);
            }
            if (_periodTypeId == 3)
            {
                return dt.AddDays(1); ;
            }
            return dt;
        }

        private DateTime GetPreviousDate(DateTime dt)
        {
            if (_periodTypeId == 2)
            {
                return dt.AddHours(-1);
            }
            if (_periodTypeId == 3)
            {
                return dt.AddDays(-1); ;
            }
            return dt;
        }

        private void AddAbsentRows(DataTable table, DateTime startDate, DateTime endDate, List<string> integrableFields, List<string> instantFields)
        {
            for (var dt = startDate; dt <= endDate; dt = GetNextDate(dt))
            {
                var row =
                    table.Select(string.Format(table.Locale, StringFormatResources.SelectByTimeColumnCondition, dt,
                        DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                if (row == null)
                {
                    var newRow = table.NewRow();
                    newRow[DbTablePermanentResources.TimeColumn] = dt;

                    DataRow calculatedDataRow = null;
                    if (IsKm5())
                    {
                        calculatedDataRow = CalculateKm5DayDiffViaHour(dt, integrableFields, instantFields);
                    }

                    if (calculatedDataRow != null)
                    {
                        foreach (DataColumn col in calculatedDataRow.Table.Columns)
                        {
                            var columnName = col.ColumnName;
                            if (newRow.Table.Columns.Contains(columnName))
                            {
                                newRow[columnName] = calculatedDataRow[columnName];
                            }
                        }
                        newRow[DbTablePermanentResources.IsValidRowStateColumn] = true;

                        // заполняем остальные поля нулями
                        foreach (DataColumn col in newRow.Table.Columns)
                        {
                            if (newRow[col] == DBNull.Value)
                            {
                                newRow[col] = 0;
                            }
                        }
                    }
                    else
                    {
                        newRow[DbTablePermanentResources.IsValidRowStateColumn] = false;

                        foreach (var column in table.Columns)
                        {
                            var dataColumn = (DataColumn)column;
                            if (!dataColumn.ColumnName.Equals(DbTablePermanentResources.TimeColumn))
                            {
                                newRow[dataColumn.ColumnName] = 0;
                            }
                        }
                    }

                    table.Rows.Add(newRow);
                }
            }
        }

        /// <summary>
        /// Подготавливает основную таблицу данных для приборов ТЭМ
        /// (сбрасывает часовую компоненту у дат, в которых она присутствует; удаляет дубликаты дат в случае их появления)
        /// </summary>
        private void PrepareMainDataForTem()
        {
            if (_periodTypeId == 3 && (_deviceCode.Equals(DictionariesValueResources.Tem104DeviceCode, StringComparison.Ordinal) ||
                _deviceCode.Equals(DictionariesValueResources.Tem106DeviceCode, StringComparison.Ordinal) ||
                _deviceCode.Equals(DictionariesValueResources.Tem104_TesmartDeviceCode, StringComparison.Ordinal) ||
                _deviceCode.Equals(DictionariesValueResources.Tesma106DeviceCode, StringComparison.Ordinal) ||
                _deviceCode.Equals(DictionariesValueResources.Tem116DeviceCode, StringComparison.Ordinal)))
            {
                var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

                var datesForRemove = new List<DateTime>();

                foreach (DataRow dataRow in mainDataTable.Rows)
                {
                    var time = Convert.ToDateTime(dataRow[DbTablePermanentResources.TimeColumn]);

                    if (time.Hour > 0 || time.Minute > 0 || time.Second > 0)
                    {
                        var date = time.Date;

                        var searchTimeRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, date,
                                DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                        if (searchTimeRow == null)
                        {
                            dataRow[DbTablePermanentResources.TimeColumn] = date;
                        }
                        else
                        {
                            datesForRemove.Add(time);
                        }
                    }
                }

                // даты для удаления
                if (datesForRemove.Count > 0)
                {
                    foreach (var dt in datesForRemove)
                    {
                        var row = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, dt,
                                    DbTablePermanentResources.TimeColumn)).FirstOrDefault();
                        mainDataTable.Rows.Remove(row);
                    }
                }
            }
        }

        /// <summary>
        /// Рассчитывает дифференс (потребление) для КМ-5 через часовые архивы
        /// </summary>
        /// <param name="dt"></param>
        private DataRow CalculateKm5DayDiffViaHour(DateTime dt, List<string> integrableFieldsRows, List<string> instantFieldsRows)
        {
            var templateTable = new DataTable();

            foreach(var fieldRowName in integrableFieldsRows)
            {
                templateTable.Columns.Add(new DataColumn(string.Format(StringFormatResources.DiffParameter, fieldRowName), typeof(decimal)));
            }
            foreach (var fieldRowName in instantFieldsRows)
            {
                if (!fieldRowName.Contains(ReportPluginResources.Diff))
                {
                    templateTable.Columns.Add(new DataColumn(fieldRowName, typeof(decimal)));
                }
            }

            var resultRow = templateTable.NewRow();

            var periodBegin = dt;
            var periodEnd = dt.AddDays(1);

            var periodBeginStr = string.Format(StringFormatResources.PeriodBeginSql, periodBegin.GetDateStringInSqlStyle());
            var periodEndStr = string.Format(StringFormatResources.PeriodEndSql, periodEnd.GetDateStringInSqlStyle());

            // корректируем исходный запрос: делаем перезапрос по часовым записям с обновленными датами начала и конца, сбрасываем флаг "Включительно"
            var query = ParentMetaObjectEx.Source.Template;

            var regexPeriodBegin = new Regex(@"periodBegin = '\d{8} \d{2}:\d{2}:\d{2}'");
            var regexPeriodEnd = new Regex(@"periodEnd = '\d{8} \d{2}:\d{2}:\d{2}'");
            query = regexPeriodBegin.Replace(query, periodBeginStr);
            query = regexPeriodEnd.Replace(query, periodEndStr);

            query = query.Replace(ReportPluginResources.PeriodTypeIdEqual3, ReportPluginResources.PeriodTypeIdEqual2);
            query = query.Replace(ReportPluginResources.IncludePeriodEndEqual1, ReportPluginResources.IncludePeriodEndEqual0);

            using (var context = new ApplicationDatabaseContext())
            {
                var dataSet = context.ExecuteQuery(query);
                var mainDataTable = dataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];
                var summaryDataTable = dataSet.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];

                // дополняем недостающими записями из суммарной таблицы
                if (summaryDataTable.Rows.Count > 0)
                {
                    var datesSummary = new List<DateTime>();
                    foreach(DataRow row in summaryDataTable.Rows)
                    {
                        datesSummary.Add(Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]));
                    }

                    foreach(var date in datesSummary)
                    {
                       var row = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, date,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                        if (row == null)
                        {
                            var summaryRow = summaryDataTable.Select(string.Format(mainDataTable.Locale, 
                                StringFormatResources.SelectByTimeColumnCondition, date, DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                            var mainDataTableNewRow = mainDataTable.NewRow();

                            foreach(DataColumn column in mainDataTable.Columns)
                            {
                                mainDataTableNewRow[column.ColumnName] = summaryRow[column.ColumnName];
                            }

                            mainDataTable.Rows.Add(mainDataTableNewRow);
                        }
                    }
                }

                // есть смысл вычислять только, когда записей как минимум две
                if (mainDataTable.Rows.Count > 1)
                {
                    var dates = new List<DateTime>();
                    
                    foreach(DataRow row in mainDataTable.Rows)
                    {
                        dates.Add(Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]));
                    }

                    var minDate = dates.Min();
                    var maxDate = dates.Max();

                    var minRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, minDate,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();
                    var maxRow = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, maxDate,
                            DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                    foreach (var fieldRowName in integrableFieldsRows)
                    {
                        if (maxRow[fieldRowName] != DBNull.Value && minRow[fieldRowName] != DBNull.Value)
                        {
                            resultRow[string.Format(StringFormatResources.DiffParameter, fieldRowName)] = Convert.ToDecimal(maxRow[fieldRowName]) - Convert.ToDecimal(minRow[fieldRowName]);
                        }
                        else
                        {
                            resultRow = null;
                            // одно из значений отсутствует, поэтому нет смысла продолжать
                            break;
                        }
                    }

                    foreach (var fieldRowName in instantFieldsRows)
                    {
                        if (!fieldRowName.Contains(ReportPluginResources.Diff))
                        {
                            try
                            {
                                var avg = (decimal)mainDataTable.Compute(string.Format(StringFormatResources.Avg, fieldRowName), string.Empty);
                                resultRow[fieldRowName] = avg;
                            }
                            catch (InvalidCastException) { }
                        }
                    }
                }
                else
                {
                    return null;
                }
            }
            return resultRow;
        }

        private bool IsKm5()
        {
            return _deviceCode.Equals(DictionariesValueResources.DeviceCodeKm5, StringComparison.Ordinal) || _deviceCode.Equals(DictionariesValueResources.DeviceCodeRm5, StringComparison.Ordinal);
        }
    }
}
