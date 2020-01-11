using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Часто задаваемый вопрос"
    /// </summary>
    [
        EntityName(Name = "Часто задаваемый вопрос"), 
        RequireIncludeDescribablePropertiesEntity, 
        UserRestrictedPermissionEntity,
        PossibleCascadeDeletedEntity
    ]
    public class Faq : DataViewItemBase
    {
        public Faq()
        {
            FaqLinksRole = new List<FaqLinkRole>();            
        }

        [Display(Name = "Номер")]
        public int Number { get; set; }

        [LinkDisplayGrid(Text= "Вопрос")]
        [Display(Name = "Вопрос")]
        public string Question { get; set; }

        [LinkDisplayGrid(Text = "Ответ")]
        [Display(Name = "Ответ")]
        public string Answer { get; set; }

        [Display(Name = "Категории")]
        public string Categories { get; set; } 
        
        [Display(Name = "Роли")]
        [InverseProperty("Faq")]
        public virtual ICollection<FaqLinkRole> FaqLinksRole { get; private set; }        
    }
}