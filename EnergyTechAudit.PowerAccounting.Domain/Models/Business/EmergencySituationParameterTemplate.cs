using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Шаблон параметра нештатной ситуации")]
    public class EmergencySituationParameterTemplate : ITemplatableEntity, IDescribableEntity
    {
        public EmergencySituationParameterTemplate()
        {
            EmergencySituationParameters = new List<EmergencySituationParameter>();
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        public override string ToString()
        {
            return Description;
        }

        [Display(Name = "Описание")]
        [Required]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            
        }

        [Display(Name = "Условие"), NotDisplayGrid]
        [Required]
        public string PredicateExpression { get; set; }

        [Display(Name = "Название сущности")]
        [Required]
        public string EntityTypeName { get; set; }

        [InverseProperty("EmergencySituationParameterTemplate")]
        public virtual ICollection<EmergencySituationParameter> EmergencySituationParameters { get; private set; }
    }
}
