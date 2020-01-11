using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Тип технологического присоединения")]
    public class TechnologicAdjunctionType : DictionaryEntityBase
    {
        public TechnologicAdjunctionType()
        {
            Channels = new List<Channel>();
        }

        [InverseProperty("TechnologicAdjunctionType")]
        public virtual ICollection<Channel> Channels { get; private set; }
    }
}
