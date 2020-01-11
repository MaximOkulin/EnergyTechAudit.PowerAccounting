using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип события, возникшего в системе
    /// </summary>
    [EntityName(Name = "Параметр события прибора")]
    public class DeviceEventParameter : DictionaryEntityBase
    {
        public DeviceEventParameter()
        {
            DeviceEvents = new List<DeviceEvent>();
        }

        [InverseProperty("DeviceEventParameter")]
        public virtual ICollection<DeviceEvent> DeviceEvents { get; private set; }
    }
}
