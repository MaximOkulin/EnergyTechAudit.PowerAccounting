using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    ///  Сущность "Связь новость - роль"
    /// </summary>
    [EntityName(Name = "Связь новость - роль")]
    public class NewsLinkRole : LinkRoleBase
    {
        [Display(Name = "Ид")]
        public int NewsId { get; set; }

        [Display(Name = "Новость")]
        [ForeignKey("NewsId")]
        public virtual News News{ get; set; }        
    }
}