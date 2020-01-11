using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Информация об интегральных архивах")]
    [AllowDeleteCascadeLinkedEntity]
    public class IntegrationArchiveInfo : IEntity
    {
        [Display(Name = "Ид")]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        public int MeasurementDeviceId { get; set; }

        [Display(Name = "Ид")]
        public int PeriodTypeId { get; set; }

        [Display(Name = "Ид")]
        public int DiffDeviceParameterId { get; set; }

        public DateTime? LastCalculatedDate { get; set; }

        public DateTime? CurrentArchiveDate { get; set; }

        [Display(Name = "Прибор")]
        [ForeignKey("MeasurementDeviceId")]
        public virtual MeasurementDevice MeasurementDevice { get; set; }

        [Display(Name = "Тип периода")]
        [ForeignKey("PeriodTypeId")]
        public virtual PeriodType PeriodType { get; set; }

        [Display(Name = "Разностный параметр прибора")]
        [ForeignKey("DiffDeviceParameterId")]
        public virtual DeviceParameter DiffDeviceParameter { get; set; }
    }
}
