using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Сводная таблица")]
    public partial class Pivot : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
    }
}
