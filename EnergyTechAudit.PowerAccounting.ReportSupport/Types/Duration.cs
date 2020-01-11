using System;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class Duration
    {
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public int Interval { get; set; }

        public Duration(DateTime start, DateTime end)
        {
            Start = start;
            End = end;
            CalculateInterval();
        }

        private void CalculateInterval()
        {
            var ts = End - Start;
            Interval = (int)ts.TotalSeconds;
        }
    }
}
