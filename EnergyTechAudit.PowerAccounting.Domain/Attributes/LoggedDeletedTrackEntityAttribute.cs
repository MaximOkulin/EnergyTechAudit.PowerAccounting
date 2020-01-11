using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    /// <summary>
    /// Указывает на возможность каскадного удаления сущности 
    /// </summary>
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class LoggedDeletedTrackEntityAttribute : Attribute { }
}