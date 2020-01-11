using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ProcessingStatusMapping : EntityTypeConfiguration<ProcessingStatus>
    {
        public ProcessingStatusMapping()
        {
            HasKey(t => t.Id);

            ToTable("ProcessingStatus", "Dictionaries");
        }
    }
}
