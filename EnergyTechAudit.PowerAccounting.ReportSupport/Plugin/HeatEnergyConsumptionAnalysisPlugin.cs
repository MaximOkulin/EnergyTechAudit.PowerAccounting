using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.DataAccess.Helper;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using EnergyTechAudit.PowerAccounting.ReportEngine;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;
using Newtonsoft.Json;
using FastReport.Data;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class HeatEnergyConsumptionAnalysisPlugin : ReportPluginBase
    {
        private const int TotalHoursPerDay = 24;

        public struct Point<T>
        {
            public T X { get; set; }
            public T Y { get; set; }
        }

        private static class LinearApproximator
        {            
            public static Point<decimal> Calculate(Point<decimal> p1, Point<decimal> p2, Point<decimal> p)
            {
                var k = (p2.Y - p1.Y) / (p2.X - p1.X);
                var absDelta = Math.Abs(p1.X - p.X);
                return new Point<decimal> {X = p.X, Y = k * absDelta + p1.Y};
            }
        }
        
        private static class ReportDatasourceExtractor
        {
            public static DataTable Extract(MetaObjectEx metaObjectEx, string name)
            {
                using (var report = new FastReport.Report())
                {
                    var reportEnginePipeline = new ReportEnginePipeline();
                    reportEnginePipeline.Execute(report, metaObjectEx);
                    var dataSource = (TableDataSource)report.GetDataSource(name);
                    return dataSource.Table;
                }
            }
        }

        public MetaObjectEx ParentMetaObjectEx { get; set; }        

        private readonly DataTable _heatCurveFollowTable;
        private readonly DataTable _mainDataTable;

        public HeatEnergyConsumptionAnalysisPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
             _heatCurveFollowTable = new DataTable("HeatCurveFollow")
            {
                Columns =
                {
                    new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime)),
                    new DataColumn("AverageOutdoorTemperature", typeof(decimal)), // Temper.OutdoorAir.Avg
                    new DataColumn("AverageSupplyTemperature", typeof(decimal)),
                    new DataColumn("AverageReturnTemperature", typeof(decimal)),
                    new DataColumn("CalcSupplyTemperature", typeof(decimal)),
                    new DataColumn("CalcReturnTemperature", typeof(decimal)),

                    new DataColumn("SupplyTemperature.Diff", typeof(decimal)),
                    new DataColumn("ReturnTemperature.Diff", typeof(decimal))
                }
            };

            _mainDataTable = new DataTable("MainData")
            {
                Columns =
                {
                    new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime)),
                    new DataColumn("HeatSys.Heat.Total.Standard", typeof(decimal)),
                    new DataColumn("HeatSys.Heat.Total.Actual", typeof(decimal))
                }
            };
        }

        public override void Execute()
        {
            var useDeductionHwsHeat = GetParameterValue<bool>("UseDeductionHwsHeat") || 
                                      GetParameterValue<bool>("DefaultUseDeductionHwsHeat");

            var generativeMetaObjectId = ParentMetaObjectEx.ParametricDialog.TryGetDescriptorValue<int>(DbTablePermanentResources.MetaObjectIdColumn);

            DataTable generativeMainDataTable = null, hwsGenerativeMainDataTable = null;
            Channel hwsChannel = null;

            using (var context = new ApplicationDatabaseContext())
            {
                var generativeMetaObject = context.Set<MetaObject>().Find(generativeMetaObjectId);
                var generativeMetaObjectEx = JsonConvert.DeserializeObject<MetaObjectEx>
                (
                    JsonConvert.SerializeObject(generativeMetaObject)
                );

                generativeMetaObjectEx.ParametricDialog = ParentMetaObjectEx.ParametricDialog;
                generativeMetaObjectEx.IsPrepared = true;
                generativeMetaObjectEx.Context = context;
                generativeMetaObjectEx.ParametricDialog.ReassignDescriptorValue("HeatSysChannelId", DbTablePermanentResources.ChannelIdColumn);

                generativeMainDataTable = ReportDatasourceExtractor.Extract
                (
                    generativeMetaObjectEx, DbTablePermanentResources.DefaultMainDataTableName
                );

                // Apply the rules of accounting for Hws
                if (useDeductionHwsHeat)
                {
                    //  Let's take first hws-channel
                    hwsChannel = DataSource.Tables.Cast<DataTable>()
                        .First(dt => dt.TableName == "HwsChannel")
                        .AsEnumerable()
                        .Select(hws => new Channel
                        {
                            Id = hws.Field<int>(DbTablePermanentResources.IdColumn),
                            Description = hws.Field<string>(DbTablePermanentResources.DescriptionColumn),
                            ResourceSystemTypeId = hws.Field<int>(DbTablePermanentResources.ResourceSystemTypeIdColumn),
                            ResourceSubsystemTypeId =
                                hws.Field<int>(DbTablePermanentResources.ResourceSubsystemTypeIdColumn),
                        })
                        .FirstOrDefault();

                    if (hwsChannel != null)
                    {
                        generativeMetaObjectEx.ParametricDialog
                            .TrySetDescriptorValue<int>(DbTablePermanentResources.ChannelIdColumn, hwsChannel.Id);

                        hwsGenerativeMainDataTable = ReportDatasourceExtractor.Extract
                        (
                            generativeMetaObjectEx, DbTablePermanentResources.DefaultMainDataTableName
                        );
                    }
                }
            }

            var meteoDataTable = DataSource.Tables.Cast<DataTable>().First(dt => dt.TableName == "MeteoData");
            var heatCurvesDataTable = DataSource.Tables.Cast<DataTable>().First(dt => dt.TableName == "HeatCurvesData");

            var calcIndoorAirTemperature = GetParameterValue<int>("CalcIndoorAirTemperature");
            var minimalTemperature = GetParameterValue<int>("MinimalTemperature");
            var hourlyConsumptionHeat = GetParameterValue<decimal>("HourlyConsumptionHeat");

            void GetMainData(DataRow row)
            {
                var time = row.Field<DateTime>(DbTablePermanentResources.TimeColumn);
               
                var generativeMainDataTableRow = generativeMainDataTable?.AsEnumerable()
                    .FirstOrDefault(r => r.Field<DateTime>(DbTablePermanentResources.TimeColumn) == time);
                
                if (generativeMainDataTableRow != null)
                {
                    var averageOutdoorTemperature = row.Field<decimal>("AverageTemperature");

                    var heatSysHeatTotalStandard = hourlyConsumptionHeat * TotalHoursPerDay *
                                (
                                    (calcIndoorAirTemperature - averageOutdoorTemperature) /
                                    (calcIndoorAirTemperature - minimalTemperature)
                                );
                    
                    var hwsHeatTotal = default(decimal); // quantity of heat for Hws needs 
                    var isRescuedMainDataRow = true;

                    if (useDeductionHwsHeat && hwsChannel != null)
                    {
                        var hwsGenerativeMainDataTableRow = hwsGenerativeMainDataTable?.AsEnumerable()
                            .FirstOrDefault(r => r.Field<DateTime>(DbTablePermanentResources.TimeColumn) == time);
                        if (hwsGenerativeMainDataTableRow != null)
                        {                           
                            // Hws
                            if (hwsChannel.ResourceSystemTypeId == 3) 
                            {
                                hwsHeatTotal = hwsGenerativeMainDataTableRow.Field<decimal>(FieldsNamesResources.HwsHeatTotalDiffFieldName);
                            }
                            // CwsForHws
                            else if (hwsChannel.ResourceSystemTypeId == 2 && hwsChannel.ResourceSubsystemTypeId == 6)
                            {
                                var cwsForHwsHeatingFactor = GetParameterValue<decimal>("CwsForHwsHeatingFactor");
                                hwsHeatTotal = hwsGenerativeMainDataTableRow.Field<decimal>(FieldsNamesResources.CwsVolumeDiffFieldName) * cwsForHwsHeatingFactor;
                            }
                        }
                        else
                        {
                            // hws data not found in UseDeductionHwsHeat-mode so we prevent insert maindata table row
                            isRescuedMainDataRow = false;
                        }
                    }

                    var heatSysHeatTotalActualRaw = generativeMainDataTableRow.Field<decimal?>(FieldsNamesResources.HeatSysHeatTotalDiffFieldName);

                    if (isRescuedMainDataRow && heatSysHeatTotalActualRaw.HasValue)
                    {
                        var heatSysHeatTotalActual = heatSysHeatTotalActualRaw.Value - hwsHeatTotal;

                        _mainDataTable.Rows.Add(new object[]
                        {
                            time,
                            heatSysHeatTotalStandard,
                            heatSysHeatTotalActual
                        });
                    }
                }                
            }

            void GetHeatCurveFollow(DataRow row)
            {
                var time = row.Field<DateTime>(DbTablePermanentResources.TimeColumn);
                var averageTemperature = row.Field<decimal>("AverageTemperature");
                var lowBound = Math.Floor(averageTemperature);
                var highBound = Math.Ceiling(averageTemperature);

                var heatCurvesPoints = heatCurvesDataTable.Rows.Cast<DataRow>()
                    .Where
                    (
                        h =>
                        {
                            var outdoorTemperature = h.Field<decimal>("Temper.OutdoorAir");
                            return outdoorTemperature == lowBound || outdoorTemperature == highBound;
                        }
                    ).Select(h => new
                    {
                        OutdoorTemperature = h.Field<decimal>("Temper.OutdoorAir"), 
                        HeatCurveSupplyPipe = h.Field<decimal>("Organization.HeatCurveSupplyPipe"),
                        HeatCurveReturnPipe = h.Field<decimal>("Organization.HeatCurveReturnPipe")
                    })
                    .ToList();

                var lowPoint = heatCurvesPoints.First(p => p.OutdoorTemperature == lowBound);
                var highPoint = heatCurvesPoints.First(p => p.OutdoorTemperature == highBound);

               
                var supplyPipeLinePoint = LinearApproximator.Calculate
                (
                    new Point<decimal> {X = lowBound, Y = lowPoint.HeatCurveSupplyPipe},
                    new Point<decimal> {X = highBound, Y = highPoint.HeatCurveSupplyPipe},
                    new Point<decimal> {X = averageTemperature, Y = default}
                );
                var returnPipeLinePoint = LinearApproximator.Calculate
                (
                    new Point<decimal> {X = lowBound, Y = lowPoint.HeatCurveReturnPipe },
                    new Point<decimal> {X = highBound, Y = highPoint.HeatCurveReturnPipe },
                    new Point<decimal> {X = averageTemperature, Y = default}
                );
                
                var generativeMainDataTableRow = generativeMainDataTable?.AsEnumerable()
                    .FirstOrDefault(r => r.Field<DateTime>(DbTablePermanentResources.TimeColumn) == time);

                var heatCurveFollowTableRow = _heatCurveFollowTable.Rows.Add(new object[]
                    {
                        time,
                        averageTemperature,
                        generativeMainDataTableRow != null
                            ? generativeMainDataTableRow[FieldsNamesResources.HeatSysTemperSupplyPipeFieldName]
                            : DBNull.Value,
                        generativeMainDataTableRow != null
                            ? generativeMainDataTableRow[FieldsNamesResources.HeatSysTemperReturnPipeFieldName]
                            : DBNull.Value,

                        supplyPipeLinePoint.Y,                       
                        returnPipeLinePoint.Y,
                       
                        DBNull.Value,
                        DBNull.Value
                    });

                if (!DBNull.Value.Equals(heatCurveFollowTableRow["AverageSupplyTemperature"]))
                {
                    heatCurveFollowTableRow["SupplyTemperature.Diff"] =
                        heatCurveFollowTableRow.Field<decimal>("AverageSupplyTemperature") -
                        heatCurveFollowTableRow.Field<decimal>("CalcSupplyTemperature");                    
                }
                if (!DBNull.Value.Equals(heatCurveFollowTableRow["AverageReturnTemperature"]))
                {
                    heatCurveFollowTableRow["ReturnTemperature.Diff"] =
                        heatCurveFollowTableRow.Field<decimal>("AverageReturnTemperature") -
                        heatCurveFollowTableRow.Field<decimal>("CalcReturnTemperature");
                }
            }

            meteoDataTable.Rows.Cast<DataRow>().ToList()
                .ForEach(row =>
                {
                    GetHeatCurveFollow(row);
                    GetMainData(row);
                });

            var returnTemperatureDiffAbsMax = decimal.MaxValue;
            var supplyTemperatureDiffAbsMax = decimal.MaxValue;

            if (_heatCurveFollowTable.Rows.Cast<DataRow>().Any(r => r.Field<decimal?>("ReturnTemperature.Diff").HasValue))
            {
                returnTemperatureDiffAbsMax = _heatCurveFollowTable.Rows.Cast<DataRow>()
                    .Where(r => r.Field<decimal?>("ReturnTemperature.Diff").HasValue)
                    .Max(r => Math.Abs(r.Field<decimal>("ReturnTemperature.Diff")));
            }

            if (_heatCurveFollowTable.Rows.Cast<DataRow>()
                .Any(r => r.Field<decimal?>("SupplyTemperature.Diff").HasValue))
            {
                supplyTemperatureDiffAbsMax = _heatCurveFollowTable.Rows.Cast<DataRow>()
                    .Where(r => r.Field<decimal?>("SupplyTemperature.Diff").HasValue)
                    .Max(r => Math.Abs(r.Field<decimal>("SupplyTemperature.Diff")));
            }

            AddParameter<decimal>("SupplyTemperature.Diff.AbsMax", supplyTemperatureDiffAbsMax);
            AddParameter<decimal>("ReturnTemperature.Diff.AbsMax", returnTemperatureDiffAbsMax);

            var qFactTotal = generativeMainDataTable.AsEnumerable().Cast<DataRow>()
                .Sum(r => r.Field<decimal?>("HeatSys.Heat.Total.Diff") ?? default);

            var averageOutdoorTemperatureTotal = default(decimal);

            if (meteoDataTable.AsEnumerable().Cast<DataRow>().Any())
            {
                averageOutdoorTemperatureTotal = meteoDataTable.AsEnumerable().Cast<DataRow>()
                    .Average(r => r.Field<decimal>("AverageTemperature"));
            }

            var totalHours = generativeMainDataTable.Rows.Count * TotalHoursPerDay;
            var hourlyConsumptionHeatFact = default(decimal);

            if (totalHours > default(int))
            {
                hourlyConsumptionHeatFact = (qFactTotal / totalHours) *
                                            (
                                                (calcIndoorAirTemperature - minimalTemperature) /
                                                (calcIndoorAirTemperature - averageOutdoorTemperatureTotal)
                                            );
            }

            AddParameter<decimal>("HourlyConsumptionHeatFact", hourlyConsumptionHeatFact);

            DataSource.Tables.Add(_heatCurveFollowTable);
            DataSource.Tables.Add(_mainDataTable);

            _mainDataTable.DeepTableCopy("MainDataForChart");
            _heatCurveFollowTable.DeepTableCopy("HeatCurveFollowForChart");
            
            var resultSetNameTable = DataSource.Tables["ResultSetName"];            
            resultSetNameTable.Rows.Add(new object[] {6, "HeatCurveFollow" });
            resultSetNameTable.Rows.Add(new object[] {7, "HeatCurveFollowForChart" });            
        }
    }
}
