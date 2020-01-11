using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ReportMapping: EntityTypeConfiguration<Report>
    {
        public ReportMapping()
        {
            HasKey(t => t.Id);

            ToTable("Report", "Core");
        }
    }
}
