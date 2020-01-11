using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь пользователь - канал")]
    [AllowDeleteCascadeLinkedEntity]
    public class UserLinkChannel
    {

        [Display(Name = "Ид")]
        public int UserId { get; set; }

        [Display(Name = "Ид")]
        public int ChannelId { get; set; }

        [Display(Name = "Пользователь")]
        [ForeignKey("UserId")]
        public virtual User User { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("ChannelId")]
        public virtual Channel Channel { get; set; }
    }
}