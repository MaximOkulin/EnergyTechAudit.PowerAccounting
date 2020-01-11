using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Указывает на обнуление навигационного свойства связной сущности, 
    /// в процессе каскадного (или псевдокаскадного, посредством триггера) удаления
    /// </summary>
    /// <example>Удаление ChannelTemplate сопровождается обнулением ChannelTemplateId в Channel</example>
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class SetNullOnCascadeDeletingPropertyAttribute : Attribute { }
}