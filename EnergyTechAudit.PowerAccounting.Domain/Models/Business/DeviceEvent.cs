using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Событие")]
    [AllowDeleteCascadeLinkedEntity]
    public class DeviceEvent : IEntity<long>, IServerTimeSignatureEntity
    {
        public DeviceEvent()
        {
            State = 0M;
            Time = DateTime.Now;
        }

        [Display(Name = "Ид")]
        [Key]
        public long Id { get; set; }

        [Display(Name = "Время возникновения")]
        public DateTime Time { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DeviceEventParameterId { get; set; }

        [Display(Name = "Ид")]
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Состояние")]
        [Required]
        public decimal State { get; set; }
        
        [Display(Name = "Тип события")]
        [ForeignKey("DeviceEventParameterId")]
        public virtual DeviceEventParameter DeviceEventParameter { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }
    }
}
