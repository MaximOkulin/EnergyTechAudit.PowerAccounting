using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;
using Newtonsoft.Json;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    

    /// <summary>
    /// Сущность "Статус подключения к точке доступа"
    /// </summary>
    [EntityName(Name = "Статус подключения к точке доступа")]
    public class AccessPointStatusConnectionLog : IEntity, IStatusConnectionLog
    {
        public AccessPointStatusConnectionLog()
        {
            ConnectionTime = new DateTime(1900, 1, 1);
            StatusConnectionId = 1;
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Время подключения")]
        [Required]
        public DateTime ConnectionTime { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int StatusConnectionId { get; set; }

        [Display(Name = "Статус подключения")]
        [ForeignKey("StatusConnectionId")]
        [JsonIgnore]
        public virtual StatusConnection StatusConnection { get; set; }

        [Display(Name = "Ид")]
        [Required]
        public int AccessPointId { get; set; }

        [Display(Name = "Точка доступа")]
        [ForeignKey("AccessPointId")]
        [JsonIgnore]
        public virtual AccessPoint AccessPoint { get; set; }
    }
}
