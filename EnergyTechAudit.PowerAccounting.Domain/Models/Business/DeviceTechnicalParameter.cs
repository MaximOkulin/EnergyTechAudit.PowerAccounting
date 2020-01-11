using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using System;
using System.ComponentModel.DataAnnotations;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    public class DeviceTechnicalParameter : IEntity
    {
        [Key]
        public int Id { get; set; }

        [Required]
        public int MeasurementDeviceId { get; set; }
        
        [Required]
        public int DeviceParameterId { get; set; }

        public int DeviceValue { get; set; }
        public string StringValue { get; set; }
        public DateTime Time { get; set; }
    }
}
