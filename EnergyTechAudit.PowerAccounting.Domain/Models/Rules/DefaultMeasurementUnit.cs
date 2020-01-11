using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Rules
{
    [EntityName(Name = "Eдиница измерения по умолчанию")]
    public class DefaultMeasurementUnit : DictionaryEntityBase
    {
        [Display(Name = "Ид")]
        public int PhysicalParameterId { get; set; }

        [Display(Name = "Ид")]
        public int DimensionId { get; set; }

        [Display(Name = "Ид")]
        public int MeasurementUnitId { get; set; }

        [Display(Name = "Физический параметр")]
        [ForeignKey("PhysicalParameterId")]
        public virtual PhysicalParameter PhysicalParameter { get; set; }

        [Display(Name = "Размерность единицы измерения")]
        [ForeignKey("DimensionId")]
        public virtual Dimension Dimension { get; set; }

        [Display(Name = "Единица измерения")]
        [ForeignKey("MeasurementUnitId")]
        public virtual MeasurementUnit MeasurementUnit { get; set; }
    }
}
