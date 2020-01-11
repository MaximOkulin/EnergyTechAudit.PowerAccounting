using System;
using System.Collections.Generic;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class Km5ScheduleByErrorType
    {
        private SortedList<DateTime, Duration> _durations;

        public Km5ScheduleByErrorType()
        {
            _durations = new SortedList<DateTime, Duration>();
        }

        public int SumDuration()
        {
            return _durations.Sum(p => p.Value.Interval);
        }

        public void AddDuration(Duration duration)
        {
            var a1 = SearchDuration(duration.Start);
            var a2 = SearchDuration(duration.End);

            if (a1 != null && a2 != null && a1 != a2)
            {
                var start = a1.Start;
                var end = a2.End;

                var mergeDurations = GetMergeTimes(a1.Start, a2.Start);

                foreach (var mergeDuration in mergeDurations)
                {
                    _durations.Remove(mergeDuration);
                }

                CreateNewDuration(start, end);
                return;
            }

            if (a1 == null && a2 == null)
            {
                CreateNewDuration(duration.Start, duration.End);
                return;
            }

            if (a1 == null)
            {
                var end = a2.End;
                _durations.Remove(a2.Start);
                CreateNewDuration(duration.Start, end);
                return;
            }

            if (a2 == null)
            {
                var start = a1.Start;
                _durations.Remove(a1.Start);
                CreateNewDuration(start, duration.End);
            }
        }

        private void CreateNewDuration(DateTime start, DateTime end)
        {
            _durations.Add(start, new Duration(start, end));
        }

        private Duration SearchDuration(DateTime targetTime)
        {
            return _durations.FirstOrDefault(p => p.Value.Start <= targetTime && 
                                                  targetTime <= p.Value.End).Value;
        }

        private List<DateTime> GetMergeTimes(DateTime timeA1, DateTime timeA2)
        {
            var result = _durations.Where(p => p.Key > timeA1 && p.Key < timeA2)
                .Select(p => p.Key).ToList();

            result.Add(timeA1);
            result.Add(timeA2);

            return result;
        }
    }
}
