using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Размерность единицы измерения (кило, мега, нано...)
    /// </summary>
    [EntityName(Name = "Размерность единицы измерения")]
    public class Dimension : DictionaryEntityBase
    {
        public Dimension()
        {            
            ParameterMapDeviceParameteres = new List<ParameterMapDeviceParameter>();            
        }

        [Display(Name = "Префикс")]
        public string Prefix { get; set; }

        [Display(Name = "Коэффициент", Order = 3)]
        [Required]
        public decimal Value { get; set; }
        
        [InverseProperty("Dimension")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameteres { get; private set; }

        [InverseProperty("Dimension")]
        public virtual ICollection<DefaultMeasurementUnit> DefaultMeasurementUnits { get; private set; }
        
        public override string ToString()
        {
            return Description;
        }
    }
}
