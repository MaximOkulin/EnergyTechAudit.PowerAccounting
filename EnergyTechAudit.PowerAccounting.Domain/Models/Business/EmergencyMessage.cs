using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Сообщение о нештатной ситуации")]
    [AllowDeleteCascadeLinkedEntity]
    public class EmergencyMessage : IEntity, ICloneable
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Время")]
        [Required]
        public DateTime Time { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int NotificationTypeId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int UserAdditionalInfoId { get; set; }

        [Display(Name = "Текст сообщения")]
        public string Text { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int EmergencyLogId { get; set; }

        [Display(Name = "Тип оповещения")]
        [ForeignKey("NotificationTypeId")]
        public NotificationType NotificationType { get; set; }

        [Display(Name = "Сведения о пользователе")]
        [ForeignKey("UserAdditionalInfoId")]
        public UserAdditionalInfo UserAdditionalInfo { get; set; }

        [Display(Name = "Запись о нештатной ситуации")]
        [ForeignKey("EmergencyLogId")]
        public EmergencyLog EmergencyLog { get; set; }

        public object Clone()
        {
            return new EmergencyMessage
            {
                Time = Time,
                NotificationTypeId = NotificationTypeId,
                UserAdditionalInfoId = UserAdditionalInfoId,
                EmergencyLogId = EmergencyLogId,
                Text = Text
            };
        }
    }
}
