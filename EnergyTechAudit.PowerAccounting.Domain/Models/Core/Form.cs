using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    public enum FormMode
    {
        Normal,
        AttachMultipleToMultipleLink,        
        ShowSingleOnly,
        ShowEditableSingleOnly
    }

    [EntityName(Name = "Описание формы сущности")]
    public class Form : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
        public Form()
        {
            Mode = FormMode.Normal;
        }

        public bool ReadOnly { get; set; }

        public string LinkedEntityTypeName { get; set; }

        public string Layout { get; set; }

        [NotMapped]
        public FormMode Mode { get; set; }
    }
}


