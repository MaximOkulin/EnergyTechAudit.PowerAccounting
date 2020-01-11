using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class ElectroSysCalculateWithDesignFactorPlugin : ReportPluginBase
    {
        public ElectroSysCalculateWithDesignFactorPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            
        }

        public override void Execute()
        {
            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];

            var designFactorRow = reportParameterTable.Rows.Cast<DataRow>().FirstOrDefault(row => Convert.ToString(row[DbTablePermanentResources.NameColumn]).Equals("DesignFactor", StringComparison.Ordinal));

            if (designFactorRow != null)
            {
                var coef = Convert.ToDecimal(designFactorRow[DbTablePermanentResources.ValueColumn]);

                var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
                Calculate(mainDataTable, coef);

                var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];
                Calculate(summaryDataTable, coef);
            }
        }

        private void Calculate(DataTable dataTable, decimal coef)
        {
            foreach (DataColumn column in dataTable.Columns)
            {
                if (!column.ColumnName.Equals(DbTablePermanentResources.TimeColumn, StringComparison.Ordinal) &&
                    !column.ColumnName.Equals(DbTablePermanentResources.IsValidRowStateColumn, StringComparison.Ordinal) &&
                    !column.ColumnName.Equals(FieldsNamesResources.ElectroSysTimeNormalFieldName, StringComparison.Ordinal) &&
                    !column.ColumnName.Equals(FieldsNamesResources.ElectroSysTimeNormalNextFieldName, StringComparison.Ordinal) &&
                    !column.ColumnName.Equals(FieldsNamesResources.ElectroSysErrorInfoFieldName, StringComparison.Ordinal))
                {
                    if (column.ColumnName.Contains("Diff"))
                    {
                        foreach (DataRow row in dataTable.Rows)
                        {
                            var cell = row[column.ColumnName];
                            if (cell != DBNull.Value)
                            {
                                row.SetField(column, coef * Convert.ToDecimal(cell));
                            }
                        }
                    }
                }
            }
        }
    }
}
