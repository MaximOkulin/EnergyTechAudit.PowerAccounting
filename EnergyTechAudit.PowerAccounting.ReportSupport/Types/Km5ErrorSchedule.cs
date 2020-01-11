using System;
using System.Collections.Generic;
using System.Linq;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class Km5ErrorSchedule
    {
        private readonly Dictionary<Km5ErrorType, Km5ScheduleByErrorType> _schedules;
        private readonly int _internalDeviceEventOffset;

        public Km5ErrorSchedule(string deviceCode)
        {
            _internalDeviceEventOffset = deviceCode.Equals("KM5") ? 1000 : 2000;

            _schedules = new Dictionary<Km5ErrorType, Km5ScheduleByErrorType>();
        }

        public Km5ErrorTimes GetKm5ErrorTimes()
        {
            var km5ErrorTimes = new Km5ErrorTimes();

            foreach (var key in _schedules.Keys)
            {
                var errorInterval = _schedules[key].SumDuration();
                switch (key)
                {
                        case Km5ErrorType.D:
                        km5ErrorTimes.D += errorInterval;
                        break;
                        case Km5ErrorType.E:
                        km5ErrorTimes.E += errorInterval;
                        break;
                        case Km5ErrorType.G:
                        km5ErrorTimes.G += errorInterval;
                        break;
                        case Km5ErrorType.U:
                        km5ErrorTimes.U += errorInterval;
                        break;
                        case Km5ErrorType.g:
                        km5ErrorTimes.g += errorInterval;
                        break;
                }
            }
            return km5ErrorTimes;
        }

        /// <summary>
        /// Добавляет список событий КМ-5 в коллекцию и анализирует их продолжительности
        /// </summary>
        /// <param name="eventDurations"></param>
        public void AddInternalDeviceEventDurations(List<Km5InternalDeviceEventDuration> eventDurations)
        {
            foreach (var eventDuration in eventDurations)
            {
                var currentKm5ErrorType = GetKm5ErrorType(eventDuration.InternalDeviceEventId);

                Km5ScheduleByErrorType km5ScheduleByErrorType = null;
                _schedules.TryGetValue(currentKm5ErrorType, out km5ScheduleByErrorType);

                if(km5ScheduleByErrorType == null)
                {
                    km5ScheduleByErrorType = new Km5ScheduleByErrorType();
                    _schedules.Add(currentKm5ErrorType, km5ScheduleByErrorType);
                }

                km5ScheduleByErrorType.AddDuration(eventDuration.Duration);
            }
        }

        public string GetErrorInfo()
        {
            if (_schedules.Any(p => p.Key != Km5ErrorType.Unknown))
            {
                return string.Join(", ", _schedules.Where(p => p.Key != Km5ErrorType.Unknown)
                    .Select(p => Convert.ToString(p.Key)).ToArray());
            }
            return string.Empty;
        }

        private readonly Dictionary<int, Km5ErrorType> _errorCodes = new Dictionary<int, Km5ErrorType>
        {
            {61, Km5ErrorType.E},
            {64, Km5ErrorType.E},
            {65, Km5ErrorType.E},
            {66, Km5ErrorType.E},
            {67, Km5ErrorType.E},
            {68, Km5ErrorType.E},
            {69, Km5ErrorType.E},
            {71, Km5ErrorType.E},
            {73, Km5ErrorType.E},
            {74, Km5ErrorType.E},
            {76, Km5ErrorType.E},
            {79, Km5ErrorType.E},
            {81, Km5ErrorType.E},
            {82, Km5ErrorType.G},
            {84, Km5ErrorType.g},
            {85, Km5ErrorType.G},
            {87, Km5ErrorType.g},
            {88, Km5ErrorType.E},
            {90, Km5ErrorType.E},
            {91, Km5ErrorType.E},
            {93, Km5ErrorType.E},
            {94, Km5ErrorType.E},
            {96, Km5ErrorType.D},
            {106, Km5ErrorType.E},
            {114, Km5ErrorType.E},
            {119, Km5ErrorType.E},
            {120, Km5ErrorType.E},
            {121, Km5ErrorType.E},
            {122, Km5ErrorType.U}
        };

        private Km5ErrorType GetKm5ErrorType(int internalDeviceEventDuration)
        {
            Km5ErrorType result;
            _errorCodes.TryGetValue(internalDeviceEventDuration - _internalDeviceEventOffset, out result);

            return result;
        }
    }
}
