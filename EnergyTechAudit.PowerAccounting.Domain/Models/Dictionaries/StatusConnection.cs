using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Статус соединения")]
    public partial class StatusConnection: DictionaryEntityBase
    {
        public StatusConnection()
        {
            MeasurementDevices = new List<MeasurementDevice>();
            AccessPoints = new List<AccessPoint>();
            AccessPointStatusConnectionLogs = new List<AccessPointStatusConnectionLog>();
            MeasurementDeviceStatusConnectionLogs = new List<MeasurementDeviceStatusConnectionLog>();
        }

        [InverseProperty("LastStatusConnection")]
        public virtual ICollection<MeasurementDevice> MeasurementDevices { get; private set; }

        [InverseProperty("LastStatusConnection")]
        public virtual ICollection<AccessPoint> AccessPoints { get; private set; }

        [InverseProperty("StatusConnection")]
        public virtual ICollection<AccessPointStatusConnectionLog> AccessPointStatusConnectionLogs { get; private set; }

        [InverseProperty("StatusConnection")]
        public virtual ICollection<MeasurementDeviceStatusConnectionLog> MeasurementDeviceStatusConnectionLogs { get; private set; }
    }
}
