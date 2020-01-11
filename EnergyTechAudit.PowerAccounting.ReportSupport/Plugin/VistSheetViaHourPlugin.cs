using EnergyTechAudit.PowerAccounting.Common.Resources;
using EnergyTechAudit.PowerAccounting.DataAccess;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.ReportSupport.Helpers;
using EnergyTechAudit.PowerAccounting.ReportSupport.Types;
using EnergyTechAudit.PowerAccounting.Web.Models.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class VistSheetViaHourPlugin : ReportPluginBase
    {
        public MetaObjectEx ParentMetaObjectEx { get; set; }
        public string VistResources { get; private set; }
        private CommonHelper _commonHelper;

        public VistSheetViaHourPlugin(object dataSource, IEnumerable<object> parameters)
            : base(dataSource, parameters)
        {
            _commonHelper = new CommonHelper(DataSource, Parameters);
        }

        public override void Execute()
        {
            int periodTypeId = _commonHelper.GetPeriodTypeId();

            DateTime periodBegin = _commonHelper.GetPeriod(DbTablePermanentResources.PeriodBeginColumn).Date;
            DateTime periodEnd = _commonHelper.GetPeriod(DbTablePermanentResources.PeriodEndColumn).Date;
            bool includePeriodEnd = _commonHelper.GetBoolValue(DbTablePermanentResources.IncludePeriodEndColumn);
            if ((!includePeriodEnd && (periodTypeId == (int)PeriodType.Day) && (periodBegin != periodEnd)))
            {
                periodEnd = periodEnd.AddDays(-1.0);
            }
            else if (((!includePeriodEnd || (periodTypeId != 2)) || !(periodBegin == periodEnd)) &&
                   ((periodTypeId == (int)PeriodType.Hour) && (periodBegin == periodEnd)))
            {
                periodEnd = periodBegin.AddDays(1.0);
            }

            DateTime nativePeriodBegin = periodBegin;
            DateTime nativePeriodEnd = periodEnd;

            DateTime newPeriodBegin = periodBegin;
            DateTime newPeriodEnd = periodEnd;

            string newPeriodBeginStr = periodBegin.GetDateStringInSqlStyle();
            string newPeriodEndStr = (periodTypeId == (int)PeriodType.Day) ? periodEnd.AddDays(1.0).GetDateStringInSqlStyle() : periodEnd.GetDateStringInSqlStyle();

            newPeriodBeginStr = string.Format(StringFormatResources.PeriodBeginSql, newPeriodBeginStr);
            newPeriodEndStr = string.Format(StringFormatResources.PeriodEndSql, newPeriodEndStr);

            // корректируем исходный запрос: делаем перезапрос по часовым записям с обновленным датами начала и конца
            var query = ParentMetaObjectEx.Source.Template;

            var regexPeriodBegin = new Regex(@"periodBegin = '\d{8} \d{2}:\d{2}:\d{2}'");
            var regexPeriodEnd = new Regex(@"periodEnd = '\d{8} \d{2}:\d{2}:\d{2}'");
            query = regexPeriodBegin.Replace(query, newPeriodBeginStr);
            query = regexPeriodEnd.Replace(query, newPeriodEndStr);
            query = query.Replace(ReportPluginResources.PeriodTypeIdEqual3, ReportPluginResources.PeriodTypeIdEqual2);
            DataSet dataSet = null;

            using (ApplicationDatabaseContext context = new ApplicationDatabaseContext())
            {
                dataSet = context.ExecuteQuery(query);
            }
            DataTable mainDataTable = dataSet.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            dataSet.Tables.Remove(mainDataTable);

            if (mainDataTable.Rows.Count != 0)
            {
                periodBegin = CorrectBeginPeriod(mainDataTable);
                periodEnd = CorrectEndPeriod(mainDataTable);
                if (periodEnd > nativePeriodEnd)
                {
                    periodEnd = nativePeriodEnd;
                }

                DataTable newMainDataTable = new DataTable();
                switch (periodTypeId)
                {
                    // для суточной ведомости конструируем новую таблицу с данными и рассчитываем суммы и средние на базе часовых
                    case 3:

                        newMainDataTable = new DataTable(DbTablePermanentResources.DefaultMainDataTableName);
                        _commonHelper.SetErrorInfoColumn(newMainDataTable);

                        DataColumn timeColumn = new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime));
                        DataColumn isValidRowStateColumn = new DataColumn(DbTablePermanentResources.IsValidRowStateColumn, typeof(bool));

                        DataColumn[] columns = new DataColumn[] { timeColumn, isValidRowStateColumn };

                        newMainDataTable.Columns.AddRange(columns);
                        DataTable reportFieldInfoTable = dataSet.Tables[DbTablePermanentResources.DefaultReportFieldInfoTableName];

                        List<string> diffParamsNames = reportFieldInfoTable.Rows.Cast<DataRow>().Where(p => !Convert.ToBoolean(p[ReportPluginResources.IntegrableValue]) &&
                                                                                                   Convert.ToString(p[ReportPluginResources.Name]).Contains(ReportPluginResources.Diff))
                                                                                                .Select(p => Convert.ToString(p[ReportPluginResources.Name])).ToList();


                        foreach (string diffParamName in diffParamsNames)
                        {
                            newMainDataTable.Columns.Add(new DataColumn(diffParamName, typeof(decimal)));
                        }
                        List<string> nonIntegParamNames = reportFieldInfoTable.Rows.Cast<DataRow>().Where(p => !Convert.ToBoolean(p[ReportPluginResources.IntegrableValue]) &&
                                                                                    !Convert.ToString(p[ReportPluginResources.Name]).Contains(ReportPluginResources.Diff))
                                                                                                .Select(p => Convert.ToString(p[ReportPluginResources.Name])).ToList();
                        foreach (string nonIntegParamName in nonIntegParamNames)
                        {
                            newMainDataTable.Columns.Add(new DataColumn(nonIntegParamName, typeof(decimal)));
                        }

                        for (DateTime startDate = periodBegin; startDate <= periodEnd; startDate = startDate.AddDays(1.0))
                        {
                            DataRow newRow = newMainDataTable.NewRow();
                            newRow[DbTablePermanentResources.TimeColumn] = startDate;
                            newRow[DbTablePermanentResources.IsValidRowStateColumn] = true;
                            DateTime stDate = startDate;
                            DateTime enDate = startDate.AddDays(1.0);

                            foreach (var diffParamName in diffParamsNames)
                            {
                                newRow[diffParamName] = mainDataTable.Rows.Cast<DataRow>().Where(p => p[DbTablePermanentResources.TimeColumn] != DBNull.Value &&
                                                                                                      Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) >= stDate &&
                                                                                                      Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) < enDate &&
                                                                                                      p[diffParamName] != DBNull.Value).Select(p => Convert.ToDecimal(p[diffParamName])).Sum();
                            }

                            foreach (var instantParamName in nonIntegParamNames)
                            {
                                newRow[instantParamName] = Math.Round(mainDataTable.Rows.Cast<DataRow>().Where(p => p[DbTablePermanentResources.TimeColumn] != DBNull.Value &&
                                                                                                         Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) >= stDate &&
                                                                                                         Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) < enDate &&
                                                                                                         p[instantParamName] != DBNull.Value).Select(p => Convert.ToDecimal(p[instantParamName])).Average(), 2);
                            }
                            newMainDataTable.Rows.Add(newRow);
                        }
                        break;
                    case 2:
                        _commonHelper.SetErrorInfoColumn(mainDataTable);
                        break;
                    default:
                        break;
                }

                DataSource.Tables.Remove(DbTablePermanentResources.DefaultMainDataTableName);
                DataSource.Tables.Add((periodTypeId == 3) ? newMainDataTable : mainDataTable);

                List<SummaryParameterInfo> summaryParametersInfo = _commonHelper.GetSummaryParametersInfo();
                DataTable newSummaryDataTable = new DataTable(DbTablePermanentResources.DefaultSummaryDataTableName);
                newSummaryDataTable.Columns.Add(new DataColumn(DbTablePermanentResources.TimeColumn, typeof(DateTime)));

                DateTime periodEndForSummary;
                int systemNumber;
                int measurementDeviceId = _commonHelper.GetMeasurementDeviceId();
                periodEndForSummary = periodEnd.AddDays(1.0);

                foreach (var spi in summaryParametersInfo)
                {
                    newSummaryDataTable.Columns.Add(new DataColumn(spi.SumName, typeof(decimal)));
                    bool hasIntegratorPeriodBegin = false;
                    bool hasIntegratorPeriodEnd = false;
                    using (ApplicationDatabaseContext context = new ApplicationDatabaseContext())
                    {
                        using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                        {
                            try
                            {
                                // сначала пытаемся искать полное совпадение по времени у интеграторов
                                var archives = context.Set<Archive>().Where(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                (p.Time == periodBegin || p.Time == periodEnd)).ToList();
                                Archive archiveForBegin = archives.FirstOrDefault<Archive>(p => p.Time == periodBegin);
                                Archive archiveForEnd = archives.FirstOrDefault<Archive>(p => p.Time == periodEndForSummary);
                                if (archiveForBegin != null)
                                {
                                    spi.PeriodBeginSumValue = archiveForBegin.Value;
                                    hasIntegratorPeriodBegin = true;
                                }
                                if (archiveForEnd != null)
                                {
                                    spi.PeriodEndSumValue = archiveForEnd.Value;
                                    hasIntegratorPeriodEnd = true;
                                }

                                // пытаемся искать интеграторы внутри таблицы mainData и используя локальные значения рассчитать интеграторы на заданное время
                                if (!hasIntegratorPeriodBegin)
                                {
                                    Archive periodBeginSummaryInDiapazonArchive = context.Set<Archive>().FirstOrDefault(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                                                               p.Time >= periodBegin && p.Time < periodEnd);
                                    if (periodBeginSummaryInDiapazonArchive != null)
                                    {
                                        spi.PeriodBeginSumValue = periodBeginSummaryInDiapazonArchive.Value - mainDataTable.Rows.Cast<DataRow>().Where(p => Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) >= periodBegin &&
                                                                                                               (Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) < periodBeginSummaryInDiapazonArchive.Time) && (p[spi.DiffName] != DBNull.Value))
                                                                                                               .Select(p => Convert.ToDecimal(p[spi.DiffName])).Sum();
                                        hasIntegratorPeriodBegin = true;
                                    }
                                }
                                if (!hasIntegratorPeriodEnd)
                                {
                                    Archive periodEndSummaryInDiapazonArchive = context.Set<Archive>().FirstOrDefault(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                                                                   p.Time >= periodBegin && p.Time < periodEndForSummary);
                                    if (periodEndSummaryInDiapazonArchive != null)
                                    {
                                        spi.PeriodEndSumValue = periodEndSummaryInDiapazonArchive.Value + mainDataTable.Rows.Cast<DataRow>().Where(p => Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) < periodEndForSummary &&
                                                                                                                   (Convert.ToDateTime(p[DbTablePermanentResources.TimeColumn]) >= periodEndSummaryInDiapazonArchive.Time) && (p[spi.DiffName] != DBNull.Value))
                                                                                                                   .Select(p => Convert.ToDecimal(p[spi.DiffName])).Sum();

                                        hasIntegratorPeriodEnd = true;
                                    }
                                }

                                // пытаемся искать интеграторы за пределами таблицы mainData и смотрим на даты вперед
                                if (!hasIntegratorPeriodBegin)
                                {
                                    Archive periodBeginSummaryOutDiapazionArchive = context.Set<Archive>().FirstOrDefault(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                                                                          p.Time > periodBegin);
                                    if (periodBeginSummaryOutDiapazionArchive != null)
                                    {
                                        spi.PeriodBeginSumValue = periodBeginSummaryOutDiapazionArchive.Value - context.Set<Archive>().Where(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.DiffDeviceParameterId &&
                                                                                                                          p.Time >= periodBegin && p.Time < periodBeginSummaryOutDiapazionArchive.Time).Select(p => p.Value).Sum();
                                        hasIntegratorPeriodBegin = true;
                                    }
                                }
                                if (!hasIntegratorPeriodEnd)
                                {

                                    Archive periodEndSummaryOutDiapazonArchive = context.Set<Archive>().FirstOrDefault(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                                                                p.Time > periodEndForSummary);
                                    if (periodEndSummaryOutDiapazonArchive != null)
                                    {
                                        spi.PeriodEndSumValue = periodEndSummaryOutDiapazonArchive.Value - context.Set<Archive>().Where(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.DiffDeviceParameterId &&
                                                                                                                    p.Time >= periodEndForSummary && p.Time < periodEndSummaryOutDiapazonArchive.Time).Select(p => p.Value).Sum();
                                        hasIntegratorPeriodEnd = true;
                                    }
                                }

                                // пытаемся искать интеграторы за пределами таблицы mainData и смотрим на даты назад
                                if (!hasIntegratorPeriodBegin)
                                {
                                    Archive periodBeginSummaryOutDiapazionArchive = context.Set<Archive>().FirstOrDefault(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                                                                          p.Time < periodBegin);
                                    if (periodBeginSummaryOutDiapazionArchive != null)
                                    {
                                        spi.PeriodBeginSumValue = periodBeginSummaryOutDiapazionArchive.Value + context.Set<Archive>().Where(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.DiffDeviceParameterId &&
                                                                                                                       p.Time < periodBegin && p.Time >= periodBeginSummaryOutDiapazionArchive.Time).Select(p => p.Value).Sum();
                                        hasIntegratorPeriodBegin = true;
                                    }
                                }
                                if (!hasIntegratorPeriodEnd)
                                {
                                    Archive periodEndSummaryOutDiapazonArchive = context.Set<Archive>().FirstOrDefault(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.SumDeviceParameterId &&
                                                                                                                       p.Time < periodEndForSummary);
                                    if (periodEndSummaryOutDiapazonArchive != null)
                                    {
                                        spi.PeriodEndSumValue = periodEndSummaryOutDiapazonArchive.Value + context.Set<Archive>().Where(p => p.PeriodTypeId == 2 && p.MeasurementDeviceId == measurementDeviceId && p.DeviceParameterId == spi.DiffDeviceParameterId &&
                                                                                                                          p.Time < periodEndForSummary && p.Time >= periodEndSummaryOutDiapazonArchive.Time).Select(p => p.Value).Sum();

                                        hasIntegratorPeriodEnd = true;
                                    }
                                }
                                spi.HasValueOnPeriodBegin = hasIntegratorPeriodBegin;
                                spi.HasValueOnPeriodEnd = hasIntegratorPeriodEnd;
                                tran.Commit();
                            }
                            catch
                            {
                                tran.Rollback();
                            }
                        }
                    }

                }


                DataRow row = newSummaryDataTable.NewRow();
                row[DbTablePermanentResources.TimeColumn] = periodBegin;
                foreach (SummaryParameterInfo info in summaryParametersInfo)
                {
                    if (info.HasValueOnPeriodBegin)
                    {
                        row[info.SumName] = info.PeriodBeginSumValue;
                    }
                }

                newSummaryDataTable.Rows.Add(row);
                DataRow row2 = newSummaryDataTable.NewRow();
                row2[DbTablePermanentResources.TimeColumn] = periodEndForSummary;
                foreach (SummaryParameterInfo info2 in summaryParametersInfo)
                {
                    if (info2.HasValueOnPeriodEnd)
                    {
                        row2[info2.SumName] = info2.PeriodEndSumValue;
                    }
                }
                newSummaryDataTable.Rows.Add(row2);
                DataSource.Tables.Remove(DbTablePermanentResources.DefaultSummaryDataTableName);
                DataSource.Tables.Add(newSummaryDataTable);


                int precisionHeat = -1;
                int precisionChannel1 = -1;
                int precisionChannel2 = -1;
                systemNumber = GetSystemNumber(summaryParametersInfo);
                if (systemNumber != -1)
                {
                    int[] deviceTechParamsIds = VistHelper.VistPrecisionInfo.First<VistPrecisionInfo>(p => p.SystemNumber == systemNumber).VistPrecisionDeviceParameters.Select(p => p.DeviceParameterId).ToArray();
                    List<DeviceTechnicalParameter> deviceTechParams = new List<DeviceTechnicalParameter>();
                    using (ApplicationDatabaseContext context = new ApplicationDatabaseContext())
                    {
                        using (var tran = context.Database.BeginTransaction(IsolationLevel.ReadUncommitted))
                        {
                            try
                            {
                                deviceTechParams = context.Set<DeviceTechnicalParameter>().Where(p => p.MeasurementDeviceId == measurementDeviceId && deviceTechParamsIds.Contains(p.DeviceParameterId)).ToList();
                                tran.Commit();
                            }
                            catch
                            {
                                tran.Rollback();
                            }
                        }
                    }

                    int channel1Number = GetChannelNumber(summaryParametersInfo, ReportPluginResources.SupplyPipe);
                    precisionChannel1 = GetChannelPrecision(channel1Number, deviceTechParams, systemNumber, StringFormatResources.Channel);
                    int channel2Number = GetChannelNumber(summaryParametersInfo, ReportPluginResources.ReturnPipe);
                    precisionChannel2 = GetChannelPrecision(channel2Number, deviceTechParams, systemNumber, StringFormatResources.Channel);
                    precisionHeat = GetChannelPrecision(0, deviceTechParams, systemNumber, ReportPluginResources.Heat);
                }

                AddParameter<int>(ReportPluginResources.PrecisionHeat, precisionHeat);
                AddParameter<int>(ReportPluginResources.PrecisionChannel1, precisionChannel1);
                AddParameter<int>(ReportPluginResources.PrecisionChannel2, precisionChannel2);
            }
        }
    

        private DateTime CorrectBeginPeriod(DataTable mainDataTable)
        {
            return Convert.ToDateTime(mainDataTable.Rows.Cast<DataRow>().First<DataRow>()[DbTablePermanentResources.TimeColumn]).Date;
        }

        private DateTime CorrectEndPeriod(DataTable mainDataTable)
        {
            return Convert.ToDateTime(mainDataTable.Rows.Cast<DataRow>().Last<DataRow>()[DbTablePermanentResources.TimeColumn]).Date;
        }


        private int GetChannelNumber(List<SummaryParameterInfo> summaryParameterInfo, string pipeType)
        {
            SummaryParameterInfo info = summaryParameterInfo.FirstOrDefault<SummaryParameterInfo>(p => p.DiffName.Contains(pipeType));
            int channelNumber = -1;
            if (info != null)
            {
                if (info.DiffName.Contains(ReportPluginResources.Mass))
                {
                    channelNumber = Convert.ToInt32(Regex.Match(info.SumDeviceParameterName, @"^Mass(\d)Increase").Groups[1].Value);
                }
                if (info.DiffName.Contains(ReportPluginResources.Volume))
                {
                    channelNumber = Convert.ToInt32(Regex.Match(info.SumDeviceParameterName, @"^Volume(\d)Increase").Groups[1].Value);
                }
            }
            return channelNumber;
        }

        private int GetChannelPrecision(int channelNumber, List<DeviceTechnicalParameter> deviceTechParams, int systemNumber, string precisionStringFormat)
        {
            int channelPrecision = -1;
            VistPrecisionType vistPrecisionType = (VistPrecisionType)Enum.Parse(typeof(VistPrecisionType), string.Format(precisionStringFormat, channelNumber));
            int deviceParameterId = VistHelper.VistPrecisionInfo.First<VistPrecisionInfo>(p => (p.SystemNumber == systemNumber)).VistPrecisionDeviceParameters.First<VistPrecisionDeviceParameter>(p => (p.VistPrecisionType == vistPrecisionType)).DeviceParameterId;
            DeviceTechnicalParameter parameter = deviceTechParams.FirstOrDefault<DeviceTechnicalParameter>(p => p.DeviceParameterId == deviceParameterId);
            if (parameter != null)
            {
                channelPrecision = Convert.ToInt32(parameter.StringValue);
            }
            return channelPrecision;
        }


        private int GetSystemNumber(List<SummaryParameterInfo> summaryParameterInfo)
        {
            SummaryParameterInfo info = summaryParameterInfo.FirstOrDefault(p => p.SumDeviceParameterName.Contains(ReportPluginResources.System));
            int systemNumber = -1;
            if (info != null)
            {
                systemNumber = Convert.ToInt32(Regex.Match(info.SumDeviceParameterName, @"^\w+System(\d)").Groups[1].Value);
            }
            return systemNumber;
        }
    }
}
