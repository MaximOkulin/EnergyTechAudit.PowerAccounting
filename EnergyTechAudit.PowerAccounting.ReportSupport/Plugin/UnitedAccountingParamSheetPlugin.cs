using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.ReportEngine;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;
using FastReport.Data;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class UnitedAccountingParamSheetPlugin : ReportPluginBase
    {

        public MetaObjectEx ParentMetaObjectEx { get; set; }

        public UnitedAccountingParamSheetPlugin(object dataSource, IEnumerable<object> parameters) : base(dataSource, parameters) { }


        public DataTable FullOuterJoinDataTableByTime(DataTable leftTable, DataTable rightTable)
        {
            var keyColumnName = DbTablePermanentResources.TimeColumn;


            var fullOuterTable = new DataTable();

            foreach (DataColumn col in leftTable.Columns)
            {
                if (fullOuterTable.Columns[col.ColumnName] == null)
                {
                    fullOuterTable.Columns.Add(col.ColumnName, col.DataType);
                }
            }
            foreach (DataColumn col in rightTable.Columns)
            {
                if (fullOuterTable.Columns[col.ColumnName] == null)
                {
                    fullOuterTable.Columns.Add(col.ColumnName, col.DataType);
                }
            }

            leftTable
                .AsEnumerable()
                .Select(r => r.Field<DateTime>(DbTablePermanentResources.TimeColumn))
                .Union
                (
                    rightTable.AsEnumerable()
                        .Select(r => r.Field<DateTime>(keyColumnName))
                )
                .ToList()

                .ForEach(key /*Time*/ =>
                {
                    var leftTableRow = leftTable.AsEnumerable().FirstOrDefault(r => r.Field<DateTime>(keyColumnName) == key);
                    var rightTableRow = rightTable.AsEnumerable().FirstOrDefault(r => r.Field<DateTime>(keyColumnName) == key);

                    var fullOuterTableRow = fullOuterTable.NewRow();

                    if (leftTableRow != null)
                    {
                        foreach (DataColumn leftTableCol in leftTable.Columns)
                        {
                            fullOuterTableRow[leftTableCol.ColumnName] = leftTableRow[leftTableCol.ColumnName];
                        }
                    }

                    if (rightTableRow != null)
                    {
                        foreach (DataColumn rightTableCol in rightTable.Columns)
                        {
                            fullOuterTableRow[rightTableCol.ColumnName] = rightTableRow[rightTableCol.ColumnName];
                        }
                    }

                    fullOuterTableRow[keyColumnName] = key;
                    fullOuterTable.Rows.Add(fullOuterTableRow);
                });

            return fullOuterTable;
        }

        public override void Execute()
        {
            var keyColumnName = DbTablePermanentResources.TimeColumn;

            var regEx = new Regex("\\.");

            var generativeMetaObjectIdDescriptor =
                ParentMetaObjectEx.ParametricDialog.Descriptors
                    .Find(d => d.Name.Equals(DbTablePermanentResources.MetaObjectIdColumn, StringComparison.InvariantCultureIgnoreCase));

            var pbDesc = ParentMetaObjectEx
                .ParametricDialog
                .Descriptors.Find(d => d.Name.Equals(DbTablePermanentResources.PeriodBeginColumn, StringComparison.InvariantCultureIgnoreCase));

            var peDesc = ParentMetaObjectEx
                .ParametricDialog
                .Descriptors.Find(d => d.Name.Equals(DbTablePermanentResources.PeriodEndColumn, StringComparison.InvariantCultureIgnoreCase));

            var pbDescriptorDefaultValue = pbDesc.Value;
            var peDescriptorDefaultValue = peDesc.Value;

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
                    
                    DataTable dataTableCollector = null;

                    var reportEnginePipeline = new ReportEnginePipeline();

                    foreach (DataRow row in DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName].Rows)
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

                        var resourceSubsystemTypeCode = Convert.ToString(row[DbTablePermanentResources.ResourceSubsystemTypeCodeColumn]);

                        var columnNameMutator =
                            $".{Convert.ToString(row[DbTablePermanentResources.ResourceSubsystemTypeCodeColumn])}.";

                        var isStubChannel = row.Field<bool>("IsStubChannel");
                        var stubChannelPeriodDateDescriptorValue =  DateTime.Today.AddDays(1).ToString(/*CultureInfo.InvariantCulture*/);

                        pbDesc.Value = isStubChannel ? stubChannelPeriodDateDescriptorValue : pbDescriptorDefaultValue;
                        peDesc.Value = isStubChannel ? stubChannelPeriodDateDescriptorValue : peDescriptorDefaultValue;
                                                
                        // объект отчета используется как контейнер для подготовленных данных 
                        using (var report = new FastReport.Report())
                        {
                            DataTable currentMainDataTable = null;

                            if(!isStubChannel)
                            {
                                reportEnginePipeline.Execute(report, generativeMetaObjectEx);

                                var dataSource = report.GetDataSource(DbTablePermanentResources.DefaultMainDataTableName);

                                currentMainDataTable = ((TableDataSource)dataSource).Table;
                            }
                            else
                            {                                          
                                var dataSet = context.ExecuteQuery
                                    (
                                        string.Format
                                        (
                                            string.Join
                                            (
                                                StringCharSet.Comma, 
                                                ParentMetaObjectEx.Source.Template, 
                                                "@isStubMode = 1,@resourceSubsystemTypeCode = '{0}'"
                                            ),
                                            resourceSubsystemTypeCode
                                        )
                                    );
                                currentMainDataTable = dataSet.Tables[default(int)].Copy();
                            }

                            foreach (DataColumn currentMainDataTableColumn in currentMainDataTable.Columns)
                            {
                                if (currentMainDataTableColumn.ColumnName != keyColumnName)
                                {
                                    currentMainDataTableColumn.ColumnName =
                                        regEx.Replace(currentMainDataTableColumn.ColumnName, columnNameMutator, 1);
                                }
                            }
                                                        
                            var isValidRowStateColumn = currentMainDataTable.Columns[DbTablePermanentResources.IsValidRowStateColumn];
                            if (isValidRowStateColumn != null)
                            {
                                isValidRowStateColumn.ColumnName =
                                    string.Format
                                    (
                                        "{0}.{1}.{2}", 
                                        Convert.ToString(row[DbTablePermanentResources.ResourceSystemTypeCodeColumn]), 
                                        Convert.ToString(row[DbTablePermanentResources.ResourceSubsystemTypeCodeColumn]), 
                                        DbTablePermanentResources.IsValidRowStateColumn                                       
                                    );
                            }

                            dataTableCollector = dataTableCollector == null
                                ? currentMainDataTable
                                : FullOuterJoinDataTableByTime(dataTableCollector, currentMainDataTable);
                            
                        }
                    }
                    
                    if (dataTableCollector != null)
                    {
                        DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
                        dataTableCollector.TableName = DbTablePermanentResources.DefaultMainDataTableName;
                        DataSource.Tables.Add(dataTableCollector);
                    }
                }
            }
        }
    }
}