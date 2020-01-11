using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Km5ImpulseCwsPlugin : ReportPluginBase
    {
        public Km5ImpulseCwsPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {

        }

        public override void Execute()
        {
            var dynamicParametersTable = DataSource.Tables[DbTablePermanentResources.DefaultDynamicParametersTableName];

            var dynamicParameter = dynamicParametersTable.Rows.Cast<DataRow>().FirstOrDefault(row => Convert.ToInt32(row[DbTablePermanentResources.DynamicParameterIdColumn]) == 116);

            if (dynamicParameter != null)
            {
                string _numberDecimalSeparator = Thread.CurrentThread.CurrentCulture.NumberFormat.NumberDecimalSeparator;

                var stringStartValue = Convert.ToString(dynamicParameter[DbTablePermanentResources.ValueColumn]).Replace(ReportPluginResources.DotSymbol, _numberDecimalSeparator);
                var startValue = Convert.ToDecimal(stringStartValue);

                var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];

                foreach (DataRow row in summaryDataTable.Rows)
                {
                    if (row[FieldsNamesResources.CwsVolumeFieldName] != DBNull.Value)
                    {
                        row[FieldsNamesResources.CwsVolumeFieldName] = startValue + Convert.ToDecimal(row[FieldsNamesResources.CwsVolumeFieldName]);
                    }

                    if (row[FieldsNamesResources.CwsVolumeNextFieldName] != DBNull.Value)
                    {
                        row[FieldsNamesResources.CwsVolumeNextFieldName] = startValue + Convert.ToDecimal(row[FieldsNamesResources.CwsVolumeNextFieldName]);
                    }
                }
            }
        }
    }
}
