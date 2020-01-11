using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Core.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Обработка")]
    public class Processing : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
        public Processing()
        {
            ProcessingLogEntries = new List<ProcessingLogEntry>();
        }

        [Display(Name="Асихронная")]
        public bool IsAsync { get; set; }

        [Display(Name =  "Логи выполнения обработки")]
        [InverseProperty("Processing"), SuppressInverseLinkedEntity]
        public virtual ICollection<ProcessingLogEntry> ProcessingLogEntries { get; private set; }
    }
}
