using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Связь считыватель устройств - элемент расписания")]
    [AllowDeleteMultipleToMultipleRightEntity]
    [AllowDeleteCascadeLinkedEntity]
    public class DeviceReaderLinkScheduleItem
    {
        [Display(Name = "Ид")]
        public int DeviceReaderId { get; set; }

        [Display(Name = "Ид")]
        public int ScheduleItemId { get; set; }

        [Display(Name = "Считыватель устройств")]
        [ForeignKey("DeviceReaderId")]
        public virtual DeviceReader DeviceReader { get; set; }

        [Display(Name = "Элемент расписания")]
        [ForeignKey("ScheduleItemId")]
        public virtual ScheduleItem ScheduleItem { get; set; }
    }
}
