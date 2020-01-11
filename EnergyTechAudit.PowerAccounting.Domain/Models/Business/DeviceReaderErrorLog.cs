using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Запись читателя устройств в лог ошибок")]
    [AllowDeleteCascadeLinkedEntity]
    public class DeviceReaderErrorLog : ErrorLogEntryBase
    {
        [Display(Name = "Ид"), NotDisplayGrid]
        public int? DeviceReaderId { get; set; }

        [Display(Name = "Ид"), NotDisplayGrid]
        public int? MeasurementDeviceId { get; set; }

        [Display(Name = "Ид")]
        public int? ErrorTypeId { get; set; }

        [Display(Name = "Доп. информация")]
        public string Text { get; set; }

        [Display(Name = "Считыватель данных"), NotDisplayGrid]
        [ForeignKey("DeviceReaderId")]
        public virtual DeviceReader DeviceReader { get; set; }

        [Display(Name = "Измерительное устройство"), NotDisplayGrid]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Тип ошибки")]
        [ForeignKey("ErrorTypeId")]
        public virtual ErrorType ErrorType { get; set; }
    }
}
