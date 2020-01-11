using System.ComponentModel.DataAnnotations;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Admin
{
    /// <summary>
    /// История изменения сущности
    /// </summary>

    [EntityName(Name = "История изменения сущности")]
    public class EntityHistory: EntityLogEntryBase
    {
        
        [Display(Name = "Наименование свойства")]
        public string PropertyDescription { get; set; }

        /// <summary>
        /// Имя свойства сущности, подвергнутое изменению
        /// </summary>

        [Display(Name = "Ид свойства")]
        public string PropertyName { get; set; }

        /// <summary>
        /// Старое значение свойства
        /// </summary>

        [Display(Name = "Исходное значение"), MaxLength(256)]
        public string OriginalValue { get; set; }

        /// <summary>
        /// Новое значение свойства
        /// </summary>

        [Display(Name = "Текущее значение"), MaxLength(256)]
        public string CurrentValue { get; set; }

    }
}
