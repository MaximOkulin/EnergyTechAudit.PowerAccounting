using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Значение параметра регулирования")]
    public class RegulatorParameterValue : IEntity, IHistoryChangeTrackEntity
    {
        public RegulatorParameterValue()
        {
            CreatedDate = DateTime.Now;
            UpdatedDate = DateTime.Now;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Ид")]
        public int DeviceParameterId { get; set; }

        [Display(Name = "Значение устройства")]
        [Required]
        public decimal DeviceValue { get; set; }

        [Display(Name = "Значение пользователя")]
        [Required]
        public decimal UserValue { get; set; }

        [Display(Name = "Время синхронизации")]
        [Required]
        public DateTime SyncDeviceTime { get; set; }

        [Display(Name = "Время обновления")]
        public DateTime? UpdateUserValueTime { get; set; }

        [Display(Name = "Измерительный прибор")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Параметр прибора")]
        [ForeignKey("DeviceParameterId")]
        public virtual DeviceParameter DeviceParameter { get; set; }

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
