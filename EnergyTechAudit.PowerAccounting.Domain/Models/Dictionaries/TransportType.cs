using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип транспорта для точек доступа
    /// </summary>
    [EntityName(Name = "Тип транспорта")]
    public class TransportType : DictionaryEntityBase
    {
        public TransportType()
        {
            AccessPoints = new List<AccessPoint>();
        }

        [InverseProperty("TransportType")]
        public virtual ICollection<AccessPoint> AccessPoints { get; private set; }
    }
}
