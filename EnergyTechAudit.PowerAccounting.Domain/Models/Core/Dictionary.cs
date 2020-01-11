using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Словарь")]
    public partial class Dictionary : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
        public bool UpdateOnly { get; set; }
        
    }
}
