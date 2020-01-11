using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class ElectroSysWorkingDayGraphPlugin : ReportPluginBase
    {
        public ElectroSysWorkingDayGraphPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {

        }

        public override void Execute()
        {
            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];

            var userNameRow = reportParameterTable.GetReportParameterRow(ReportPluginResources.UserName);
            var channelIdRow = reportParameterTable.GetReportParameterRow(ReportPluginResources.ChannelId);
            var periodRow = reportParameterTable.GetReportParameterRow(ReportPluginResources.Period);
            var maxHourRangeRow = reportParameterTable.GetReportParameterRow(ReportPluginResources.MaxHoursRange);
            var designFactorRow = reportParameterTable.GetReportParameterRow(ReportPluginResources.DesignFactor);

            if (userNameRow != null && channelIdRow != null && periodRow != null)
            {
                var userName = Convert.ToString(userNameRow[DbTablePermanentResources.ValueColumn]);
                var channelId = Convert.ToInt32(channelIdRow[DbTablePermanentResources.ValueColumn]);
                var period = Convert.ToDateTime(periodRow[DbTablePermanentResources.ValueColumn]);
                var endPeriod = period.AddHours(23);
                var maxHourRangeStr = Convert.ToString(maxHourRangeRow[DbTablePermanentResources.ValueColumn]);
                var designFactor = Convert.ToInt32(designFactorRow[DbTablePermanentResources.ValueColumn]);

                using (var context = new ApplicationDatabaseContext())
                {
                    // получаем скрипт вызова хранимки GetAccountingParamSheet
                    var getAccountingParamSheetSource = context.Sources.FirstOrDefault(p => p.Id == 10);

                    if (getAccountingParamSheetSource != null)
                    {
                        var periodBeginStr = period.GetDateStringInSqlStyle();
                        var periodEndStr = endPeriod.GetDateStringInSqlStyle();

                        var query = getAccountingParamSheetSource.Template
                            .Replace(ReportPluginResources.UserNameSubs, userName)
                            .Replace(ReportPluginResources.ChannelIdSubs, Convert.ToString(channelId))
                            .Replace(ReportPluginResources.PeriodBeginSubs, periodBeginStr)
                            .Replace(ReportPluginResources.PeriodEndSubs, periodEndStr)
                            .Replace(ReportPluginResources.IncludePeriodEndSubs, ReportPluginResources.OneDigit)
                            .Replace(ReportPluginResources.PeriodTypeIdSubs, ReportPluginResources.TwoDigit);

                        var dataSet = context.ExecuteQuery(query);
                        var sourceMainDataTable = dataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];

                        if (sourceMainDataTable.Rows.Count == 0)
                        {
                            DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName].Rows.Clear();
                            return;
                        }

                        decimal[] activePowerValues = new decimal[24];

                        // конструируем таблицу MainData с первым 12 часами активной мощности
                        var mainDataTable = ConstructMainDataTable();
                        var mainDataTableRow = mainDataTable.NewRow();

                        for (var hour = 0; hour <= 11; hour++)
                        {
                            var currentTime = period.AddHours(hour);

                            var rows = sourceMainDataTable.Select(string.Format(sourceMainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition2, currentTime));

                            if (rows != null && rows.Count() > 0)
                            {
                                var row = rows.First();
                                if (row[FieldsNamesResources.ElectroSysActivePowerPlusDiffFieldName] != DBNull.Value)
                                {
                                    activePowerValues[hour] = Convert.ToDecimal(row[FieldsNamesResources.ElectroSysActivePowerPlusDiffFieldName]) * designFactor;
                                }
                                else
                                {
                                    activePowerValues[hour] = 0;
                                }

                                mainDataTableRow[string.Format(StringFormatResources.Active, hour, hour + 1)] = activePowerValues[hour];
                            }
                        }
                        mainDataTable.Rows.Add(mainDataTableRow);

                        // конструируем таблицу ACTIVE_POWER_SECOND_DATA с остальными 12 часами активной мощности
                        var activePowerSecondDataTable = ConstructActivePowerSecondData();
                        var activePowerSecondDataTableRow = activePowerSecondDataTable.NewRow();

                        for (var hour = 12; hour <= 23; hour++)
                        {
                            var currentTime = period.AddHours(hour);

                            var rows = sourceMainDataTable.Select(string.Format(sourceMainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition2, currentTime));

                            if (rows != null && rows.Count() > 0)
                            {
                                var row = rows.First();
                                if (row[FieldsNamesResources.ElectroSysActivePowerPlusDiffFieldName] != DBNull.Value)
                                {
                                    activePowerValues[hour] = Convert.ToDecimal(row[FieldsNamesResources.ElectroSysActivePowerPlusDiffFieldName]) * designFactor;
                                }
                                else
                                {
                                    activePowerValues[hour] = 0;
                                }

                                activePowerSecondDataTableRow[string.Format(StringFormatResources.Active, hour, hour == 23 ? 0 : hour + 1)] = activePowerValues[hour];
                            }
                        }
                        activePowerSecondDataTable.Rows.Add(activePowerSecondDataTableRow);

                        // конструируем таблицу ACTIVE_POWER_SUMMARY_DATA
                        var activePowerSummaryDataTable = ConstructActivePowerSummaryData();

                        var activePowerSummaryRow = activePowerSummaryDataTable.NewRow();

                        var maxHourEnabledRange = GetEnabledMaxHoursRange(maxHourRangeStr);
                        var maxValueInfo = SearchMaxValue(activePowerValues, maxHourEnabledRange);

                        activePowerSummaryRow[ReportPluginResources.ActiveSum] = activePowerValues.Sum();
                        activePowerSummaryRow[ReportPluginResources.ActiveMax] = maxValueInfo.Item1;
                        activePowerSummaryRow[ReportPluginResources.MaxHour] = maxValueInfo.Item2;
                        activePowerSummaryRow[ReportPluginResources.ActiveAverage] = activePowerValues.Sum() / 24;

                        if (maxValueInfo.Item1 != 0)
                        {
                            activePowerSummaryRow[ReportPluginResources.ActiveKz] = activePowerValues.Sum() / 24 / maxValueInfo.Item1;
                        }
                        else
                        {
                            activePowerSummaryRow[ReportPluginResources.ActiveKz] = 0;
                        }

                        activePowerSummaryDataTable.Rows.Add(activePowerSummaryRow);

                        // конструируем таблицу REACTIVE_POWER_FIRST_DATA
                        var reactivePowerFirstDataTable = ConstructReactivePowerFirstData();
                        var reactivePowerFirstDataRow = reactivePowerFirstDataTable.NewRow();
                        // конструируем таблицу REACTIVE_POWER_SECOND_DATA
                        var reactivePowerSecondDataTable = ConstructReactivePowerSecondData();
                        var reactivePowerSecondDataRow = reactivePowerSecondDataTable.NewRow();

                        for (var hour = 0; hour <= 23; hour++)
                        {
                            var currentTime = period.AddHours(hour);

                            var rows = sourceMainDataTable.Select(string.Format(sourceMainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition2, currentTime));

                            if (rows != null && rows.Count() > 0)
                            {
                                var row = rows.First();
                                decimal value = 0;
                                if (row[FieldsNamesResources.ElectroSysReactivePowerPlusDiffFieldName] != DBNull.Value)
                                {
                                    value = Convert.ToDecimal(row[FieldsNamesResources.ElectroSysReactivePowerPlusDiffFieldName]) * designFactor;
                                }
                                else
                                {
                                    value = 0;
                                }

                                if (hour < 12)
                                {
                                    reactivePowerFirstDataRow[string.Format(StringFormatResources.Reactive, hour, hour + 1)] = value;
                                }
                                else
                                {
                                    reactivePowerSecondDataRow[string.Format(StringFormatResources.Reactive, hour, hour == 23 ? 0 : hour + 1)] = value;
                                }
                            }
                        }
                        reactivePowerFirstDataTable.Rows.Add(reactivePowerFirstDataRow);
                        reactivePowerSecondDataTable.Rows.Add(reactivePowerSecondDataRow);

                       
                        // подмена таблиц
                        var mainDataTableForRemove = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
                        var activePowerSecondDataTableForRemove = DataSource.Tables[ReportPluginResources.ActivePowerSecondData];
                        var activePowerSummaryDataTableForRemove = DataSource.Tables[ReportPluginResources.ActivePowerSummaryData];
                        var reactivePowerFirstDataTableForRemove = DataSource.Tables[ReportPluginResources.ReactivePowerFirstData];
                        var reactivePowerSecondDataTableForRemove = DataSource.Tables[ReportPluginResources.ReactivePowerSecondData];

                        DataSource.Tables.Remove(mainDataTableForRemove);
                        DataSource.Tables.Remove(activePowerSecondDataTableForRemove);
                        DataSource.Tables.Remove(activePowerSummaryDataTableForRemove);
                        DataSource.Tables.Remove(reactivePowerFirstDataTableForRemove);
                        DataSource.Tables.Remove(reactivePowerSecondDataTableForRemove);

                        DataSource.Tables.Add(mainDataTable);
                        DataSource.Tables.Add(activePowerSecondDataTable);
                        DataSource.Tables.Add(activePowerSummaryDataTable);
                        DataSource.Tables.Add(reactivePowerFirstDataTable);
                        DataSource.Tables.Add(reactivePowerSecondDataTable);
                    }
                }
            }
        }



        private bool[] GetEnabledMaxHoursRange(string maxHourRangeStr)
        {
            bool[] maxHoursRange = new bool[24];

            if (string.IsNullOrEmpty(maxHourRangeStr))
            {
                for(var i = 0; i < maxHoursRange.Length; i++)
                {
                    maxHoursRange[i] = true;
                }
            }
            else
            {
                var rangeParts = maxHourRangeStr.Split(',');

                foreach(var rangePart in rangeParts)
                {
                    var beginEnd = rangePart.Split('-');
                    if (beginEnd.Length == 2)
                    {
                        int begin = -1;
                        int end = -1;

                        Int32.TryParse(beginEnd[0], out begin);
                        Int32.TryParse(beginEnd[1], out end);
                        

                        if (begin <= end && begin != -1 && end != -1)
                        {
                            for (var i = begin; i <= end; i++)
                            {
                                maxHoursRange[i] = true;
                            }
                        }
                    }
                }
            }

            return maxHoursRange;
        }

        private Tuple<decimal, int> SearchMaxValue(decimal[] values, bool[] enabledPositions)
        {
            decimal max = 0;
            int maxPosition = 0;

            for(var i = 0; i <= 23; i++)
            {
                if (enabledPositions[i])
                {
                    if (max < values[i])
                    {
                        max = values[i];
                        maxPosition = i;
                    }
                }
            }

            return new Tuple<decimal, int>(max, maxPosition);
        }

        private DataTable ConstructMainDataTable()
        {
            // конструируем таблицу MainData с первым 12 часами активной мощности
            var mainDataTable = new DataTable(DbTablePermanentResources.DefaultMainDataTableName);

            for(int i = 0; i <= 11; i++)
            {
                mainDataTable.Columns.Add(new DataColumn(string.Format(StringFormatResources.Active, i, i + 1), typeof(decimal)));
            }

            return mainDataTable;
        }

        private DataTable ConstructActivePowerSecondData()
        {
            var activePowerSecondDataTable = new DataTable(ReportPluginResources.ActivePowerSecondData);

            for(int i = 12; i <= 23; i++)
            {
                activePowerSecondDataTable.Columns.Add(new DataColumn(string.Format(StringFormatResources.Active, i, i == 23 ? 0 : i + 1), typeof(decimal)));
            }
            return activePowerSecondDataTable;
        }

        private DataTable ConstructActivePowerSummaryData()
        {
            var activePowerSummaryDataTable = new DataTable(ReportPluginResources.ActivePowerSummaryData);

            activePowerSummaryDataTable.Columns.Add(new DataColumn(ReportPluginResources.ActiveSum, typeof(decimal)));
            activePowerSummaryDataTable.Columns.Add(new DataColumn(ReportPluginResources.ActiveMax, typeof(decimal)));
            activePowerSummaryDataTable.Columns.Add(new DataColumn(ReportPluginResources.MaxHour, typeof(int)));
            activePowerSummaryDataTable.Columns.Add(new DataColumn(ReportPluginResources.ActiveAverage, typeof(decimal)));
            activePowerSummaryDataTable.Columns.Add(new DataColumn(ReportPluginResources.ActiveKz, typeof(decimal)));

            return activePowerSummaryDataTable;
        }

        private DataTable ConstructReactivePowerFirstData()
        {
            var reactivePowerFirstDataTable = new DataTable(ReportPluginResources.ReactivePowerFirstData);

            for (int i = 0; i <= 11; i++)
            {
                reactivePowerFirstDataTable.Columns.Add(new DataColumn(string.Format(StringFormatResources.Reactive, i, i + 1), typeof(decimal)));
            }
            return reactivePowerFirstDataTable;
        }

        private DataTable ConstructReactivePowerSecondData()
        {
            var reactivePowerFirstDataTable = new DataTable(ReportPluginResources.ReactivePowerSecondData);

            for (int i = 12; i <= 23; i++)
            {
                reactivePowerFirstDataTable.Columns.Add(new DataColumn(string.Format(StringFormatResources.Reactive, i, i == 23 ? 0 : i + 1), typeof(decimal)));
            }
            return reactivePowerFirstDataTable;
        }
    }
}
