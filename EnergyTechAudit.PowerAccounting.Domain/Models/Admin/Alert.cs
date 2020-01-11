using System;
using System.ComponentModel.DataAnnotations;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    [EntityName(Name = "Уведомления пользователям"), UserRestrictedPermissionEntity, LoggedDeletedTrackEntity]
    [JsonObjectSignalRCamelCasePropertyNames]
    public class Alert: IEntity, IHistoryChangeTrackEntity
    {
        public Alert()
        {
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;    
        }

        [Key]
        [Display(Name = "Ид")]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Текст сообщения"), Required, UserInputRequired]
        [LinkDisplayGrid(Text ="Текст сообщения")]
        public string Message { get; set; }

        [Display(Name = "Тип")]
        public string Type { get; set; }

        [Display(Name = "Таймаут"), Required, UserInputRequired]
        public int TimeOut { get; set; }

        [Display(Name = "Заголовок")]        
        public string Title { get; set; }

        [Display(Name = "Показать кнопку \"Закрыть\"")]
        public bool ShowCloseButton { get; set; }

        [Display(Name = "Время анимации")]
        public int Duration { get; set; }
        
        [Display(Name = "Дата окончания"), Required, UserInputRequired]
        public DateTime PendingDate { get; set; }

        [LinkDisplayGrid(Text = "Инжектируемые стили")]        
        [Display(Name = "Инжектируемые стили")]        
        public string InjectCss { get; set; }
        
        [NotDisplayGrid]
        public string CreatedBy { get; set; }

        [NotDisplayGrid]
        public string UpdatedBy { get; set; }

        [NotDisplayGrid]
        public DateTime CreatedDate { get; set; }

        [NotDisplayGrid]
        public DateTime UpdatedDate { get; set; }
    }
}
