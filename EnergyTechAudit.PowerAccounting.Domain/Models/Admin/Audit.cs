using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Common.Helpers;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Аудит"  
    /// </summary>
    [EntityName(Name = "Аудит")]
    public class Audit: IEntity
    {
        [Key]
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Область")]
        public string Area { get; set; }

        [Display(Name = "Контроллер")]
        public string Controller { get; set; }

        [Display(Name = "Действие")]
        [Required]
        public string Action { get; set; }

        [Display(Name = "Время")]
        [Required]
        public DateTime Time { get; set; }
        
        [Display(Name = "Время исполнения")]
        public long Elapsed { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int UserId { get; set; }

        [LinkDisplayGrid(Text = "Параметры действия", ContentType = MimeType.Xml)]        
        public string ActionParams { get; set; }

        [Display(Name = "Пользователь")]
        [ForeignKey("UserId")]
        public User User { get; set; }
    }
}
