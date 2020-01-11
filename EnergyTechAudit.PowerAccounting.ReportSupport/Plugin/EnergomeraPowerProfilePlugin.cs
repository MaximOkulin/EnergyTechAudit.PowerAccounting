using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Data;
using EnergyTechAudit.PowerAccounting.ReportSupport.Helpers;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class EnergomeraPowerProfilePlugin : ReportPluginBase
    {
        private readonly DateTime _periodBegin;
        private readonly DateTime _periodEnd;
        private readonly bool _includePeriodEnd;
        private readonly int _measurementDeviceId;

        public EnergomeraPowerProfilePlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            
            var periodBeginParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodBeginColumn, StringComparison.Ordinal));

            if (periodBeginParam != null)
            {
                _periodBegin = Convert.ToDateTime(periodBeginParam.Value);
                _periodBegin = _periodBegin.Date;
            }

            var periodEndParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodEndColumn, StringComparison.Ordinal));

            if (periodEndParam != null)
            {
                _periodEnd = Convert.ToDateTime(periodEndParam.Value);
                _periodEnd = _periodEnd.Date;
            }

            var includePeriodEndParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.IncludePeriodEndColumn));
            if (includePeriodEndParam != null)
            {
                _includePeriodEnd = Convert.ToBoolean(includePeriodEndParam.Value);
            }

            var measurementDeviceIdParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.MeasurementDeviceIdColumn));
            if (measurementDeviceIdParam != null)
            {
                _measurementDeviceId = Convert.ToInt32(measurementDeviceIdParam.Value);
            }
        }

        private int InitCoef()
        {
            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];

            var designFactorRow = reportParameterTable.Rows.Cast<DataRow>().FirstOrDefault(row => Convert.ToString(row[DbTablePermanentResources.NameColumn]).Equals("DesignFactor", StringComparison.Ordinal));

            if (designFactorRow != null)
            {
                return Convert.ToInt32(designFactorRow[DbTablePermanentResources.ValueColumn]);
            }

            return 1;
        }

        public override void Execute()
        {
            int coef = InitCoef();

            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            List<DateTime> dates = new List<DateTime>();

            for (var dt = _periodBegin; dt <= _periodEnd; dt = dt.AddDays(1))
            {
                dates.Add(dt);
            }

            if (!_includePeriodEnd)
            {
                dates.Remove(_periodEnd);
            }

            var newMainDataTable = PowerProfileHelper.ConstructNewMainTable();

            // указатель, что присутствует строка с неполным набором часовых профилей
            // и её не надо включать в итоговую таблицу
            bool hasIncompleteLastRow = false;

            foreach (DateTime dt in dates)
            {
                DataRow aPlusRow = null;


                aPlusRow = newMainDataTable.NewRow();

                aPlusRow[DbTablePermanentResources.TimeColumn] = dt;
                aPlusRow[ReportPluginResources.Type] = ReportPluginResources.APlus;

                List<float> aPlusValues = new List<float>();


                for (int hour = 0; hour <= 23; hour++)
                {
                    var searchDate = new DateTime(dt.Year, dt.Month, dt.Day, hour, 0, 0);
                    var row = mainDataTable.Select(string.Format(mainDataTable.Locale, StringFormatResources.SelectByTimeColumnCondition, searchDate,
                        DbTablePermanentResources.TimeColumn)).FirstOrDefault();

                    var hour2 = hour + 1;
                    if (hour2 == 24) hour2 = 0;

                    if (row != null)
                    {
                        var columnV = string.Format(StringFormatResources.V, hour, hour2);

                        var aPlusValue = Convert.ToSingle(row[FieldsNamesResources.ElectroSysActivePowerPlusDiffFieldName]) * coef;
                        if (aPlusValue >= 0)
                        {
                            aPlusValues.Add(aPlusValue);
                            aPlusRow[columnV] = aPlusValue;
                        }
                    }
                }

                if (aPlusValues.Any())
                {
                    aPlusRow[ReportPluginResources.Sum] = aPlusValues.Sum();
                    aPlusRow[ReportPluginResources.Max] = aPlusValues.Max();

                }

                if (!(dt == _periodEnd && _includePeriodEnd && aPlusValues.Count() != 24))
                {
                    newMainDataTable.Rows.Add(aPlusRow);
                }
                else
                {
                    hasIncompleteLastRow = true;
                }
            }

            DataSource.Tables.Remove(mainDataTable);
            DataSource.Tables.Add(newMainDataTable);

            // формирование таблицы итогов
            var newSummaryDataTable = ConstructNewSummaryDataTable();

            var startDate = dates.Min();
            var endDate = hasIncompleteLastRow ? dates.Max() : dates.Max().AddDays(1);

           
            using (var context = new ApplicationDatabaseContext())
            {
                using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                {
                    try
                    {
                        var archives = context.Set<Archive>().Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == _measurementDeviceId && 
                            p.DeviceParameterId == 10964 && p.Time >= startDate && p.Time <= endDate).ToList();
                        var startArchiveValue = archives.FirstOrDefault(p => p.Time == startDate);
                        var endArchiveValue = archives.FirstOrDefault(p => p.Time == endDate);

                        if (startArchiveValue != null)
                        {
                            var row = newSummaryDataTable.NewRow();
                            row[DbTablePermanentResources.TimeColumn] = startDate;
                            row[FieldsNamesResources.ElectroSysActivePowerPlusSumFieldName] = Convert.ToDecimal(startArchiveValue.Value) * coef;
                            newSummaryDataTable.Rows.Add(row);
                        }
                        if (endArchiveValue != null)
                        {
                            var row = newSummaryDataTable.NewRow();
                            row[DbTablePermanentResources.TimeColumn] = endDate.AddSeconds(-1);
                            row[FieldsNamesResources.ElectroSysActivePowerPlusSumFieldName] = Convert.ToDecimal(endArchiveValue.Value) * coef;
                            newSummaryDataTable.Rows.Add(row);
                        }
                        tran.Commit();
                    }
                    catch(Exception /*ex*/)
                    {
                        tran.Rollback();
                    }
                }
            }
            
            var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];
            DataSource.Tables.Remove(summaryDataTable);
            DataSource.Tables.Add(newSummaryDataTable);

            // подмуживание в таблицу ReportFieldInfo
            var reportFieldInfoDataTable =  DataSource.Tables[DbTablePermanentResources.DefaultReportFieldInfoTableName];
            var fieldInfoRow = reportFieldInfoDataTable.NewRow();
            fieldInfoRow[ReportPluginResources.Name] = FieldsNamesResources.ElectroSysActivePowerPlusSumFieldName;
            fieldInfoRow[ReportPluginResources.IntegrableValue] = true;
            reportFieldInfoDataTable.Rows.Add(fieldInfoRow);
        }

        private DataTable ConstructNewSummaryDataTable()
        {
            var dataTable = new DataTable(DbTablePermanentResources.DefaultSummaryDataTableName);

            var colDefinitions = new Dictionary<string, Type>
            {
                {DbTablePermanentResources.TimeColumn, typeof(DateTime)},
                {FieldsNamesResources.ElectroSysActivePowerPlusSumFieldName, typeof(decimal) }
            };

            foreach (KeyValuePair<string, Type> colDef in colDefinitions)
            {
                dataTable.Columns.Add(new DataColumn(colDef.Key, colDef.Value));
            }

            return dataTable;
        }
    }
}
