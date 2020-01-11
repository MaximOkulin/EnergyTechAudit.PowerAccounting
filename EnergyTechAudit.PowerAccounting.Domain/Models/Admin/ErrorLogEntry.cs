using System.ComponentModel.DataAnnotations;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// Сущность "Запись в лог системы"
    /// </summary>
    [EntityName(Name = "Запись в лог системы")]
    public class ErrorLogEntry: ErrorLogEntryBase
    {
        [Display(Name = "Пользователь")]
        public string UserName { get; set; }

        [Display(Name = "Браузер")]
        public string UserAgent { get; set; }
 
        [Display(Name = "Параметры запроса")]
        public string RequestParams { get; set; }

    }
}