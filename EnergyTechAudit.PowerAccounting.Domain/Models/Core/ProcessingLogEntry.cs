using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [
       EntityName(Name = "Лог выполнения обработки"),
       LoggedDeletedTrackEntity
    ]
    public class ProcessingLogEntry : IEntity, IHistoryChangeTrackEntity
    {
        public ProcessingLogEntry()
        {
            ProcessingStatusId = 1; // "Создана"
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ProcessingId { get; set; }

        [Display(Name = "Параметры обработки")]
        [Required]
        public string Parameters { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int ProcessingStatusId { get; set; }

        [Display(Name = "Обработка")]
        [ForeignKey("ProcessingId")]
        public virtual Processing Processing { get; set; }

        [Display(Name = "Статус выполнения обработки")]
        [ForeignKey("ProcessingStatusId")]
        public virtual ProcessingStatus ProcessingStatus { get; set; }

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
