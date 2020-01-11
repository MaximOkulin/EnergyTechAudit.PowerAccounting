using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Измеряемый параметр ресурсной системы
    /// </summary>
    [EntityName(Name = "Измеряемый параметр")]
    public class Parameter : DictionaryEntityBase
    {
        public Parameter()
        {            
            ParameterMapDeviceParameters = new List<ParameterMapDeviceParameter>();            
        }

        [Display(Name = "Физическая величина")]
        [Required]
        public int PhysicalParameterId { get; set; }

        [Display(Name = "Тип ресурсной системы")]
        [Required]
        public int ResourceSystemTypeId { get; set; }

        [Display(Name = "Краткое описание")]
        public string ShortDescription { get; set; }

        [Display(Name = "Физическая величина")]
        [ForeignKey("PhysicalParameterId")]
        public virtual PhysicalParameter PhysicalParameter { get; set; }

        [Display(Name = "Тип ресурсной системы")]
        [ForeignKey("ResourceSystemTypeId")]
        public virtual ResourceSystemType ResourceSystemType { get; set; }        

        [InverseProperty("Parameter")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameters { get; private set; }        
    }
}
