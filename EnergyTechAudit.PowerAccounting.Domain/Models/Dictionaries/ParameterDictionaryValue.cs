using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Значение словарного параметра")]
    public class ParameterDictionaryValue : DictionaryEntityBase
    {
        [Display(Name = "Значение")]
        [Required]
        public decimal Value { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DeviceId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ParameterDictionaryId { get; set; }

        [Display(Name = "Модель прибора")]
        [ForeignKey("DeviceId")]
        public virtual Device Device { get; set; }

        [Display(Name = "Словарь")]
        [ForeignKey("ParameterDictionaryId")]
        public virtual ParameterDictionary ParameterDictionary { get; set; }
    }
}
