using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Rules
{
    public class DeviceArchiveTimeConverter : IEntity
    {
        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int DeviceId { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int PeriodTypeId { get; set; }

        [Display(Name = "Выражение")]
        [Required]
        public string Expression { get; set; }

        [Display(Name = "Интервал коррекции для приведения к архивному времени прибора, сек")]
        [Required]
        public int Interval { get; set; }

        [Display(Name = "Модель прибора")]
        [ForeignKey("DeviceId")]
        public virtual Device Device { get; set; }

        [Display(Name = "Тип периода")]
        [ForeignKey("PeriodTypeId")]
        public virtual PeriodType PeriodType { get; set; }
    }
}
