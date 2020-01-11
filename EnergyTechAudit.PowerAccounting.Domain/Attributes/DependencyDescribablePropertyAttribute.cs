using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Изменение свойства обуславливает перевычисление Description сущности 
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class DependencyDescribablePropertyAttribute : Attribute{}
}