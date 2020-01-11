using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    /// <summary>
    /// Физический параметр (давление, скорость)
    /// </summary>
    [EntityName(Name = "Физический параметр")]
    public class PhysicalParameter : DictionaryEntityBase
    {
        public PhysicalParameter()
        {
            MeasurementUnits = new List<MeasurementUnit>();
            AgreementSystemParameters = new List<AgreementSystemParameter>();
            Parameters = new List<Parameter>();
            MeasurementUnitConverters = new List<MeasurementUnitConverter>();
        }

        [Display(Name = "Порядок следования", Order = 4)]
        public int? Order { get; set; }

        public override string ToString()
        {
            return Description;
        }

        [InverseProperty("PhysicalParameter")]
        public virtual ICollection<MeasurementUnit> MeasurementUnits { get; private set; }
        
        [InverseProperty("PhysicalParameter")]
        public virtual ICollection<AgreementSystemParameter> AgreementSystemParameters { get; private set; }

        [InverseProperty("PhysicalParameter")]
        public virtual ICollection<Parameter> Parameters { get; private set; }

        [InverseProperty("PhysicalParameter")]
        public virtual ICollection<MeasurementUnitConverter> MeasurementUnitConverters { get; private set; }

        [InverseProperty("PhysicalParameter")]
        public virtual ICollection<DefaultMeasurementUnit> DefaultMeasurementUnits { get; private set; }


    }
}
