using EnergyTechAudit.PowerAccounting.Core.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    /// <summary>
    /// Интерфейс-маркер, указывающий на то, что сущность является шаблоном другой сущности
    /// </summary>
    /// <example>MeasurementDevice шаблонизируется Device</example>
    public interface ITemplatableEntity: IEntity
    {
    }
}
