using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Подтип протокола")]
    public class ProtocolSubType : DictionaryEntityBase
    {
        public ProtocolSubType()
        {
            MeasurementDevices = new List<MeasurementDevice>();
        }

        [InverseProperty("ProtocolSubType")]
        public virtual ICollection<MeasurementDevice> MeasurementDevices { get; private set; }
    }
}
