using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.EnumTypes;

namespace EnergyTechAudit.PowerAccounting.Domain.Interfaces
{
    [EntityName(Name = "Базовый класс лога")]
    public abstract class ErrorLogEntryBase : IEntity, IServerTimeSignatureEntity
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        [Display(Name = "Ид")]
        [DoOrderGrid(GridColumnSortOrder.Descending)]
        public int Id { get; set; }

        [Display(Name = "Время")]
        
        public DateTime Time { get; set; }

        [Display(Name = "Исключение"), NotDisplayGrid]
        public string Exception { get; set; }

        [Display(Name = "Сообщение")]
        public string Message { get; set; }

        [Display(Name = "Трассировка стека"), NotDisplayGrid]
        public string StackTrace { get; set; }
    }
}
