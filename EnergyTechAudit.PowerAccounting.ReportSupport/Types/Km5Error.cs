using System;
using System.Data;
using EnergyTechAudit.PowerAccounting.Common.Resources;

namespace EnergyTechAudit.PowerAccounting.ReportSupport.Types
{
    public class Km5Error
    {
        private int _internalDeviceEventId;
        private DateTime _time;
        private Km5ErrorState _state;

        public int InternalDeviceEventId
        {
            get
            {
                return _internalDeviceEventId;
            }
        }

        public DateTime Time
        {
            get { return _time; }
        }

        public Km5ErrorState State
        {
            get { return _state; }
        }

        public Km5Error(DataRow row)
        {
            var columns = row.Table.Columns;
            if (columns.Contains(DbTablePermanentResources.InternalDeviceEventIdColumn) && columns.Contains(DbTablePermanentResources.TimeColumn) &&
                columns.Contains(DbTablePermanentResources.OriginalValueColumn))
            {
                _internalDeviceEventId = Convert.ToInt32(row[DbTablePermanentResources.InternalDeviceEventIdColumn]);
                _time = Convert.ToDateTime(row[DbTablePermanentResources.TimeColumn]);
                _state = (Km5ErrorState)Convert.ToInt32(row[DbTablePermanentResources.OriginalValueColumn]);
            }
        }
    }

    public enum Km5ErrorState
    {
        /// <summary>
        /// Окончание события
        /// </summary>
        End = 0,
        /// <summary>
        /// Начало события
        /// </summary>
        Start = 1
    }
}
