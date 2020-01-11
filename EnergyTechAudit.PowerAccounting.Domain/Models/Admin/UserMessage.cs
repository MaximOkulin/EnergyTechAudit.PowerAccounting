using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Сообщение пользователя системы"
    /// </summary>
    [EntityName(Name = "Сообщение пользователя системы")]
    public class UserMessage : IEntity
    {
        [Key]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Текст сообщения")]
        [MaxLength(1024)]
        public string Text { get; set; }

        [Display(Name = "Ид")]
        public int UserId { get; set; }

        [Display(Name = "Дата")]
        public DateTime Date { get; set; }

        [Display(Name = "Отправитель сообщения")]
        [ForeignKey("UserId")]
        public virtual User User { get; set; }
    }
}