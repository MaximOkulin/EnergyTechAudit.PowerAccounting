using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    ///  Сущность "Связь FAQ - роль"
    /// </summary>
    [EntityName(Name = "Связь новость - роль")]
    public class FaqLinkRole: LinkRoleBase
    {
        [Display(Name = "Ид")]
        public int FaqId { get; set; }

       
        [Display(Name = "Часто задаваемый вопрос")]
        [ForeignKey("FaqId")]
        public virtual Faq Faq { get; set; }

    }
}