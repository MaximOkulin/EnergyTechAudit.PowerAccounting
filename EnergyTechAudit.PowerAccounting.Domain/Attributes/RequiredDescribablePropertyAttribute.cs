using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Свойство требуется для вычисления Description сущности или перевычисления Description связной сущности
    /// (применим только к навигационному свойству, которое требуется подгрузить для вычисления Description)
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class RequiredDescribablePropertyAttribute : Attribute{}
}