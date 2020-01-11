using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Связь метаобъект - модель устройства")]
    public class MetaObjectLinkDevice
    {
        [Display(Name = "Ид")]
        public int MetaObjectId { get; set; }

        [Display(Name = "Ид")]
        public int DeviceId { get; set; }

        [Display(Name = "Метаобъект")]
        [ForeignKey("MetaObjectId")]
        public virtual MetaObject MetaObject { get; set; }

        [Display(Name = "Модель измерительного устройства")]
        [ForeignKey("DeviceId")]
        public virtual Device Device { get; set; }
    }
}