using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Плагин расширения дашборда")]
    public class DashboardExtentionTemplate : TemplateEntityBase, IPredicateExpressionMedium
    {
        public string PredicateExpression { get; set; }
    }
}
