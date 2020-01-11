using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    public class UserLinkEmergencyNotificationType : IEntity
    {
        public UserLinkEmergencyNotificationType()
        {
            RepetitionMinutes = 720;
        }

        [Key]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int EmergencySituationParameterId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int UserAdditionalInfoId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int NotificationTypeId { get; set; }

        [Display(Name = "Интервал повторения сообщений (мин.)")]
        public int RepetitionMinutes { get; set; }

        [ForeignKey("EmergencySituationParameterId")]
        [Display(Name = "Параметр нештатной ситуации")]
        public virtual EmergencySituationParameter EmergencySituationParameter { get; set; }

        [ForeignKey("UserAdditionalInfoId")]
        [Display(Name = "Доп. информация о пользователе")]
        public virtual UserAdditionalInfo UserAdditionalInfo { get; set; }

        [ForeignKey("NotificationTypeId")]
        [Display(Name = "Тип оповещения")]
        public virtual NotificationType NotificationType { get; set; }
    }
}
