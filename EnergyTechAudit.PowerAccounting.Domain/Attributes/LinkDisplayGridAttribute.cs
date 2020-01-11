using System;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;

namespace EnergyTechAudit.PowerAccounting.Domain.Attributes
{
    [AttributeUsage( AttributeTargets.Property )]
    public sealed class LinkDisplayGridAttribute : Attribute
    {
        public string Text { get; set; }

        public string ContentType { get; set; }

        public LinkDisplayGridAttribute()
        {
            Text = "Содержимое";
            ContentType = MimeType.TextPlain;
        }       
    }

    [AttributeUsage(AttributeTargets.Property)]
    public sealed class DoOrderGridAttribute: Attribute
    {
        private readonly GridColumnSortOrder _sortOrder;

        public DoOrderGridAttribute(GridColumnSortOrder sortOrder)
        {
            _sortOrder = sortOrder;
        }

        public GridColumnSortOrder SortOrder
        {
            get { return _sortOrder; }
        }
    }
}