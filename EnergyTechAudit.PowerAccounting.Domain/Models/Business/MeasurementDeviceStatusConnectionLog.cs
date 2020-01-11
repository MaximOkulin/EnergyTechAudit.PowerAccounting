using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Лог статусов подключения")]
    public class MeasurementDeviceStatusConnectionLog: IEntity, IStatusConnectionLog
    {
        public MeasurementDeviceStatusConnectionLog()
        {
            ConnectionTime = new DateTime(1900, 1, 1);
            StatusConnectionId = 1;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Время")]
        [Required]
        public DateTime ConnectionTime { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int StatusConnectionId { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("MeasurementDeviceId")]
        public MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Статус подключения")]
        [ForeignKey("StatusConnectionId")]
        public StatusConnection StatusConnection { get; set; }
    }
}
