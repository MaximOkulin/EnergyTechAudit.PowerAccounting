using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Тип договорного параметра системы ресурсов ("Объемный расход холодной воды по договору")
    /// </summary>
    [EntityName(Name =  "Тип договорного параметра системы ресурсов")]
    public class AgreementSystemParameter : DictionaryEntityBase
    {
        [Display(Name = "Ид")]
        [Required]
        public int PhysicalParameterId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ResourceSystemTypeId { get; set; }

        [Display(Name = "Физическая величина")]
        [ForeignKey("PhysicalParameterId")]
        public virtual PhysicalParameter PhysicalParameter { get; set; }

        [Display(Name = "Тип ресурсной системы")]
        [ForeignKey("ResourceSystemTypeId")]
        public virtual ResourceSystemType ResourceSystemType { get; set; }
    }
}
