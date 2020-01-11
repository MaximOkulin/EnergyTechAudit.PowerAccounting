using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using EnergyTechAudit.PowerAccounting.Common.FormatProviders;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Plugin
{
    public class Vkt7InfoPlugin : ReportPluginBase
    {
        private readonly int _periodTypeId;
        private readonly string _resourceSystemTypeCode;

        public Vkt7InfoPlugin(object dataSource, IEnumerable<object> parameters) :
            base(dataSource, parameters)
        {
            var periodTypeParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.PeriodTypeIdColumn));
            if (periodTypeParam != null)
            {
                _periodTypeId = Convert.ToInt32(periodTypeParam.Value);
            }

            var resourceSystemTypeParam =
                Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.ResourceSystemTypeCodeColumn));
            if (resourceSystemTypeParam != null)
            {
                _resourceSystemTypeCode = Convert.ToString(resourceSystemTypeParam.Value);
            }
        }

        public override void Execute()
        {
            var mainDataTable = DataSource.Tables[DbTablePermanentResources.DefaultMainDataTableName];
            var summaryDataTable = DataSource.Tables[DbTablePermanentResources.DefaultSummaryDataTableName];

            decimal timeNormalSum = 0;
            decimal timeDenialSum = 0;

            bool isSumTimesInited = false;
            try
            {
                timeNormalSum = mainDataTable.Rows.Cast<DataRow>()
                    .Sum(row => Convert.ToDecimal(row[string.Format(StringFormatResources.TimeNormalDiff, _resourceSystemTypeCode)]));

                timeDenialSum = mainDataTable.Rows.Cast<DataRow>()
                    .Sum(row => Convert.ToDecimal(row[string.Format(StringFormatResources.TimeDenialDiff, _resourceSystemTypeCode)]));
                isSumTimesInited = true;
            }
            catch
            {
                isSumTimesInited = false;
            }

            if (isSumTimesInited)
            {
                decimal timeNormal = 0;
                decimal timeDenial = 0;

                if (summaryDataTable.Rows.Count == 2)
                {
                    var timeNormalRow =
                        summaryDataTable.Rows[1][string.Format(StringFormatResources.TimeNormal, _resourceSystemTypeCode)];
                    var timeDenialRow =
                        summaryDataTable.Rows[1][string.Format(StringFormatResources.TimeDenial, _resourceSystemTypeCode)];

                    if (timeNormalRow != DBNull.Value && timeDenialRow != DBNull.Value)
                    {
                        timeNormal = Convert.ToDecimal(timeNormalRow);
                        timeDenial = Convert.ToDecimal(timeDenialRow);
                    }
                }

                var infoParam = Parameters.FirstOrDefault(p => p.FullName.Equals(DbTablePermanentResources.InfoColumn));
                if (infoParam != null)
                {
                    string[] normalParts = timeNormalSum.ToHhmm().Split(':');
                    string[] denialParts = timeDenialSum.ToHhmm().Split(':');
                    string[] totalParts = (timeNormal + timeDenial).ToHhmm().Split(':');

                    int normalHours = Convert.ToInt32(normalParts[0]);
                    int normalMinutes = Convert.ToInt32(normalParts[1]);

                    int denialHours = Convert.ToInt32(denialParts[0]);
                    int denialMinutes = Convert.ToInt32(denialParts[1]);

                    var sb = new StringBuilder();

                    sb.AppendLine(string.Format(StringFormatResources.TimeNormalPeriod,
                        normalHours, normalMinutes > 0 ? string.Format(StringFormatResources.MinuteFormat, normalMinutes) : string.Empty));

                    sb.AppendLine(string.Format(StringFormatResources.TimeDenialPeriod,
                        IsHeatSysOrHws() ? ReportPluginResources.HeatEnergy : ReportPluginResources.WhiteSpace,
                        denialHours, denialMinutes > 0 ? string.Format(StringFormatResources.MinuteFormat, denialMinutes) : string.Empty));

                    int totalHours = 0;
                    int totalMinutes = 0;
                    bool totalHoursParse = Int32.TryParse(totalParts[0], out totalHours);
                    bool totalMinutesParse = Int32.TryParse(totalParts[1], out totalMinutes);

                    if (totalHoursParse && totalMinutesParse)
                    {
                        sb.AppendLine(string.Format(StringFormatResources.PeriodAfterReset,
                                totalHours, totalMinutes > 0 ? string.Format(StringFormatResources.MinuteFormat, totalMinutes) : string.Empty));
                    }

                    infoParam.Value = sb.ToString();
                }
            }
        }

        /// <summary>
        /// Определяет является ли текущая ресурсная система канала ЦО или ГВС
        /// </summary>
        private bool IsHeatSysOrHws()
        {
            return
                _resourceSystemTypeCode.Equals(ReportPluginResources.HeatSysResourceSystemTypeCode, StringComparison.Ordinal) ||
                _resourceSystemTypeCode.Equals(ReportPluginResources.HwsResourceSystemTypeCode, StringComparison.Ordinal);
        }
    }
}
