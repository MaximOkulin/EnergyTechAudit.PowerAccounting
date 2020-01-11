using System.Collections.Generic;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Тип метаобъекта")]
    public partial class MetaObjectType: DictionaryEntityBase
    {
        public MetaObjectType()
        {
            MetaObjects = new HashSet<MetaObject>();
        }

        public virtual ICollection<MetaObject> MetaObjects { get; private set; }    
    }

}
