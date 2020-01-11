using System.Collections.Generic;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Источник данных")]
    public class Source : TemplateEntityBase
    {
        public Source()
        {
            MetaObjects = new List<MetaObject>();
        }
        public virtual ICollection<MetaObject> MetaObjects { get; private set; }
    }
}
