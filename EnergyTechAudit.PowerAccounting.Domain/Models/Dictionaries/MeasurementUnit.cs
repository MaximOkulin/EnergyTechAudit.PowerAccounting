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
    /// Единица измерения физической величины
    /// </summary>
    [EntityName(Name = "Единица измерения")]
    public class MeasurementUnit : DictionaryEntityBase
    {
        public MeasurementUnit()
        {                        
            ParameterMapDeviceParameters = new List<ParameterMapDeviceParameter>();            
        }

        [Display(Name = "Ид")]
        [Required]
        public int PhysicalParameterId { get; set; }
        
        [Display(Name = "Физическая величина")]
        [ForeignKey("PhysicalParameterId")]     
        public virtual PhysicalParameter PhysicalParameter { get; set; }


        [InverseProperty("MeasurementUnit")]
        public virtual ICollection<ParameterMapDeviceParameter> ParameterMapDeviceParameters { get; private set; }

        [InverseProperty("MeasurementUnit1")]
        public virtual ICollection<MeasurementUnitConverter> MeasurementUnit1Converters { get; private set; }

        [InverseProperty("MeasurementUnit2")]
        public virtual ICollection<MeasurementUnitConverter> MeasurementUnit2Converters { get; private set; }

        [InverseProperty("MeasurementUnit")]
        public virtual ICollection<DefaultMeasurementUnit> DefaultMeasurementUnits { get; private set; }
        
        public override string ToString()
        {
            return Description;
        }
    }
}
 