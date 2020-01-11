using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    public class InternalDeviceEvent : DictionaryEntityBase
    {
        public InternalDeviceEvent()
        {
            MeasurementDeviceJournals = new List<MeasurementDeviceJournal>();
        }

        [Display(Name = "Ид")]
        [Required]
        public int DeviceId { get; set; }

        [Display(Name = "Модель устройства")]
        [ForeignKey("DeviceId")]
        public virtual Device Device { get; set; }

        [Display(Name = "Журналы изменений")]
        [InverseProperty("InternalDeviceEvent")]
        public virtual ICollection<MeasurementDeviceJournal> MeasurementDeviceJournals { get; private set; }
    }
}
