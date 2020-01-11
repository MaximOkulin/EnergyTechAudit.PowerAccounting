using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Отмечает поля сущностей, которые не дожны отображаться в решетках
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class NotDisplayGridAttribute : Attribute
    {
    }

    /// <summary>
    /// Отмечает поля сущностей, которые не дожны отображаться в решетках
    /// </summary>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class HiddenGridAttribute : Attribute
    {
    }
}