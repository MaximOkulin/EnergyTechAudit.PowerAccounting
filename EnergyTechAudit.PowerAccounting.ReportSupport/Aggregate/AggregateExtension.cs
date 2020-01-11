using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using FastReport;
using FastReport.Data;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Aggregate
{
    public struct ReportFieldInfo
    {
        public string Name { get; set; }

        public bool IntegrableValue { get; set; }
    }

    public static class AggregateExtension
    {
        /// <summary>
        /// Формирует разностные агрегаты по всем полям источника данных отчета 
        /// между первой и последней записями и заполняет предопределенные параметры отчета агрегатом  
        /// </summary>
        /// <param name="report">Экземляр отчета</param>
        /// <param name="dataSourceName">Имя источника данных отчета</param>
        public static void DifferenceLastFirstWithAddNewRow(this Report report, string dataSourceName)
        {
            var reportFieldDataSource = report.GetDataSource(DbTablePermanentResources.DefaultReportFieldInfoTableName) as TableDataSource;

            var tableDataSource = report.GetDataSource(dataSourceName) as TableDataSource;

            if (tableDataSource != null)
            {
                DataTable table = tableDataSource.Table;

                List<ReportFieldInfo> reportFieldInfoList;

                // формируем список доступных полей для отчета 
                // на основе полученной из источника базовой таблицы  с данными
                // или таблицы с именами полей отчета ReportField
                if (reportFieldDataSource != null)
                {
                    var reportFieldTable = reportFieldDataSource.Table;
                    reportFieldInfoList = reportFieldTable.AsEnumerable().Select(r => new ReportFieldInfo
                    {
                        Name = (string) r["Name"],
                        IntegrableValue = (bool) r["IntegrableValue"]
                    })
                    .Where(r=> r.IntegrableValue)
                    .ToList();
                }
                else
                {
                    reportFieldInfoList = table.Columns.Cast<DataColumn>().Select(col => new ReportFieldInfo
                    {
                        Name = col.ColumnName,
                        IntegrableValue = true
                    }).ToList();
                }

                Type[] supportTypes =
                {
                    typeof (decimal), typeof (int), typeof (double)
                };


                tableDataSource.Init();
                var columns = table.Columns.Cast<DataColumn>().ToArray();

                var first = table.Rows.Cast<DataRow>().FirstOrDefault();
                var last = table.Rows.Cast<DataRow>().LastOrDefault();

                var hasEstimatedReset = false;
                

                if (first != null && last != null)
                {
                    foreach (ReportFieldInfo reportFieldInfo in reportFieldInfoList)
                    {
                        var col = columns.FirstOrDefault(c => c.ColumnName == reportFieldInfo.Name);

                        // поле должно соответствовать supportTypes и допускать агрегацию
                        if (col != null && supportTypes.Contains(col.DataType) && reportFieldInfo.IntegrableValue)
                        {
                            object diff = null;
                            try
                            {
                                if (first[col] != DBNull.Value && last[col] != DBNull.Value)
                                {
                                    diff = Math.Abs(Convert.ToDecimal(last[col])) 
                                        - Math.Abs(Convert.ToDecimal(first[col]));
                                    
                                    // встретили отрицательную разницу
                                    if (!hasEstimatedReset)
                                    {
                                        hasEstimatedReset = Convert.ToDecimal(diff) < -0.001M;                                        
                                    }
                                }
                            }
                            catch
                            {
                                diff = null;
                            }

                            report.SetParameterValue
                                (
                                    string.Format("{0}_{1}_TotalDiffLastFirst", dataSourceName, col.ColumnName)
                                        .Replace(".", "_"),
                                    Convert.ToDecimal(diff)
                                );
                        }
                    }                    
                }

                report.SetParameterValue("HasEstimatedReset", hasEstimatedReset);
            }
        }

        /// <summary>
        /// Всего записей по источнику данных 
        /// </summary>
        /// <param name="report">Экземпляр отчета</param>
        /// <param name="dataSourceName">Имя источника данных</param>
        /// <returns></returns>
        public static int TotalCountByDataSource(this Report report, string dataSourceName)
        {
            var dataSource = report.GetDataSource(dataSourceName);

            if (dataSource != null)
            {
                return dataSource.RowCount;
            }

            return default;
        }
    }
}
