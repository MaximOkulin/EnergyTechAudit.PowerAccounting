using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Сводная диаграмма")]
    public class PivotDiagramm : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
    
    }
}
