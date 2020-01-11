using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries
{
    [EntityName(Name = "Статус выполнения обработки")]
    public class ProcessingStatus : DictionaryEntityBase
    {
        public ProcessingStatus()
        {
            ProcessingLogEntries = new List<ProcessingLogEntry>();
        }

        [Display(Name = "Логи выполнения обработки")]
        [InverseProperty("ProcessingStatus")]
        public virtual ICollection<ProcessingLogEntry> ProcessingLogEntries { get; private set; }
    }
}
