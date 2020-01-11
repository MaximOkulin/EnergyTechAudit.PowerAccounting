using System.Collections.Generic;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "XML-шаблон параметрика")]
    public class Parametric : TemplateEntityBase
    {
        public Parametric()
        {
            MetaObjects = new List<MetaObject>();
        }
        public virtual ICollection<MetaObject> MetaObjects { get; private set; }
    }
}
