using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Ek270DaySheetViaHourPlugin : ReportPluginBase
    {
        public MetaObjectEx ParentMetaObjectEx { get; set; }
        private int _gasHour = 10;

        public Ek270DaySheetViaHourPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
            
        }

        public override void Execute()
        {
            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];
            var gasHourRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.GasHourColumn);
            var periodTypeIdRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodTypeIdColumn);
            var periodBeginRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodBeginColumn);
            var periodEndRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodEndColumn);
            var includePeriodEndRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.IncludePeriodEndColumn);

            if (gasHourRow != null)
            {
                _gasHour = Convert.ToInt32(gasHourRow[DbTablePermanentResources.ValueColumn]);
            }

            var periodTypeId = Convert.ToInt32(periodTypeIdRow[DbTablePermanentResources.ValueColumn]);

            // для суточной ведомости
            if (periodTypeId == 3)
            {
                if (periodBeginRow != null && periodEndRow != null)
                {
                    var periodBegin = Convert.ToDateTime(periodBeginRow[DbTablePermanentResources.ValueColumn]);
                    var periodEnd = Convert.ToDateTime(periodEndRow[DbTablePermanentResources.ValueColumn]);
                    var includePeriodEnd = Convert.ToBoolean(includePeriodEndRow[DbTablePermanentResources.ValueColumn]);

                    periodBegin = periodBegin.Date;
                    periodEnd = periodEnd.Date;

                    // корректируем конечную дату, если галочка "Включительно" отключена
                    if (!includePeriodEnd)
                    {
                        periodEnd = periodEnd.AddDays(-1);
                    }

                    // расширяем диапазон дат до газового часа предыдущих суток (для начала) - нужен для расчета потребления на начальную дату
                    // и до газового часа следующих суток после конца - для Summary-таблицы
                    var newPeriodBegin = periodBegin.AddHours(_gasHour).AddDays(-1);
                    var newPeriodEnd = periodEnd.AddHours(_gasHour).AddDays(1);

                    var newPeriodBeginStr = newPeriodBegin.GetDateStringInSqlStyle();
                    var newPeriodEndStr = newPeriodEnd.GetDateStringInSqlStyle();

                    newPeriodBeginStr = string.Format(StringFormatResources.PeriodBeginSql, newPeriodBeginStr);
                    newPeriodEndStr = string.Format(StringFormatResources.PeriodEndSql, newPeriodEndStr);

                    // корректируем исходный запрос: делаем перезапрос по часовым записям с обновленным датами начала и конца
                    var query = ParentMetaObjectEx.Source.Template;

                    var regexPeriodBegin = new Regex(@"periodBegin = '\d{8} \d{2}:\d{2}:\d{2}'");
                    var regexPeriodEnd = new Regex(@"periodEnd = '\d{8} \d{2}:\d{2}:\d{2}'");
                    query = regexPeriodBegin.Replace(query, newPeriodBeginStr);
                    query = regexPeriodEnd.Replace(query, newPeriodEndStr);
                    query = query.Replace(ReportPluginResources.PeriodTypeIdEqual3, ReportPluginResources.PeriodTypeIdEqual2);

                    using (var context = new ApplicationDatabaseContext())
                    {
                        var dataSet = context.ExecuteQuery(query);

                        var mainDataTable = dataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];

                        if (mainDataTable.Rows.Count == 0) return;

                        // Конструирование новой таблицы MainData
                        var newMainDataTable = new DataTable();
                        newMainDataTable.TableName = DbTablePermanentResources.DefaultMainDataTableName;
                        var timeColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        var isValidRowStateColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkDiffFieldName, typeof(decimal));
                        var gasVolumeStandardDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardDiffFieldName, typeof(decimal));
                        var gasVolumeWorkColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));
                        var gasPressureColumn = new DataColumn(FieldsNamesResources.GasPressureFieldName, typeof(decimal));
                        var gasTemperatureColumn = new DataColumn(FieldsNamesResources.GasTemperatureFieldName, typeof(decimal));
                        var gasCorrectionColumn = new DataColumn(FieldsNamesResources.GasCorrectionFieldName, typeof(decimal));

                        newMainDataTable.Columns.AddRange(new DataColumn[] { timeColumn, isValidRowStateColumn, gasVolumeWorkDiffColumn,
                                                                             gasVolumeStandardDiffColumn, gasVolumeWorkColumn, gasVolumeStandardColumn,
                                                                             gasPressureColumn, gasTemperatureColumn, gasCorrectionColumn });

                        // корректируем даты начала и конца в зависимости от реальных дат пришедшей выборки (граничные условия)
                        periodBegin = CorrectBeginPeriod(mainDataTable, periodBegin);
                        periodEnd = CorrectEndPeriod(mainDataTable, periodEnd);

                        // заполняем новую таблицу MainData значениями интеграторов рабочего и стандартного объема
                        // например, для 15.10.2017 берется значение 16.10.2017 10:00 (т.е. конец газового дня 15 октября)
                        for (var dt = newPeriodBegin.Date; dt <= periodEnd; dt = dt.AddDays(1))
                        {
                            var row = newMainDataTable.NewRow();
                            var searchDate = dt.AddDays(1).AddHours(_gasHour);
                            DataRow sourceRow = null;

                            // отклонения от текущей поисковой даты (в часах)
                            int[] hours = new int[] { 0, -1, -2, -3, 1, 2, 3 };
                            int currentHourPosition = 0;

                            while (sourceRow == null && currentHourPosition < (hours.Length - 1))
                            {
                                var sd = searchDate.AddHours(hours[currentHourPosition]);
                                sourceRow = mainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == sd);

                                currentHourPosition++;
                            }

                            row[DbTablePermanentResources.TimeColumn] = dt;

                            if (sourceRow != null)
                            {
                                row[DbTablePermanentResources.IsValidRowStateColumn] = sourceRow[DbTablePermanentResources.IsValidRowStateColumn];
                                row[FieldsNamesResources.GasVolumeWorkFieldName] = sourceRow[FieldsNamesResources.GasVolumeWorkFieldName];
                                row[FieldsNamesResources.GasVolumeStandardFieldName] = sourceRow[FieldsNamesResources.GasVolumeStandardFieldName];
                            }
                            // если все-таки не нашли нужную часовую запись, то копируем из предыдущей (если она есть)
                            else
                            {
                                if (newMainDataTable.Rows.Count > 0)
                                {
                                    var lastRow = newMainDataTable.Rows.Cast<DataRow>().Last();
                                    if (lastRow != null)
                                    {
                                        row[DbTablePermanentResources.IsValidRowStateColumn] = lastRow[DbTablePermanentResources.IsValidRowStateColumn];
                                        row[FieldsNamesResources.GasVolumeWorkFieldName] = lastRow[FieldsNamesResources.GasVolumeWorkFieldName];
                                        row[FieldsNamesResources.GasVolumeStandardFieldName] = lastRow[FieldsNamesResources.GasVolumeStandardFieldName];
                                    }
                                }
                            }

                            newMainDataTable.Rows.Add(row);
                        }

                        // вычисляем разницы для интеграторов и средние значения давления, температуры и коэффициента коррекции
                        for (var dt = periodBegin; dt <= periodEnd; dt = dt.AddDays(1))
                        {
                            var previousDate = dt.AddDays(-1);
                            var calculatedRow = newMainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == dt);
                            var previousRow = newMainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == previousDate);

                            calculatedRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasVolumeWorkFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasVolumeWorkFieldName]);
                            calculatedRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasVolumeStandardFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasVolumeStandardFieldName]);

                            // средние значения неинтегрируемых параметров
                            var startDate = dt.AddHours(_gasHour);
                            var endDate = startDate.AddHours(23); // + остальные 23 значения за сутки

                            var nonIntegRows = mainDataTable.Rows.Cast<DataRow>().Where(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) >= startDate &&
                                                                          Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) <= endDate).ToList();
                            calculatedRow[FieldsNamesResources.GasPressureFieldName] = nonIntegRows.Where(r => r[FieldsNamesResources.GasPressureFieldName] != DBNull.Value).Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasPressureFieldName])).Average();
                            calculatedRow[FieldsNamesResources.GasTemperatureFieldName] = nonIntegRows.Where(r => r[FieldsNamesResources.GasTemperatureFieldName] != DBNull.Value).Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasTemperatureFieldName])).Average();
                            calculatedRow[FieldsNamesResources.GasCorrectionFieldName] = nonIntegRows.Where(r => r[FieldsNamesResources.GasCorrectionFieldName] != DBNull.Value).Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasCorrectionFieldName])).Average();
                        }

                        // Конструирование новой таблицы SummaryData
                        var newSummaryDataTable = new DataTable();
                        newSummaryDataTable.TableName = DbTablePermanentResources.DefaultSummaryDataTableName;
                        var timeSummaryColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        var isValidRowStateSummaryColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));

                        newSummaryDataTable.Columns.AddRange(new DataColumn[] { timeSummaryColumn, isValidRowStateSummaryColumn,
                                                                                gasVolumeWorkSummaryColumn, gasVolumeStandardSummaryColumn });

                        var firstDataRow = newMainDataTable.Rows.Cast<DataRow>().First();
                        var lastDataRow = newMainDataTable.Rows.Cast<DataRow>().Last();

                        var firstSummaryRow = newSummaryDataTable.NewRow();
                        firstSummaryRow[DbTablePermanentResources.TimeColumn] = Convert.ToDateTime(firstDataRow[DbTablePermanentResources.TimeColumn]).AddDays(1).AddHours(_gasHour);
                        firstSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = firstDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                        firstSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = firstDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                        firstSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = firstDataRow[FieldsNamesResources.GasVolumeStandardFieldName];

                        var lastSummaryRow = newSummaryDataTable.NewRow();
                        lastSummaryRow[DbTablePermanentResources.TimeColumn] = Convert.ToDateTime(lastDataRow[DbTablePermanentResources.TimeColumn]).AddDays(1).AddHours(_gasHour);
                        lastSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = lastDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                        lastSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = lastDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                        lastSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = lastDataRow[FieldsNamesResources.GasVolumeStandardFieldName];

                        newSummaryDataTable.Rows.Add(firstSummaryRow);
                        newSummaryDataTable.Rows.Add(lastSummaryRow);

                        firstDataRow.Delete();
                        newMainDataTable.AcceptChanges();

                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultSummaryDataTableName);

                        DataSource.Tables.Add(newMainDataTable);
                        DataSource.Tables.Add(newSummaryDataTable);
                    }
                }
            }

            if (periodTypeId == 2)
            {
                if (periodBeginRow != null && periodEndRow != null)
                {
                    var periodBegin = Convert.ToDateTime(periodBeginRow[DbTablePermanentResources.ValueColumn]);
                    var periodEnd = Convert.ToDateTime(periodEndRow[DbTablePermanentResources.ValueColumn]);
                    var includePeriodEnd = Convert.ToBoolean(includePeriodEndRow[DbTablePermanentResources.ValueColumn]);

                    periodBegin = periodBegin.Date;
                    periodEnd = periodEnd.Date;

                    // корректируем конечную дату, если галочка "Включительно" отключена
                    if (!includePeriodEnd)
                    {
                        periodEnd = periodEnd.AddDays(-1);
                    }

                    // расширяем диапазон дат до газового часа предыдущих суток (для начала) - нужен для расчета потребления на начальную дату
                    // и до газового часа следующих суток после конца - для Summary-таблицы
                    var newPeriodBegin = periodBegin.AddHours(_gasHour);
                    var newPeriodEnd = periodEnd.AddDays(1).AddHours(_gasHour);

                    var newPeriodBeginStr = newPeriodBegin.GetDateStringInSqlStyle();
                    var newPeriodEndStr = newPeriodEnd.GetDateStringInSqlStyle();

                    newPeriodBeginStr = string.Format(StringFormatResources.PeriodBeginSql, newPeriodBeginStr);
                    newPeriodEndStr = string.Format(StringFormatResources.PeriodEndSql, newPeriodEndStr);

                    // корректируем исходный запрос: делаем перезапрос по часовым записям с обновленным датами начала и конца
                    var query = ParentMetaObjectEx.Source.Template;

                    var regexPeriodBegin = new Regex(@"periodBegin = '\d{8} \d{2}:\d{2}:\d{2}'");
                    var regexPeriodEnd = new Regex(@"periodEnd = '\d{8} \d{2}:\d{2}:\d{2}'");
                    query = regexPeriodBegin.Replace(query, newPeriodBeginStr);
                    query = regexPeriodEnd.Replace(query, newPeriodEndStr);
                    query = query.Replace(ReportPluginResources.PeriodTypeIdEqual3, ReportPluginResources.PeriodTypeIdEqual2);

                    using (var context = new ApplicationDatabaseContext())
                    {
                        var dataSet = context.ExecuteQuery(query);

                        var mainDataTable = dataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];

                        if (mainDataTable.Rows.Count == 0) return;

                        // Конструирование новой таблицы MainData
                        var newMainDataTable = new DataTable();
                        newMainDataTable.TableName = DbTablePermanentResources.DefaultMainDataTableName;
                        var timeColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        var isValidRowStateColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkDiffFieldName, typeof(decimal));
                        var gasVolumeStandardDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardDiffFieldName, typeof(decimal));
                        var gasVolumeWorkColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));
                        var gasPressureColumn = new DataColumn(FieldsNamesResources.GasPressureFieldName, typeof(decimal));
                        var gasTemperatureColumn = new DataColumn(FieldsNamesResources.GasTemperatureFieldName, typeof(decimal));
                        var gasCorrectionColumn = new DataColumn(FieldsNamesResources.GasCorrectionFieldName, typeof(decimal));

                        newMainDataTable.Columns.AddRange(new DataColumn[] { timeColumn, isValidRowStateColumn, gasVolumeWorkDiffColumn,
                                                                             gasVolumeStandardDiffColumn, gasVolumeWorkColumn, gasVolumeStandardColumn,
                                                                             gasPressureColumn, gasTemperatureColumn, gasCorrectionColumn });

                        // корректируем даты начала и конца в зависимости от реальных дат пришедшей выборки (граничные условия)
                        //periodBegin = CorrectBeginPeriod(mainDataTable, periodBegin);
                        //periodEnd = CorrectEndPeriod(mainDataTable, periodEnd);

                        // заполняем новую таблицу MainData значениями интеграторов рабочего и стандартного объема
                        // например, для 15.10.2017 берется значение 16.10.2017 10:00 (т.е. конец газового дня 15 октября)
                        for (var dt = newPeriodBegin.AddHours(-1); dt < newPeriodEnd; dt = dt.AddHours(1))
                        {
                            var row = newMainDataTable.NewRow();
                            var searchDate = dt.AddHours(1);
                            var sourceRow = mainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == searchDate);

                            row[DbTablePermanentResources.TimeColumn] = dt;

                            if (sourceRow != null)
                            {
                                row[DbTablePermanentResources.IsValidRowStateColumn] = sourceRow[DbTablePermanentResources.IsValidRowStateColumn];
                                row[FieldsNamesResources.GasVolumeWorkFieldName] = sourceRow[FieldsNamesResources.GasVolumeWorkFieldName];
                                row[FieldsNamesResources.GasVolumeStandardFieldName] = sourceRow[FieldsNamesResources.GasVolumeStandardFieldName];
                            }

                            newMainDataTable.Rows.Add(row);
                        }

                        // вычисляем разницы для интеграторов и средние значения давления, температуры и коэффициента коррекции
                        for (var dt = newPeriodBegin; dt <= newPeriodEnd.AddHours(-1); dt = dt.AddHours(1))
                        {
                            var previousDate = dt.AddHours(-1);
                            var calculatedRow = newMainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == dt);
                            var previousRow = newMainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == previousDate);

                            if (calculatedRow[FieldsNamesResources.GasVolumeWorkFieldName] == DBNull.Value || previousRow[FieldsNamesResources.GasVolumeWorkFieldName] == DBNull.Value)
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = DBNull.Value;
                            }
                            else
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasVolumeWorkFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasVolumeWorkFieldName]);
                            }

                            if (calculatedRow[FieldsNamesResources.GasVolumeStandardFieldName] == DBNull.Value || previousRow[FieldsNamesResources.GasVolumeStandardFieldName] == DBNull.Value)
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = DBNull.Value;
                            }
                            else
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasVolumeStandardFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasVolumeStandardFieldName]);
                            }


                            var nonIntegRows = mainDataTable.Rows.Cast<DataRow>().Where(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == dt).ToList();

                            calculatedRow[FieldsNamesResources.GasPressureFieldName] = nonIntegRows.Where(r => r[FieldsNamesResources.GasPressureFieldName] != DBNull.Value).Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasPressureFieldName])).FirstOrDefault();
                            calculatedRow[FieldsNamesResources.GasTemperatureFieldName] = nonIntegRows.Where(r => r[FieldsNamesResources.GasTemperatureFieldName] != DBNull.Value).Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasTemperatureFieldName])).FirstOrDefault();
                            calculatedRow[FieldsNamesResources.GasCorrectionFieldName] = nonIntegRows.Where(r => r[FieldsNamesResources.GasCorrectionFieldName] != DBNull.Value).Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasCorrectionFieldName])).FirstOrDefault();
                        }

                        // Конструирование новой таблицы SummaryData
                        var newSummaryDataTable = new DataTable();
                        newSummaryDataTable.TableName = DbTablePermanentResources.DefaultSummaryDataTableName;
                        var timeSummaryColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        var isValidRowStateSummaryColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));

                        newSummaryDataTable.Columns.AddRange(new DataColumn[] { timeSummaryColumn, isValidRowStateSummaryColumn,
                                                                                gasVolumeWorkSummaryColumn, gasVolumeStandardSummaryColumn });

                        var firstDataRow = newMainDataTable.Rows.Cast<DataRow>().First();
                        var lastDataRow = newMainDataTable.Rows.Cast<DataRow>().Where(p => p[FieldsNamesResources.GasVolumeWorkFieldName] != DBNull.Value).Last();

                        var firstSummaryRow = newSummaryDataTable.NewRow();
                        firstSummaryRow[DbTablePermanentResources.TimeColumn] = Convert.ToDateTime(firstDataRow[DbTablePermanentResources.TimeColumn]).AddHours(1);
                        firstSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = firstDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                        firstSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = firstDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                        firstSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = firstDataRow[FieldsNamesResources.GasVolumeStandardFieldName];

                        var lastSummaryRow = newSummaryDataTable.NewRow();
                        lastSummaryRow[DbTablePermanentResources.TimeColumn] = Convert.ToDateTime(lastDataRow[DbTablePermanentResources.TimeColumn]).AddHours(1);
                        lastSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = lastDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                        lastSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = lastDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                        lastSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = lastDataRow[FieldsNamesResources.GasVolumeStandardFieldName];

                        newSummaryDataTable.Rows.Add(firstSummaryRow);
                        newSummaryDataTable.Rows.Add(lastSummaryRow);

                        firstDataRow.Delete();
                        newMainDataTable.AcceptChanges();

                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultSummaryDataTableName);

                        DataSource.Tables.Add(newMainDataTable);
                        DataSource.Tables.Add(newSummaryDataTable);
                    }
                }
            }
        }

        /// <summary>
        /// Корректирует конец периода, в зависимости от того какие даты есть в БД
        /// </summary>
        /// <param name="mainDataTable"></param>
        /// <param name="endPeriod"></param>
        /// <returns></returns>
        private DateTime CorrectEndPeriod(DataTable mainDataTable, DateTime endPeriod)
        {
            var lastMainDataRow = mainDataTable.Rows.Cast<DataRow>().Last();
            var lastDateInMainData = Convert.ToDateTime(lastMainDataRow[DbTablePermanentResources.TimeColumn]);
            var correctedTime = endPeriod;

            var dateNeedForEndPeriod = endPeriod.AddDays(1).AddHours(_gasHour);
            var dateLowerBoundNeedForEndPeriod = endPeriod.AddDays(1).AddHours(_gasHour).AddHours(-3);

            if (dateLowerBoundNeedForEndPeriod <= lastDateInMainData) return correctedTime;

            if (dateNeedForEndPeriod > lastDateInMainData)
            {
                var dates = mainDataTable.Rows.Cast<DataRow>().Where(r => r[DbTablePermanentResources.TimeColumn] != DBNull.Value)
                    .Select(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn])).OrderByDescending(el => el).ToList();

                foreach (var date in dates)
                {
                    if (date.Hour == _gasHour)
                    {
                        correctedTime = date.AddHours(-_gasHour).AddDays(-1);
                        break;
                    }
                }
            }

            return correctedTime;
        }

        private DateTime CorrectBeginPeriod(DataTable mainDataTable, DateTime beginPeriod)
        {
            var firstMainDataRow = mainDataTable.Rows.Cast<DataRow>().First();
            var firstDateInMainData = Convert.ToDateTime(firstMainDataRow[DbTablePermanentResources.TimeColumn]);
            var correctedTime = beginPeriod;

            var dateNeedForEndPeriod = beginPeriod.AddDays(-1).AddHours(_gasHour);

            if (dateNeedForEndPeriod < firstDateInMainData)
            {
                var dates = mainDataTable.Rows.Cast<DataRow>().Where(r => r[DbTablePermanentResources.TimeColumn] != DBNull.Value)
                    .Select(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn])).OrderBy(el => el).ToList();
                
                foreach (var date in dates)
                {
                    if (date.Hour == _gasHour)
                    {
                        correctedTime = date.AddHours(-_gasHour).AddDays(1);
                    }
                }
            }

            return correctedTime;
        }
    }
}
