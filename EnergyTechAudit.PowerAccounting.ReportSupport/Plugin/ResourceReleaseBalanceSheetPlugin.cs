using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.Infrastructure.Helpers;
using EnergyTechAudit.PowerAccounting.ReportEngine;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;
using FastReport.Data;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class ResourceReleaseBalanceSheetPlugin : ReportPluginBase
    {
        public MetaObjectEx ParentMetaObjectEx { get; set; }

        public ResourceReleaseBalanceSheetPlugin(object dataSource, IEnumerable<object> parameters) : base(dataSource,
            parameters)
        {
        }

        private void AggregateBalance(MetaObjectEx generativeMetaObjectEx, string tableName, string colName)
        {
            var table = DataSource.Tables[tableName];

            table.Columns.Add(new DataColumn(DbTableResultsetResources.ResourceBalanceValueColumn, typeof(decimal)));

            var reportEnginePipeline = new ReportEnginePipeline();

            foreach (DataRow row in table.Rows)
            {
                // по конвенции об именах сопоставляем значения из таблицы-источника и описателями параметрика
                foreach (DataColumn column in DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName].Columns)
                {
                    var currentDescriptor = generativeMetaObjectEx
                        .ParametricDialog
                        .Descriptors
                        .Find(d => d.Name.Equals(column.ColumnName, StringComparison.InvariantCultureIgnoreCase));

                    if (currentDescriptor != null)
                    {
                        currentDescriptor.Value = Convert.ToString(row[column.ColumnName]);
                    }
                }
                using (var report = new FastReport.Report())
                {
                    try
                    {
                        reportEnginePipeline.Execute(report, generativeMetaObjectEx);

                        var reportDatasource = report.GetDataSource(DbTablePermanentResources.DefaultMainDataTableName);

                        var currentDataTable = ((TableDataSource)reportDatasource).Table;

                        var balanceValue = currentDataTable
                            .AsEnumerable()
                            .Cast<DataRow>()
                            .Where(r => Convert.ToBoolean(r[DbTablePermanentResources.IsValidRowStateColumn]))
                            .Sum(r => Convert.ToDecimal(r[colName]));
                        
                        row[DbTableResultsetResources.ResourceBalanceValueColumn] = balanceValue;

                    }
                    catch (Exception )
                    {
                        row.Delete();
                    }
                }
            }
            table.AcceptChanges();
        }

        private class ResourceTypeToAggregatingColumn
        {
            public int ResourceTypeId { get; set; }           
            public string AggregatingColumnName { get; set; }        
        }

        public override void Execute()
        {
            var generativeMetaObjectIdDescriptor =
                ParentMetaObjectEx.ParametricDialog.Descriptors
                    .Find(d => d.Name.Equals(DbTablePermanentResources.MetaObjectIdColumn, StringComparison.InvariantCultureIgnoreCase));

            var aggregatingColumnDictionaryDescriptor =
                ParentMetaObjectEx.ParametricDialog.Descriptors
                    .Find(d => d.Name.Equals(ParametricParameterResources.AggregatingColumnDictionary, StringComparison.InvariantCultureIgnoreCase));

            var resourceSystemTypeIdDescriptor =
                ParentMetaObjectEx.ParametricDialog.Descriptors
                    .Find
                    (
                        d => d.Name.ContainsOf(DbTablePermanentResources.ResourceSystemTypeIdColumn, StringComparison.InvariantCultureIgnoreCase)
                             && Convert.ToInt32(d.Value) != default
                    );

            var aggregatingColumnDictionary = JsonConvert.DeserializeObject<List<ResourceTypeToAggregatingColumn>>            
            (
                aggregatingColumnDictionaryDescriptor.Value                
            );

            if (generativeMetaObjectIdDescriptor != null)
            {

                using (var context = new ApplicationDatabaseContext())
                {
                    var generativeMetaObject = context.Set<MetaObject>()
                        .Find(Convert.ToInt32(generativeMetaObjectIdDescriptor.Value));

                    var generativeMetaObjectEx = JsonConvert.DeserializeObject<MetaObjectEx>
                    (
                        JsonConvert.SerializeObject(generativeMetaObject)
                    );

                    generativeMetaObjectEx.ParametricDialog = ParentMetaObjectEx.ParametricDialog;
                    generativeMetaObjectEx.IsPrepared = true;
                    generativeMetaObjectEx.Context = context;

                    var aggregatingСolumnName = aggregatingColumnDictionary
                        .Find(colName => colName.ResourceTypeId == Convert.ToInt32(resourceSystemTypeIdDescriptor.Value));
                    
                    new List<string>
                        {
                            DbTablePermanentResources.DefaultMainDataTableName,
                            DbTablePermanentResources.DefaultSummaryDataTableName
                        }
                        .ForEach(tableName =>
                        {
                            AggregateBalance
                            (
                                generativeMetaObjectEx,
                                tableName,
                                aggregatingСolumnName.AggregatingColumnName
                            );
                        });
                }
            }
        }
    }
}