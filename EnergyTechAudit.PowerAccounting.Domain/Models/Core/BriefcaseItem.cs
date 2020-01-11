using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Common.Entity;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    /// <summary>
    /// Сущность "Элемент портфеля"
    /// </summary>
    public class BriefcaseItem : IEntity, IEntityInfo, IDescribableEntity, ICommentableEntity
    {        
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Наименование")]
        public string Description { get; set; }

        [Display(Name = "Ид. сущности")]
        public int EntityId { get; set; }

        [Display(Name = "Наименование сущности")]
        public string EntityTypeName { get; set; }

        [NotDisplayGrid]
        public string Comments { get; set; }

        [NotDisplayGrid]
        public int BriefcaseId { get; set; }

        [NotDisplayGrid]
        [ForeignKey("BriefcaseId")]
        public Briefcase Briefcase { get; set; }

        [NotDisplayGrid]
        [NotMapped]
        public Type EntityType
        {
            get
            {
                return EntityTypeHelper.GetEntityTypeByName(EntityTypeName);                
            }
        }
        
        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            throw new NotImplementedException();
        }
    }
}