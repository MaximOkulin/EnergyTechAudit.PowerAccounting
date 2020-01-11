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
    public class IrvisFactoryReportPlugin : ReportPluginBase
    {
        public MetaObjectEx ParentMetaObjectEx { get; set; }
        private int _gasHour = 10;

        public IrvisFactoryReportPlugin(object dataSource, IEnumerable<object> parameters)
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

                    if (periodBegin == periodEnd)
                    {
                        periodEnd = periodEnd.AddDays(1);
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
                        var timeSupportColumn = new DataColumn(FieldsNamesResources.TimeStringFieldName, typeof(string));
                        var isValidRowStateColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkDiffFieldName, typeof(decimal));
                        var gasVolumeStandardDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardDiffFieldName, typeof(decimal));
                        var gasVolumeWorkColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));
                        var gasPressureColumn = new DataColumn(FieldsNamesResources.GasPressureFieldName, typeof(decimal));
                        var gasTemperatureColumn = new DataColumn(FieldsNamesResources.GasTemperatureFieldName, typeof(decimal));
                        var timeNormalColumn = new DataColumn(FieldsNamesResources.GasTimeNormalFieldName, typeof(decimal));
                        var timeNormalDiffColumn = new DataColumn(FieldsNamesResources.GasTimeNormalDiffFieldName, typeof(decimal));
                        var timeDenialDiffColumn = new DataColumn(FieldsNamesResources.GasTimeDenialDiffFieldName, typeof(decimal));
                        var errorInfoColumn = new DataColumn(FieldsNamesResources.GasErrorInfoFieldName, typeof(string));
                        

                        newMainDataTable.Columns.AddRange(new DataColumn[] { timeColumn, timeSupportColumn, isValidRowStateColumn, gasVolumeWorkDiffColumn,
                                                                             gasVolumeStandardDiffColumn, gasVolumeWorkColumn, gasVolumeStandardColumn,
                                                                             gasPressureColumn, gasTemperatureColumn, timeNormalColumn,
                                                                             timeNormalDiffColumn, timeDenialDiffColumn, errorInfoColumn });
                        
                        // корректируем даты начала и конца в зависимости от реальных дат пришедшей выборки (граничные условия)
                        periodBegin = CorrectBeginPeriod(mainDataTable, periodBegin);
                        periodEnd = CorrectEndPeriod(mainDataTable, periodEnd);

                        // заполняем новую таблицу MainData значениями интеграторов рабочего и стандартного объема
                        // например, для 15.10.2017 берется значение 16.10.2017 10:00 (т.е. конец газового дня 15 октября)
                        for (var dt = periodBegin.Date; dt < periodEnd; dt = dt.AddDays(1))
                        {
                            var row = newMainDataTable.NewRow();
                            var searchDate = dt.AddDays(1).AddHours(_gasHour);

                            var sd = searchDate;
                            DataRow sourceRow = mainDataTable.Rows.Cast<DataRow>().FirstOrDefault(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) == sd &&
                              r[FieldsNamesResources.GasVolumeWorkFieldName] != DBNull.Value && r[FieldsNamesResources.GasVolumeStandardFieldName] != DBNull.Value);

                            if (sourceRow == null)
                            {
                                var startDate = sd.AddHours(-3);
                                sourceRow = mainDataTable.Rows.Cast<DataRow>()
                                .Where(r => Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) <= sd && Convert.ToDateTime(r[DbTablePermanentResources.TimeColumn]) >= startDate &&
                                       r[FieldsNamesResources.GasVolumeWorkFieldName] != DBNull.Value && r[FieldsNamesResources.GasVolumeStandardFieldName] != DBNull.Value)
                                .OrderByDescending(p => Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn])).FirstOrDefault();
                            }                           

                            row[DbTablePermanentResources.TimeColumn] = dt;
                            var eDate = dt.AddDays(1);
                            row[FieldsNamesResources.TimeStringFieldName] = string.Format(StringFormatResources.IrvisDayTimeString, dt.Day, dt.Month, eDate.Day, eDate.Month);

                            if (sourceRow != null)
                            {
                                
                                row[DbTablePermanentResources.IsValidRowStateColumn] = sourceRow[DbTablePermanentResources.IsValidRowStateColumn];
                                row[FieldsNamesResources.GasVolumeWorkFieldName] = sourceRow[FieldsNamesResources.GasVolumeWorkFieldName];
                                row[FieldsNamesResources.GasVolumeStandardFieldName] = sourceRow[FieldsNamesResources.GasVolumeStandardFieldName];
                                row[FieldsNamesResources.GasTimeNormalFieldName] = sourceRow[FieldsNamesResources.GasTimeNormalFieldName];
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
                                        row[FieldsNamesResources.GasTimeNormalFieldName] = lastRow[FieldsNamesResources.GasTimeNormalFieldName];
                                    }
                                }
                            }

                            newMainDataTable.Rows.Add(row);
                        }

                        // вычисляем разницы для интеграторов и средние значения давления, температуры, времени наработки и времени простоя
                        for (var dt = periodBegin.Date; dt < periodEnd; dt = dt.AddDays(1))
                        {
                            var currentNewMainDataTableRow = ReportHelper.GetDataRowByDate(newMainDataTable, dt);

                            // обыгрыш граничного условия - нужно посмотреть вглубь на одну дату, которая реально не участвует в таблице
                            if (dt == periodBegin.Date)
                            {
                                var previousDate = dt.AddHours(_gasHour);
                                var previousNotIncludedRow = ReportHelper.GetDataRowByDate(mainDataTable, previousDate);
                                if (previousNotIncludedRow != null)
                                {
                                    try
                                    {
                                        // рассчитываем Gas.Volume.Standard.Diff
                                        currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] =
                                            Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardFieldName]) -
                                            Convert.ToDecimal(previousNotIncludedRow[FieldsNamesResources.GasVolumeStandardFieldName]);
                                        // рассчитываем Gas.Volume.Work.Diff
                                        currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] =
                                            Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkFieldName]) -
                                            Convert.ToDecimal(previousNotIncludedRow[FieldsNamesResources.GasVolumeWorkFieldName]);
                                        // рассчитываем Gas.Time.Normal.Diff
                                        var timeNormalDiff = Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalFieldName]) -
                                            Convert.ToDecimal(previousNotIncludedRow[FieldsNamesResources.GasTimeNormalFieldName]); 
                                        if (timeNormalDiff < 0)
                                        {
                                            timeNormalDiff = 0;
                                        }
                                        else if (timeNormalDiff > 24)
                                        {
                                            timeNormalDiff = 24;
                                        }
                                        currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = timeNormalDiff;
                                            
                                        // рассчитываем Gas.Time.Denial.Diff
                                        currentNewMainDataTableRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = 24 -
                                            Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName]);
                                    }
                                    catch(InvalidCastException)
                                    {
                                        currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = 0;
                                        currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = 0;
                                        currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = 0;
                                        currentNewMainDataTableRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = 0;
                                    }                                        
                                }
                                else
                                {
                                    currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = 0;
                                    currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = 0;
                                    currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = 0;
                                    currentNewMainDataTableRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = 0;
                                }
                            }
                            else
                            {
                                var previousNewMainDataTableRow = ReportHelper.GetDataRowByDate(newMainDataTable, dt.AddDays(-1));
                                try
                                {
                                    // рассчитываем Gas.Volume.Standard.Diff
                                    currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] =
                                        Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardFieldName]) -
                                        Convert.ToDecimal(previousNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardFieldName]);
                                    // рассчитываем Gas.Volume.Work.Diff
                                    currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] =
                                        Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkFieldName]) -
                                        Convert.ToDecimal(previousNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkFieldName]);
                                    // рассчитываем Gas.Time.Normal.Diff
                                    var timeNormalDiff = Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalFieldName]) -
                                        Convert.ToDecimal(previousNewMainDataTableRow[FieldsNamesResources.GasTimeNormalFieldName]);
                                    if (timeNormalDiff < 0)
                                    {
                                        timeNormalDiff = 0;
                                    }
                                    else if (timeNormalDiff > 24)
                                    {
                                        timeNormalDiff = 24;
                                    }
                                    currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = timeNormalDiff;
                                    
                                    // рассчитываем Gas.Time.Denial.Diff
                                    currentNewMainDataTableRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = 24 -
                                        Convert.ToDecimal(currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName]);
                                }
                                catch(InvalidCastException)
                                {
                                    currentNewMainDataTableRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = 0;
                                    currentNewMainDataTableRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = 0;
                                    currentNewMainDataTableRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = 0;
                                    currentNewMainDataTableRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = 0;
                                }
                            }

                            var rowForAverageCalculate = ReportHelper.GetDataRowByDate(newMainDataTable, dt);
                            // рассчитываем среднее давление
                            var sDate = dt.AddHours(_gasHour); // 25.06.2018 10:00
                            var eDate = sDate.AddDays(1).AddHours(-1); // 26.06.2018 09:00

                            var rows = ReportHelper.GetDataRowsByDates(mainDataTable, sDate, eDate);
                            try
                            {
                                rowForAverageCalculate[FieldsNamesResources.GasPressureFieldName] =
                                    rows.Where(r => r[FieldsNamesResources.GasPressureFieldName] != DBNull.Value)
                                    .Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasPressureFieldName])).Average();
                            }
                            catch(InvalidOperationException)
                            {
                                rowForAverageCalculate[FieldsNamesResources.GasPressureFieldName] = 0;
                            }

                            try
                            {
                                // рассчитываем среднюю температуру
                                rowForAverageCalculate[FieldsNamesResources.GasTemperatureFieldName] =
                                    rows.Where(r => r[FieldsNamesResources.GasTemperatureFieldName] != DBNull.Value)
                                    .Select(r => Convert.ToDecimal(r[FieldsNamesResources.GasTemperatureFieldName])).Average();
                            }
                            catch(InvalidOperationException)
                            {
                                rowForAverageCalculate[FieldsNamesResources.GasTemperatureFieldName] = 0;
                            }
                        }

                        // Конструирование новой таблицы SummaryData
                        var newSummaryDataTable = new DataTable();
                        newSummaryDataTable.TableName = DbTablePermanentResources.DefaultSummaryDataTableName;
                        var timeSummaryColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        var isValidRowStateSummaryColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));
                        var gasTimeNormalColumn = new DataColumn(FieldsNamesResources.GasTimeNormalFieldName, typeof(decimal));

                        newSummaryDataTable.Columns.AddRange(new DataColumn[] { timeSummaryColumn, isValidRowStateSummaryColumn,
                                                                                gasVolumeWorkSummaryColumn, gasVolumeStandardSummaryColumn,
                                                                                gasTimeNormalColumn });

                        var summaryStartDate = periodBegin.Date.AddHours(_gasHour);
                        var summaryEndDate = periodEnd.Date.AddHours(_gasHour);

                        var firstDataRow = ReportHelper.GetDataRowByDate(mainDataTable, summaryStartDate);
                        var lastDataRow = newMainDataTable.Rows.Cast<DataRow>().Last();

                        if (firstDataRow != null)
                        {
                            var firstSummaryRow = newSummaryDataTable.NewRow();
                            firstSummaryRow[DbTablePermanentResources.TimeColumn] = summaryStartDate;
                            firstSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = firstDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                            firstSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = firstDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                            firstSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = firstDataRow[FieldsNamesResources.GasVolumeStandardFieldName];
                            firstSummaryRow[FieldsNamesResources.GasTimeNormalFieldName] = firstDataRow[FieldsNamesResources.GasTimeNormalFieldName];
                            newSummaryDataTable.Rows.Add(firstSummaryRow);
                        }

                        if (lastDataRow != null)
                        {
                            var lastSummaryRow = newSummaryDataTable.NewRow();
                            lastSummaryRow[DbTablePermanentResources.TimeColumn] = summaryEndDate;
                            lastSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = lastDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                            lastSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = lastDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                            lastSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = lastDataRow[FieldsNamesResources.GasVolumeStandardFieldName];
                            lastSummaryRow[FieldsNamesResources.GasTimeNormalFieldName] = lastDataRow[FieldsNamesResources.GasTimeNormalFieldName];
                            newSummaryDataTable.Rows.Add(lastSummaryRow);
                        }


                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultSummaryDataTableName);

                        DataSource.Tables.Add(newMainDataTable);
                        DataSource.Tables.Add(newSummaryDataTable);
                    }
                }
            }

            // для часовой ведомости
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
                    var newPeriodBegin = periodBegin.AddHours(_gasHour).AddHours(-1);
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
                        var timeSupportColumn = new DataColumn(FieldsNamesResources.TimeStringFieldName, typeof(string));
                        var isValidRowStateColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkDiffFieldName, typeof(decimal));
                        var gasVolumeStandardDiffColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardDiffFieldName, typeof(decimal));
                        var gasVolumeWorkColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));
                        var gasPressureColumn = new DataColumn(FieldsNamesResources.GasPressureFieldName, typeof(decimal));
                        var gasTemperatureColumn = new DataColumn(FieldsNamesResources.GasTemperatureFieldName, typeof(decimal));
                        var timeNormalColumn = new DataColumn(FieldsNamesResources.GasTimeNormalFieldName, typeof(decimal));
                        var timeNormalDiffColumn = new DataColumn(FieldsNamesResources.GasTimeNormalDiffFieldName, typeof(decimal));
                        var timeDenialDiffColumn = new DataColumn(FieldsNamesResources.GasTimeDenialDiffFieldName, typeof(decimal));
                        var errorInfoColumn = new DataColumn(FieldsNamesResources.GasErrorInfoFieldName, typeof(string));


                        newMainDataTable.Columns.AddRange(new DataColumn[] { timeColumn, timeSupportColumn, isValidRowStateColumn, gasVolumeWorkDiffColumn,
                                                                             gasVolumeStandardDiffColumn, gasVolumeWorkColumn, gasVolumeStandardColumn,
                                                                             gasPressureColumn, gasTemperatureColumn, timeNormalColumn,
                                                                             timeNormalDiffColumn, timeDenialDiffColumn, errorInfoColumn });

                        // заполняем новую таблицу MainData значениями интеграторов рабочего и стандартного объема
                        for (var dt = newPeriodBegin; dt < newPeriodEnd; dt = dt.AddHours(1))
                        {
                            var row = newMainDataTable.NewRow();
                            var searchDate = dt.AddHours(1);
                            DataRow sourceRow = null;

                            sourceRow = ReportHelper.GetDataRowByDate(mainDataTable, searchDate);

                            row[DbTablePermanentResources.TimeColumn] = dt;

                            var eDate = dt.AddHours(1);
                            row[FieldsNamesResources.TimeStringFieldName] = string.Format(StringFormatResources.IrvisHourTimeString,
                                               dt.Day, dt.Month, dt.Hour, eDate.Day, eDate.Month, eDate.Hour);

                            if (sourceRow != null)
                            {
                                row[DbTablePermanentResources.IsValidRowStateColumn] = sourceRow[DbTablePermanentResources.IsValidRowStateColumn];
                                row[FieldsNamesResources.GasVolumeWorkFieldName] = sourceRow[FieldsNamesResources.GasVolumeWorkFieldName];
                                row[FieldsNamesResources.GasVolumeStandardFieldName] = sourceRow[FieldsNamesResources.GasVolumeStandardFieldName];
                                row[FieldsNamesResources.GasTimeNormalFieldName] = sourceRow[FieldsNamesResources.GasTimeNormalFieldName];
                            }

                            newMainDataTable.Rows.Add(row);
                        }

                        // вычисляем разницы для интеграторов и средние значения давления, температуры, времени наработки и времени простоя
                        for (var dt = newPeriodBegin.AddHours(1); dt <= newPeriodEnd.AddHours(-1); dt = dt.AddHours(1))
                        {
                            var previousDate = dt.AddHours(-1);
                            var calculatedRow = ReportHelper.GetDataRowByDate(newMainDataTable, dt);
                            var previousRow = ReportHelper.GetDataRowByDate(newMainDataTable, previousDate);

                            // рассчитываем Gas.Volume.Work.Diff
                            if (calculatedRow[FieldsNamesResources.GasVolumeWorkFieldName] == DBNull.Value || previousRow[FieldsNamesResources.GasVolumeWorkFieldName] == DBNull.Value)
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = DBNull.Value;
                            }
                            else
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeWorkDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasVolumeWorkFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasVolumeWorkFieldName]);
                            }

                            // рассчитываем Gas.Volume.Standard.Diff
                            if (calculatedRow[FieldsNamesResources.GasVolumeStandardFieldName] == DBNull.Value || previousRow[FieldsNamesResources.GasVolumeStandardFieldName] == DBNull.Value)
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = DBNull.Value;
                            }
                            else
                            {
                                calculatedRow[FieldsNamesResources.GasVolumeStandardDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasVolumeStandardFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasVolumeStandardFieldName]);
                            }

                            // рассчитываем Gas.Time.Normal.Diff и Gas.Time.Denial.Diff
                            if (calculatedRow[FieldsNamesResources.GasTimeNormalFieldName] == DBNull.Value || previousRow[FieldsNamesResources.GasTimeNormalFieldName] == DBNull.Value)
                            {
                                calculatedRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = DBNull.Value;
                                calculatedRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = DBNull.Value;
                            }
                            else
                            {
                                calculatedRow[FieldsNamesResources.GasTimeNormalDiffFieldName] = Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasTimeNormalFieldName]) - Convert.ToDecimal(previousRow[FieldsNamesResources.GasTimeNormalFieldName]);
                                calculatedRow[FieldsNamesResources.GasTimeDenialDiffFieldName] = 1 - Convert.ToDecimal(calculatedRow[FieldsNamesResources.GasTimeNormalDiffFieldName]);
                            }

                            // рассчитываем среднее давление и среднюю температуру
                            var rowForAverageCalculate = ReportHelper.GetDataRowByDate(mainDataTable, dt);
                           
                            if (rowForAverageCalculate != null)
                            {
                                calculatedRow[FieldsNamesResources.GasPressureFieldName] = rowForAverageCalculate[FieldsNamesResources.GasPressureFieldName];
                                calculatedRow[FieldsNamesResources.GasTemperatureFieldName] = rowForAverageCalculate[FieldsNamesResources.GasTemperatureFieldName];
                            }
                            else
                            {
                                calculatedRow[FieldsNamesResources.GasPressureFieldName] = DBNull.Value;
                                calculatedRow[FieldsNamesResources.GasTemperatureFieldName] = DBNull.Value;
                            }
                        }

                        // Конструирование новой таблицы SummaryData
                        var newSummaryDataTable = new DataTable();
                        newSummaryDataTable.TableName = DbTablePermanentResources.DefaultSummaryDataTableName;
                        var timeSummaryColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        var isValidRowStateSummaryColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));
                        var gasVolumeWorkSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeWorkFieldName, typeof(decimal));
                        var gasVolumeStandardSummaryColumn = new DataColumn(FieldsNamesResources.GasVolumeStandardFieldName, typeof(decimal));
                        var gasTimeNormalColumn = new DataColumn(FieldsNamesResources.GasTimeNormalFieldName, typeof(decimal));

                        newSummaryDataTable.Columns.AddRange(new DataColumn[] { timeSummaryColumn, isValidRowStateSummaryColumn,
                                                                                gasVolumeWorkSummaryColumn, gasVolumeStandardSummaryColumn,
                                                                                gasTimeNormalColumn });


                        // удаляем нулевую строку, т.к. она использовалась для расчета диференсов первой строки
                        var firstDataRow = newMainDataTable.Rows.Cast<DataRow>().First();
                        var lastDataRow = newMainDataTable.Rows.Cast<DataRow>().Where(p => p[FieldsNamesResources.GasVolumeWorkFieldName] != DBNull.Value).Last();

                        var firstSummaryRow = newSummaryDataTable.NewRow();
                        firstSummaryRow[DbTablePermanentResources.TimeColumn] = Convert.ToDateTime(firstDataRow[DbTablePermanentResources.TimeColumn]).AddHours(1);
                        firstSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = firstDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                        firstSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = firstDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                        firstSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = firstDataRow[FieldsNamesResources.GasVolumeStandardFieldName];
                        firstSummaryRow[FieldsNamesResources.GasTimeNormalFieldName] = firstDataRow[FieldsNamesResources.GasTimeNormalFieldName];

                        var lastSummaryRow = newSummaryDataTable.NewRow();
                        lastSummaryRow[DbTablePermanentResources.TimeColumn] = Convert.ToDateTime(lastDataRow[DbTablePermanentResources.TimeColumn]).AddHours(1);
                        lastSummaryRow[DbTablePermanentResources.IsValidRowStateColumn] = lastDataRow[DbTablePermanentResources.IsValidRowStateColumn];
                        lastSummaryRow[FieldsNamesResources.GasVolumeWorkFieldName] = lastDataRow[FieldsNamesResources.GasVolumeWorkFieldName];
                        lastSummaryRow[FieldsNamesResources.GasVolumeStandardFieldName] = lastDataRow[FieldsNamesResources.GasVolumeStandardFieldName];
                        lastSummaryRow[FieldsNamesResources.GasTimeNormalFieldName] = lastDataRow[FieldsNamesResources.GasTimeNormalFieldName];

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
            // добавляем договорные параметры прибора в свободные параметры отчета
            AddDeviceContractParameters();
        }

        private void AddDeviceContractParameters()
        {
            using (var context = new ApplicationDatabaseContext())
            {
                var measurementDeviceId = GetParameterValue<int>(DbTablePermanentResources.MeasurementDeviceIdColumn);
                var dataSet = context.ExecuteQuery(string.Format(StringFormatResources.CallGetAllDeviceTechnicalParametersSP, measurementDeviceId)); 

                if(dataSet.Tables.Count > 0)
                {
                    var table = dataSet.Tables[0];
                    
                    foreach(var row in table.Rows.Cast<DataRow>())
                    {
                        AddParameter<string>(Convert.ToString(row[DbTablePermanentResources.NameColumn]), row[DbTablePermanentResources.ValueColumn]);
                    }
                }
            }
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
                        correctedTime = date.AddHours(-_gasHour);
                        break;
                    }
                }
            }

            return correctedTime;
        }
    }
}
