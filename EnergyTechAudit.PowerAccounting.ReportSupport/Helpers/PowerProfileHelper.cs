using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Helpers
{
    internal class PowerProfileHelper
    {
        public static DataTable ConstructNewMainTable()
        {
            var dataTable = new DataTable(DbTablePermanentResources.DefaultMainDataTableName);

            var colDefinitions = new Dictionary<string, Type>
            {
                {DbTablePermanentResources.TimeColumn, typeof(DateTime)},
                {ReportPluginResources.Type, typeof(string)},
                {ReportPluginResources.Sum, typeof(float)},
                {ReportPluginResources.Max, typeof(float)},
                {ReportInternalColumnNameResources.V0_1, typeof(float)},
                {ReportInternalColumnNameResources.V1_2, typeof(float)},
                {ReportInternalColumnNameResources.V2_3, typeof(float)},
                {ReportInternalColumnNameResources.V3_4, typeof(float)},
                {ReportInternalColumnNameResources.V4_5, typeof(float)},
                {ReportInternalColumnNameResources.V5_6, typeof(float)},
                {ReportInternalColumnNameResources.V6_7, typeof(float)},
                {ReportInternalColumnNameResources.V7_8, typeof(float)},
                {ReportInternalColumnNameResources.V8_9, typeof(float)},
                {ReportInternalColumnNameResources.V9_10, typeof(float)},
                {ReportInternalColumnNameResources.V10_11, typeof(float)},
                {ReportInternalColumnNameResources.V11_12, typeof(float)},
                {ReportInternalColumnNameResources.V12_13, typeof(float)},
                {ReportInternalColumnNameResources.V13_14, typeof(float)},
                {ReportInternalColumnNameResources.V14_15, typeof(float)},
                {ReportInternalColumnNameResources.V15_16, typeof(float)},
                {ReportInternalColumnNameResources.V16_17, typeof(float)},
                {ReportInternalColumnNameResources.V17_18, typeof(float)},
                {ReportInternalColumnNameResources.V18_19, typeof(float)},
                {ReportInternalColumnNameResources.V19_20, typeof(float)},
                {ReportInternalColumnNameResources.V20_21, typeof(float)},
                {ReportInternalColumnNameResources.V21_22, typeof(float)},
                {ReportInternalColumnNameResources.V22_23, typeof(float)},
                {ReportInternalColumnNameResources.V23_0, typeof(float)}
            };

            foreach (KeyValuePair<string, Type> colDef in colDefinitions)
            {
                dataTable.Columns.Add(new DataColumn(colDef.Key, colDef.Value));
            }

            return dataTable;
        }
    }
}
