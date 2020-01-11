using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    public class ResourceSubsystemType : DictionaryEntityBase
    {
        [Display(Name = "Ид")]
        [Required]
        public int ResourceSystemTypeId { get; set; }

        [Display(Name = "Аббревиатура")]
        public string ShortName { get; set; }

        [Display(Name = "Тип ресурсной системы")]
        [ForeignKey("ResourceSystemTypeId")]
        public virtual ResourceSystemType ResourceSystemType { get; set; }
    }
}
