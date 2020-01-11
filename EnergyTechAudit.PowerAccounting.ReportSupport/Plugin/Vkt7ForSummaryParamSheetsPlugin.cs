using EnergyTechAudit.PowerAccounting.Common.Resources;
using System;
using System.Data;
using System.Linq;
using System.Collections.Generic;
using EnergyTechAudit.PowerAccounting.DataAccess;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Vkt7ForSummaryParamSheetsPlugin : ReportPluginBase
    {
        public Vkt7ForSummaryParamSheetsPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {

        }

        public override void Execute()
        {
            var reportParameterTable = DataSource.Tables[DbTablePermanentResources.DefaultReportParameterTableName];
            var periodBeginRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodBeginColumn);
            var periodEndRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.PeriodEndColumn);
            var resourceSystemTypeCodeRow = reportParameterTable.GetReportParameterRow(DbTablePermanentResources.ResourceSystemTypeCodeColumn);

            var periodBegin = Convert.ToDateTime(periodBeginRow[DbTablePermanentResources.ValueColumn]).Date;
            var periodEnd = Convert.ToDateTime(periodEndRow[DbTablePermanentResources.ValueColumn]).Date;
            var resourceSystemTypeCode = Convert.ToString(resourceSystemTypeCodeRow[DbTablePermanentResources.ValueColumn]);

            if (periodEnd > periodBegin)
            {
                periodEnd = periodEnd.AddDays(-1);
            }

            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];

            using (var context = new ApplicationDatabaseContext())
            {
                using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                {
                    try
                    {
                        foreach (DataRow row in mainDataTable.Rows)
                        {
                            int deviceModelId = Convert.ToInt32(row[DbTablePermanentResources.DeviceModelIdColumn]);

                            // если это ВКТ
                            if (deviceModelId == 1)
                            {
                                int channelTemplateId = Convert.ToInt32(row[DbTablePermanentResources.ChannelTemplateIdColumn]);
                                int measurementDeviceId = Convert.ToInt32(row[DbTablePermanentResources.MeasurementDeviceIdColumn]);

                                if (resourceSystemTypeCode.Equals(ReportPluginResources.HeatSysResourceSystemTypeCode, StringComparison.Ordinal))
                                {
                                    // скидываем в ноль Daily
                                    row[FieldsNamesResources.HeatSysMassSupplyPipeDailyFieldName] = 0;
                                    row[FieldsNamesResources.HeatSysMassReturnPipeDailyFieldName] = 0;
                                    row[FieldsNamesResources.HeatSysHeatTotalDailyFieldName] = 0;
                                    row[FieldsNamesResources.HeatSysTimeNormalDailyFieldName] = 0;                                    

                                    var paramMapDeviceParams = context.ParameterLinkDeviceParameters.Where(p => p.ChannelTemplateId == channelTemplateId && p.PeriodTypeId == 3 &&
                                    p.ParameterId >= 4002 && p.ParameterId <= 4005).ToList();

                                    // рассчитываем HeatSys.Mass.SuppyPipe.Last.Daily
                                    var supplyPipeDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 4002).DeviceParameterId;
                                    row[FieldsNamesResources.HeatSysMassSupplyPipeLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == supplyPipeDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();

                                    // рассчитываем HeatSys.Mass.ReturnPipe.Last.Daily
                                    var returnPipeDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 4003).DeviceParameterId;
                                    row[FieldsNamesResources.HeatSysMassReturnPipeLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == returnPipeDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();

                                    // рассчитываем HeatSys.Heat.Total.Last.Daily
                                    var heatTotalDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 4004).DeviceParameterId;
                                    row[FieldsNamesResources.HeatSysHeatTotalLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == heatTotalDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();

                                    // рассчитываем HeatSys.Time.Normal.LastDaily
                                    var timeNormalDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 4005).DeviceParameterId;
                                    row[FieldsNamesResources.HeatSysTimeNormalLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == timeNormalDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();
                                }
                                else if (resourceSystemTypeCode.Equals(ReportPluginResources.HwsResourceSystemTypeCode, StringComparison.Ordinal))
                                {
                                    // скидываем в ноль Daily
                                    row[FieldsNamesResources.HwsMassSupplyPipeDailyFieldName] = 0;
                                    row[FieldsNamesResources.HwsMassReturnPipeDailyFieldName] = 0;
                                    row[FieldsNamesResources.HwsHeatTotalDailyFieldName] = 0;
                                    row[FieldsNamesResources.HwsTimeNormalDailyFieldName] = 0;

                                    var paramMapDeviceParams = context.ParameterLinkDeviceParameters.Where(p => p.ChannelTemplateId == channelTemplateId && p.PeriodTypeId == 3 &&
                                    (p.ParameterId == 11431 || p.ParameterId == 11432 || p.ParameterId == 11433 || p.ParameterId == 11435)).ToList();

                                    // рассчитываем Hws.Mass.SuppyPipe.Last.Daily
                                    var supplyPipeDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 11431).DeviceParameterId;
                                    row[FieldsNamesResources.HwsMassSupplyPipeLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == supplyPipeDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();                                     

                                    // рассчитываем Hws.Mass.ReturnPipe.Last.Daily
                                    var returnPipeDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 11432).DeviceParameterId;
                                    row[FieldsNamesResources.HwsMassReturnPipeLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == returnPipeDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();

                                    // рассчитываем Hws.Heat.Total.Last.Daily
                                    var heatTotalDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 11433).DeviceParameterId;
                                    row[FieldsNamesResources.HwsHeatTotalLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == heatTotalDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();

                                    // рассчитываем Hws.Time.Normal.LastDaily
                                    var timeNormalDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 11435).DeviceParameterId;
                                    row[FieldsNamesResources.HwsTimeNormalLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == timeNormalDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();
                                }
                                else if (resourceSystemTypeCode.Equals(ReportPluginResources.CwsResourceSystemTypeCode, StringComparison.Ordinal))
                                {
                                    // скидываем в ноль Daily
                                    row[FieldsNamesResources.CwsVolumeDailyFieldName] = 0;
                                    row[FieldsNamesResources.CwsTimeNormalDailyFieldName] = 0;

                                    var paramMapDeviceParams = context.ParameterLinkDeviceParameters.Where(p => p.ChannelTemplateId == channelTemplateId && p.PeriodTypeId == 3 &&
                                    (p.ParameterId == 20100 || p.ParameterId == 1445)).ToList();

                                    // рассчитываем Cws.Volume.Last.Daily
                                    var volumeDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 1445).DeviceParameterId;
                                    row[FieldsNamesResources.CwsVolumeLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == volumeDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();

                                    // рассчитываем Cws.Time.Normal.Last.Daily
                                    var timeNormalDeviceParameterId = paramMapDeviceParams.First(p => p.ParameterId == 20100).DeviceParameterId;
                                    row[FieldsNamesResources.CwsTimeNormalLastDailyFieldName] = context.Archives.Where(p => p.PeriodTypeId == 3 && p.MeasurementDeviceId == measurementDeviceId &&
                                                                                                       p.Time >= periodBegin && p.Time <= periodEnd && p.DeviceParameterId == timeNormalDeviceParameterId)
                                                                                                       .Select(p => p.Value).DefaultIfEmpty(0).Sum();                                   
                                }
                            }
                        }
                        tran.Commit();
                    }
                    catch
                    {
                        tran.Rollback();
                    }
                }
            }
        }
    }
}
