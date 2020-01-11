using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Infrastructure;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Новость - элемент доски объявлений"
    /// </summary>
    [
        EntityName(Name = "Новости"), 
        RequireIncludeDescribablePropertiesEntity, 
        UserRestrictedPermissionEntity,
        PossibleCascadeDeletedEntity
    ]
    public class News : DataViewItemBase, IDescribableEntity, IHistoryChangeTrackSuppressingEntity
    {
        public News()
        {            
            NewsLinksRole = new List<NewsLinkRole>();
        }

        [Display(Name = "Наименование"), Required, UserInputRequired]
        public string Description { get; set; }

        public void CalculateDescription(IObjectContextAdapter contextAdapter)
        {
            
        }

        [Display(Name = "Код")]
        public string Code { get; set; }

        [LinkDisplayGrid(Text = "Текст")]
        [Display(Name = "Текст")]
        public string Text { get; set; }

        [Display(Name = "Ид")]
        public int? BinaryId { get; set; }

        [NotDisplayGrid]
        public int ViewCounter { get; set; }

        [Display(Name = "Роли")]
        [InverseProperty("News")]
        public virtual ICollection<NewsLinkRole> NewsLinksRole { get; private set; }
        
        [Display(Name = "Изображение")]
        [ForeignKey("BinaryId"), RequireIncludeDescribablePropertiesEntity]
        public virtual Binary Binary { get; set; }

        [NotMapped]
        public bool SuppressHistory { get; set; }
    }
}
