using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.ReportSupport.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Vkt7SummaryDataPlugin : ReportPluginBase
    {
        private CommonHelper _commonHelper;
        public Vkt7SummaryDataPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            _commonHelper = new CommonHelper(DataSource, Parameters);
        }

        public override void Execute()
        {
            var summaryParametersInfo = _commonHelper.GetSummaryParametersInfo();

            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            var firstMainDataTableRow = mainDataTable.Rows.Cast<DataRow>().FirstOrDefault();

            var measurementDeviceId = _commonHelper.GetMeasurementDeviceId();
            if (firstMainDataTableRow != null)
            {
                var time = Convert.ToDateTime(firstMainDataTableRow[DbTablePermanentResources.TimeColumn]);

                var borderTimeToSearchFinal = time.AddMonths(-2);
                var sumDeviceParamIdToSearchFinal = summaryParametersInfo.First().SumDeviceParameterId;
                var finalArchivesTimes = new List<DateTime>();

                using (var context = new ApplicationDatabaseContext())
                {
                    using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                    {
                        try
                        {
                            finalArchivesTimes = context.Set<Archive>().Where(p => p.PeriodTypeId == 6 && p.MeasurementDeviceId == measurementDeviceId &&
                            p.DeviceParameterId == sumDeviceParamIdToSearchFinal && p.Time >= borderTimeToSearchFinal && p.Time < time).OrderByDescending(p => p.Time)
                            .Select(p => p.Time).ToList();

                            tran.Commit();
                        }
                        catch
                        {
                            tran.Rollback();
                        }
                    }
                }

                // конструируем новую SummaryDataTable
                var newSummaryDataTable = new DataTable();
                newSummaryDataTable.TableName = DbTablePermanentResources.DefaultSummaryDataTableName;
                var timeSummaryColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                var isValidRowStateSummaryColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));

                newSummaryDataTable.Columns.AddRange(new DataColumn[] { timeSummaryColumn, isValidRowStateSummaryColumn });

                foreach (var summaryParameterInfo in summaryParametersInfo)
                {
                    newSummaryDataTable.Columns.Add(new DataColumn(summaryParameterInfo.SumName, typeof(Decimal)));
                }

                var firstRow = newSummaryDataTable.NewRow();
                firstRow[DbTablePermanentResources.TimeColumn] = time;

                // рассчитываем интеграторы на первую дату
                var finalArchiveTime = finalArchivesTimes.FirstOrDefault();

                var periodTypeId = _commonHelper.GetPeriodTypeId();
                if (finalArchivesTimes != null)
                {

                    using (var context = new ApplicationDatabaseContext())
                    {
                        using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                        {
                            try
                            {
                                foreach (var summaryParameterInfo in summaryParametersInfo)
                                {
                                    var value = ((IObjectContextAdapter)context)
                                               .ObjectContext
                                               .ExecuteStoreQuery<decimal?>(
                                                   ReportPluginResources.CalculateVkt7IntegratorAfterFinalDate,
                                                   new object[]
                                                   {
                                    new SqlParameter(ReportPluginResources.MeasurementDeviceSqlParameter, measurementDeviceId) { SqlDbType = SqlDbType.Int},
                                    new SqlParameter(ReportPluginResources.PeriodTypeIdSqlParameter,  periodTypeId) { SqlDbType = SqlDbType.Int},
                                    new SqlParameter(ReportPluginResources.DiffParameterIdSqlParameter, summaryParameterInfo.DiffDeviceParameterId) {SqlDbType = SqlDbType.Int},
                                    new SqlParameter(ReportPluginResources.SumParameterIdSqlParameter, summaryParameterInfo.SumDeviceParameterId) {SqlDbType = SqlDbType.Int},
                                    new SqlParameter(ReportPluginResources.DateSqlParameter, time) { SqlDbType = SqlDbType.DateTime },
                                    new SqlParameter(ReportPluginResources.FinalDateSqlParameter, finalArchiveTime) { SqlDbType = SqlDbType.DateTime },
                                                   }).FirstOrDefault();

                                    if (value != null)
                                    {
                                        firstRow[summaryParameterInfo.SumName] = value.Value;
                                    }
                                    else
                                    {
                                        firstRow[summaryParameterInfo.SumName] = DBNull.Value;
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                var e = ex;
                                tran.Rollback();
                            }
                        }
                    }
                }

                newSummaryDataTable.Rows.Add(firstRow);

                var secondRow = newSummaryDataTable.NewRow();
                var lastMainDataTableRow = mainDataTable.Rows.Cast<DataRow>().Last();
                secondRow[DbTablePermanentResources.TimeColumn] = periodTypeId == 3 ? Convert.ToDateTime(lastMainDataTableRow[DbTablePermanentResources.TimeColumn]).AddDays(1) :
                                                                                       Convert.ToDateTime(lastMainDataTableRow[DbTablePermanentResources.TimeColumn]).AddHours(1);

                foreach (var summaryParameterInfo in summaryParametersInfo)
                {
                    var sumByMainDataTableRows = mainDataTable.Rows.Cast<DataRow>().Where(r => r[summaryParameterInfo.DiffName] != DBNull.Value)
                                                 .Sum(p => Convert.ToDecimal(p[summaryParameterInfo.DiffName]));

                    if (firstRow[summaryParameterInfo.SumName] == DBNull.Value)
                    {
                        firstRow[summaryParameterInfo.SumName] = 0;
                    }

                    secondRow[summaryParameterInfo.SumName] = Convert.ToDecimal(firstRow[summaryParameterInfo.SumName]) + sumByMainDataTableRows;
                }
                newSummaryDataTable.Rows.Add(secondRow);

                DataSource.Tables.Remove(DbTablePermanentResources.DefaultSummaryDataTableName);
                DataSource.Tables.Add(newSummaryDataTable);
            }
        }        
    }
}
