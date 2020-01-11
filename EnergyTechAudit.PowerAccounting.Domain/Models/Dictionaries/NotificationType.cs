using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    public class NotificationType : DictionaryEntityBase
    {
        public NotificationType()
        {
            UserLinkEmergencyNotificationTypes = new List<UserLinkEmergencyNotificationType>();
            EmergencyMessages = new List<EmergencyMessage>();
        }

        [Display(Name = "Активно")]
        public bool IsActive { get; set; }

        [Display(Name = "Сообщения о нештатных ситуациях")]
        [InverseProperty("NotificationType")]
        public virtual ICollection<EmergencyMessage> EmergencyMessages { get; private set; }

        [Display(Name = "Связи пользователей с типами оповещения о нештатных ситуациях")]
        [InverseProperty("NotificationType")]
        public virtual ICollection<UserLinkEmergencyNotificationType> UserLinkEmergencyNotificationTypes { get; private set; }
    }
}
