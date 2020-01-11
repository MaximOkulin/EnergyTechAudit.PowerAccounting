using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.WebApi
{
    [EntityName(Name = "Связь пользователь выгрузки архивов - элемент расписания")]    
    [AllowDeleteMultipleToMultipleRightEntity]
    [AllowDeleteCascadeLinkedEntity]
    public class ArchiveDownloaderLinkScheduleItem
    {
        [Display(Name = "Ид")]
        public int ArchiveDownloaderId { get; set; }

        [Display(Name = "Ид")]
        public int ScheduleItemId { get; set; }

        [Display(Name = "Пользователь")]
        [ForeignKey("ArchiveDownloaderId")]
        public virtual ArchiveDownloader ArchiveDownloader { get; set; }

        [Display(Name = "Элемент расписания")]
        [ForeignKey("ScheduleItemId")]
        public virtual ScheduleItem ScheduleItem { get; set; }
    }
}