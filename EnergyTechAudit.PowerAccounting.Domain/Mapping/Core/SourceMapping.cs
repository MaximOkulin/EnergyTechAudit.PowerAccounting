using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class SourceMapping : EntityTypeConfiguration<Source>
    {
        public SourceMapping()
        {
            HasKey(t => t.Id);

            ToTable("Source", "Core");
        }
    }
}
