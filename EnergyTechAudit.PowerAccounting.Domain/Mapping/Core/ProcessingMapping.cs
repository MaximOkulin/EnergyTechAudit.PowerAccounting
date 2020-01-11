using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ProcessingMapping : EntityTypeConfiguration<Processing>
    {
        public ProcessingMapping()
        {
            HasKey(t => t.Id);

            ToTable("Processing", "Core");
        }
    }
}
