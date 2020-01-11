using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь информация о пользователе - элемент расписания")]
    [AllowDeleteMultipleToMultipleRightEntity]
    [AllowDeleteCascadeLinkedEntity]
    public class UserAdditionalInfoLinkScheduleItem
    {
        [Display(Name = "Ид")]
        public int UserAdditionalInfoId { get; set; }
        [Display(Name = "Ид")]
        public int ScheduleItemId { get; set; }

        [Display(Name = "Информация о пользователе")]
        [ForeignKey("UserAdditionalInfoId")]
        public virtual UserAdditionalInfo UserAdditionalInfo { get; set; }

        [Display(Name = "Элемент расписания")]
        [ForeignKey("ScheduleItemId")]
        public virtual ScheduleItem ScheduleItem { get; set; }
    }
}
