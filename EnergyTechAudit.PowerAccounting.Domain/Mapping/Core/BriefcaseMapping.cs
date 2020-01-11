using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class BriefcaseMapping : EntityTypeConfiguration<Briefcase>
    {
        public BriefcaseMapping()
        {
            HasKey(t => t.Id);
            ToTable("Briefcase", "Core");
        }
    }
}