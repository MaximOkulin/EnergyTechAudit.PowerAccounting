using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    [AttributeUsage(AttributeTargets.Class)]
    public sealed class JsonObjectSignalRCamelCasePropertyNamesAttribute : Attribute { }
}