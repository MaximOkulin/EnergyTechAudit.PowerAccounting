using System.ComponentModel.DataAnnotations;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    public abstract class TemplateEntityBase : DictionaryEntityBase
    {        
        [Required]
        public string Template { get; set; }        
    }
}
