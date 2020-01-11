using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип считывателя устройств
    /// </summary>
    [EntityName(Name = "Тип считывателя устройств")]
    public class DeviceReaderType : DictionaryEntityBase
    {
        [InverseProperty("DeviceReaderType")]
        public virtual ICollection<DeviceReader> DeviceReaders { get; private set; }
    }
}