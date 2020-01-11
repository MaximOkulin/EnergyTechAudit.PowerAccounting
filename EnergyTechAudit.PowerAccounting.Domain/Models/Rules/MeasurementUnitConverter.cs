using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Rules
{
    [EntityName(Name = "Правило преобразования единиц измерения")]
    public class MeasurementUnitConverter: IEntity, IDescribableEntity
    {
        [Key]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Ид"), Required, UserInputRequired, DependencyDescribableProperty]        
        public int PhysicalParameterId { get; set; }
       
        [Display(Name = "Ид"), Required, UserInputRequired, DependencyDescribableProperty]
        public int MeasurementUnit1Id { get; set; }
        
        [Display(Name = "Ид"), Required, UserInputRequired, DependencyDescribableProperty]        
        public int MeasurementUnit2Id { get; set; }
        
        [Display(Name = "Выражение"), Required, UserInputRequired]
        public string Expression { get; set; }

        [Display(Name = "Физический параметр")]
        [ForeignKey("PhysicalParameterId"), RequiredDescribableProperty]
        public virtual PhysicalParameter PhysicalParameter { get; set; }

        [Display(Name = "Исходная единица измерения")]
        [ForeignKey("MeasurementUnit1Id"), RequiredDescribableProperty]
        [BindToDictionary(DictionaryType = typeof(MeasurementUnit))]
        public virtual MeasurementUnit MeasurementUnit1 { get; set; }

        [Display(Name = "Целевая единица измерения"), RequiredDescribableProperty]
        [ForeignKey("MeasurementUnit2Id")]
        [BindToDictionary(DictionaryType = typeof(MeasurementUnit))]
        public virtual MeasurementUnit MeasurementUnit2 { get; set; }

        public override string ToString()
        {
            return Description;
        }

       public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            DescribableEntityHelper.CalculateDescription(contextAdapter, this, () =>
            {
                Description = string.Format("Преобразование для \"{0}\" ({1} -> {2})",
                    PhysicalParameter.Description,
                    MeasurementUnit1.Description,
                    MeasurementUnit2.Description);
            });
        }
    }
}
