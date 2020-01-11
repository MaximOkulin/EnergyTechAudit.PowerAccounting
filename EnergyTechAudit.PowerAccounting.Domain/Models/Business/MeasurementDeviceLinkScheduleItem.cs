using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь измерительное устройство - элемент расписания")]
    [AllowDeleteMultipleToMultipleRightEntity]
    [AllowDeleteCascadeLinkedEntity]
    public class MeasurementDeviceLinkScheduleItem
    {
        [Display(Name = "Ид")]
        public int MeasurementDeviceId { get; set; }
        [Display(Name = "Ид")]
        public int ScheduleItemId { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Элемент расписания")]
        [ForeignKey("ScheduleItemId")]
        public virtual ScheduleItem ScheduleItem { get; set; }
    }
}
