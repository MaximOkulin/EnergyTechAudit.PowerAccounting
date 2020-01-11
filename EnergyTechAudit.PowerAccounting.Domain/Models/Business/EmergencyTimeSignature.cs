using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Business
{
    [EntityName(Name = "Временная сигнатура нештатных ситуаций")]
    [PossibleCascadeDeletedEntity]
    public class EmergencyTimeSignature : IEntity, IServerTimeSignatureEntity
    {
        public EmergencyTimeSignature()
        {
            EmergencyLogs = new List<EmergencyLog>();
        }

        [Display(Name = "Ид")]
        [Key]
        public int Id { get; set; }

        [Display(Name = "Время")]
        [Required]
        public DateTime Time { get; set; }

        [Display(Name = "Записи нештатных ситуаций")]
        [InverseProperty("EmergencyTimeSignature")]
        public virtual ICollection<EmergencyLog> EmergencyLogs { get; private set; }
    }
}
