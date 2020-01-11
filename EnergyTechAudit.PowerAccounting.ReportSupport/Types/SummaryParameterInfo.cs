namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class SummaryParameterInfo
    {
        public string SumName { get; set; }
        public string DiffName { get; set; }
        public int SumParameterId { get; set; }
        public int DiffParameterId { get; set; }
        public int DiffDeviceParameterId { get; set; }
        public int SumDeviceParameterId { get; set; }
        public string SumDeviceParameterName { get; set; }
        public decimal PeriodBeginSumValue { get; set; }
        public decimal PeriodEndSumValue { get; set; }
        public bool HasValueOnPeriodBegin { get; set; }
        public bool HasValueOnPeriodEnd { get; set; }
    }
}
