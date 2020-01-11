using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class VolumeDifferencePlugin : ReportPluginBase
    {
        public VolumeDifferencePlugin(object dataSource, IEnumerable<object> parameters) : base(dataSource, parameters)
        {
            Parameters.First(p => p.FullName.Equals(DbTablePermanentResources.ResourceSubsystemTypeDescriptionColumn)).Value = ReportPluginResources.SewageV1V2Description;
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];

            if (mainDataTable.Rows.Count > 0)
            {
                foreach (DataRow row in mainDataTable.Rows)
                {
                    if (row[FieldsNamesResources.CwsVolumeFieldName] != DBNull.Value &&
                        row[FieldsNamesResources.CwsVolumePipe2FieldName] != DBNull.Value)
                    {
                        row[FieldsNamesResources.CwsVolumeFieldName] = Convert.ToDecimal(row[FieldsNamesResources.CwsVolumeFieldName]) -
                            Convert.ToDecimal(row[FieldsNamesResources.CwsVolumePipe2FieldName]);
                    }

                    if (row[FieldsNamesResources.CwsVolumeNextFieldName] != DBNull.Value &&
                        row[FieldsNamesResources.CwsVolumePipe2NextFieldName] != DBNull.Value)
                    {
                        row[FieldsNamesResources.CwsVolumeNextFieldName] = Convert.ToDecimal(row[FieldsNamesResources.CwsVolumeNextFieldName]) -
                            Convert.ToDecimal(row[FieldsNamesResources.CwsVolumePipe2NextFieldName]);
                    }

                    if (row[FieldsNamesResources.CwsVolumeDiffFieldName] != DBNull.Value &&
                        row[FieldsNamesResources.CwsVolumePipe2DiffFieldName] != DBNull.Value)
                    {
                        row[FieldsNamesResources.CwsVolumeDiffFieldName] = Convert.ToDecimal(row[FieldsNamesResources.CwsVolumeDiffFieldName]) -
                            Convert.ToDecimal(row[FieldsNamesResources.CwsVolumePipe2DiffFieldName]);
                    }

                    if (row[FieldsNamesResources.CwsVolumeDiffNextFieldName] != DBNull.Value &&
                        row[FieldsNamesResources.CwsVolumePipe2DiffNextFieldName] != DBNull.Value)
                    {
                        row[FieldsNamesResources.CwsVolumeDiffNextFieldName] = Convert.ToDecimal(row[FieldsNamesResources.CwsVolumeDiffNextFieldName]) -
                            Convert.ToDecimal(row[FieldsNamesResources.CwsVolumePipe2DiffNextFieldName]);
                    }
                }
            }
        }

    }
}
