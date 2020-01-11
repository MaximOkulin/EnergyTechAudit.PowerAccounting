using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Тип порта")]
    public class PortType : DictionaryEntityBase
    {
        public PortType()
        {
            MeasurementDevices = new List<MeasurementDevice>();
        }

        [InverseProperty("PortType")]
        public virtual ICollection<MeasurementDevice> MeasurementDevices { get; private set; }
    }
}
