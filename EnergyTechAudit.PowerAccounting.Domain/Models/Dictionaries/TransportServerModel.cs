using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name =  "Модель транспортного сервера")]
    public class TransportServerModel : DictionaryEntityBase
    {
        public TransportServerModel()
        {
            AccessPoints = new List<AccessPoint>();
        }

        [InverseProperty("TransportServerModel")]
        public virtual ICollection<AccessPoint> AccessPoints { get; private set; }
    }
}
