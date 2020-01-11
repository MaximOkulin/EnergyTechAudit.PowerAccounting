using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    public class MeasurementDeviceJournal : IEntity, IServerTimeSignatureEntity
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Время")]
        [Required]
        public DateTime Time { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int InternalDeviceEventId { get; set; }

        [Display(Name = "Дополнительное описание")]
        public string Description { get; set; }

        [Display(Name = "Старое значение")]
        public string OriginalValue { get; set; }

        [Display(Name = "Новое значение")]
        public string CurrentValue { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Внутреннее событие прибора")]
        [ForeignKey("InternalDeviceEventId")]
        public virtual InternalDeviceEvent InternalDeviceEvent { get; set; }
    }
}
