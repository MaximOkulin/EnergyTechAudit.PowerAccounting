using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{

    /// <summary>
    /// Сущность "Временная отметка" (для сбора показаний приборов)
    /// </summary>
    [EntityName(Name = "Временная отметка")]    
    public class TimeSignature : IEntity, IServerTimeSignatureEntity
    {
        public TimeSignature()
        {
            Archives = new List<Archive>();
        }        
         
       
        public override string ToString()
        {
            return string.Format(
                "Время сервера: {0}{2}{2}Время устройства: {1}", 
                Time, 
                DeviceTime, 
                "<br/>");
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Required]
        [Display(Name = "Ид")]
        public int MeasurementDeviceId { get; set; }

        // Время чтения значения считывателем
        [Display(Name = "Время сервера")]
        [Required]
        public DateTime Time { get; set; }

        [Display(Name = "Время устройства")]
        [Required]
        public DateTime DeviceTime { get; set; }

        [Display(Name = "Общее время опроса (сек.)")]
        public int PollingDuration { get; set; }

        [Display(Name = "Измерительное устройство")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [InverseProperty("TimeSignature")]
        public virtual ICollection<Archive> Archives { get; private set; }
    }
}
