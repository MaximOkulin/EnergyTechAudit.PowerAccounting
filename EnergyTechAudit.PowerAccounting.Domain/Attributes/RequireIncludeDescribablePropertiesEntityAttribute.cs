using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Указывает на необходимость загрузки связанных сущностей реализующих IDescribableEntity 
    /// </summary>
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Property)]
    public sealed class RequireIncludeDescribablePropertiesEntityAttribute : Attribute{}
}