using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Data;
using EnergyTechAudit.PowerAccounting.ReportSupport.Helpers;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class ElectroSysPowerProfilePlugin : ReportPluginBase
    {
        private readonly DateTime _periodBegin;
        private readonly DateTime _periodEnd;
        private readonly bool _includePeriodEnd;

        public ElectroSysPowerProfilePlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodBeginParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodBeginColumn));
            if (periodBeginParam != null)
            {
                _periodBegin = Convert.ToDateTime(periodBeginParam.Value);
            }

            var periodEndParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodEndColumn));
            if (periodEndParam != null)
            {
                _periodEnd = Convert.ToDateTime(periodEndParam.Value);
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

            foreach (DateTime dt in dates)
            {
                DataRow aPlusRow = null;
                DataRow aMinusRow = null;
                DataRow rPlusRow = null;
                DataRow rMinusRow = null;

                aPlusRow = newMainDataTable.NewRow();
                aMinusRow = newMainDataTable.NewRow();
                rPlusRow = newMainDataTable.NewRow();
                rMinusRow = newMainDataTable.NewRow();


                aPlusRow[DbTablePermanentResources.TimeColumn] = dt;
                aPlusRow[ReportPluginResources.Type] = ReportPluginResources.APlus;
                aMinusRow[ReportPluginResources.Type] = ReportPluginResources.AMinus;
                rPlusRow[ReportPluginResources.Type] = ReportPluginResources.RPlus;
                rMinusRow[ReportPluginResources.Type] = ReportPluginResources.RMinus;


                List<float> aPlusValues = new List<float>();
                List<float> aMinusValues = new List<float>();
                List<float> rPlusValues = new List<float>();
                List<float> rMinusValues = new List<float>();

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

                        var aPlusValue = Convert.ToSingle(row[FieldsNamesResources.ElectroSysActivePowerPlusDiffFieldName]);
                        if (aPlusValue >= 0)
                        {
                            aPlusValues.Add(aPlusValue);
                            aPlusRow[columnV] = aPlusValue;
                        }

                        var aMinusValue = Convert.ToSingle(row[FieldsNamesResources.ElectroSysActivePowerMinusDiffFieldName]);
                        if (aMinusValue >= 0)
                        {
                            aMinusValues.Add(aMinusValue);
                            aMinusRow[columnV] = aMinusValue;
                        }

                        var rPlusValue = Convert.ToSingle(row[FieldsNamesResources.ElectroSysReactivePowerPlusDiffFieldName]);
                        if (rPlusValue >= 0)
                        {
                            rPlusValues.Add(rPlusValue);
                            rPlusRow[columnV] = rPlusValue;
                        }

                        var rMinusValue = Convert.ToSingle(row[FieldsNamesResources.ElectroSysReactivePowerMinusDiffFieldName]);
                        if (rMinusValue >= 0)
                        {
                            rMinusValues.Add(rMinusValue);
                            rMinusRow[columnV] = rMinusValue;
                        }
                    }
                }

                if (aPlusValues.Any())
                {
                    aPlusRow[ReportPluginResources.Sum] = aPlusValues.Sum();
                    aMinusRow[ReportPluginResources.Sum] = aMinusValues.Sum();
                    rPlusRow[ReportPluginResources.Sum] = rPlusValues.Sum();
                    rMinusRow[ReportPluginResources.Sum] = rMinusValues.Sum();


                    aPlusRow[ReportPluginResources.Max] = aPlusValues.Max();
                    aMinusRow[ReportPluginResources.Max] = aMinusValues.Max();
                    rPlusRow[ReportPluginResources.Max] = rPlusValues.Max();
                    rMinusRow[ReportPluginResources.Max] = rMinusValues.Max();
                }

                newMainDataTable.Rows.Add(aPlusRow);
                newMainDataTable.Rows.Add(aMinusRow);
                newMainDataTable.Rows.Add(rPlusRow);
                newMainDataTable.Rows.Add(rMinusRow);
            }

            DataSource.Tables.Remove(mainDataTable);
            DataSource.Tables.Add(newMainDataTable);
        }       
    }
}
