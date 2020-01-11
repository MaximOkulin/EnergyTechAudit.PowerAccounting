using System;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class DisplayColumnMetadataAttribute : Attribute
    {
        public int Width  { get; set; }
        public bool IsDescriptive { get; set; }
    }

    [AttributeUsage(AttributeTargets.Property)]
    public sealed class BindToDictionaryAttribute: Attribute
    {
        public Type DictionaryType { get; set; }
    }
     
}