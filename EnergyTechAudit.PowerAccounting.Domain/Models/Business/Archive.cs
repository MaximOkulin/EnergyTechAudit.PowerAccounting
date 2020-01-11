using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    /// <summary>
    /// Сущность "Архивная запись показания измерительного прибора"
    /// </summary>
    [EntityName(Name = "Архивная запись показания измерительного прибора")]
    [AllowDeleteCascadeLinkedEntity]
    public class Archive :IEntity<long>, ICloneable, IServerTimeSignatureEntity
    {
        public Archive()
        {
            Value = 0M;
        }

        [Display(Name = "Ид")]
        [Key]
        public long Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int TimeSignatureId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int PeriodTypeId { get; set; }

        // Время формирования значения или время чтения мгновенных значений
        [Display(Name = "Время")] 
        [Required]
        public DateTime Time { get; set; }

        [Display(Name = "Значение")]
        [Required]
        public decimal Value { get; set; } 

        [Display(Name = "Корректность значения")]
        [Required]
        public bool IsValid { get; set; }

        [Display(Name = "Ид")]
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Ид")]
        public int DeviceParameterId { get; set; }

        [Display(Name = "Временная отметка")]
        [ForeignKey("TimeSignatureId")]
        public virtual TimeSignature TimeSignature { get; set; }

        [Display(Name = "Тип периодичности")]
        [ForeignKey("PeriodTypeId")]
        public virtual PeriodType PeriodType { get; set; }

        [Display(Name = "Измерительный прибор")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Параметр прибора")]
        [ForeignKey("DeviceParameterId")]
        public virtual DeviceParameter DeviceParameter { get; set; }

        public object Clone()
        {
            return new Archive
            {
                TimeSignatureId = TimeSignatureId,
                PeriodTypeId = PeriodTypeId,
                Time = Time,
                Value = Value,
                MeasurementDeviceId =  MeasurementDeviceId,
                DeviceParameterId = DeviceParameterId,
                IsValid = IsValid
            };
        }
    }
}
