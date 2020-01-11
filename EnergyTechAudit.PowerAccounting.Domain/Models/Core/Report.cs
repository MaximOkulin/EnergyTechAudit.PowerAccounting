using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using EnergyTechAudit.PowerAccounting.Domain.Attributes;
using EnergyTechAudit.PowerAccounting.Domain.Interfaces;

namespace EnergyTechAudit.PowerAccounting.Domain.Models.Core
{
    [EntityName(Name = "Отчет")]
    public class Report : DictionaryEntityBase, IMetaObjectLinkedEntity
    {
        public Report()
        {
            ReportSelectors = new HashSet<ReportSelector>();
            ReportPluginSelectors = new List<ReportPluginSelector>();
        }

        public byte[] File { get; set; }

        public int ReportTypeId { get; set; }

        public bool HasPluginProcessing { get; set; }

        [InverseProperty("SelectorReport")]
        public virtual ICollection<ReportSelector> ReportSelectors { get; set; }

        [InverseProperty("Report")]
        public virtual ICollection<ReportPluginSelector> ReportPluginSelectors { get; private set; }
    }
}
