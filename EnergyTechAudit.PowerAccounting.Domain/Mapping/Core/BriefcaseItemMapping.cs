using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class BriefcaseItemMapping : EntityTypeConfiguration<BriefcaseItem>
    {
        public BriefcaseItemMapping()
        {
            HasKey(t => t.Id);
            ToTable("BriefcaseItem", "Core");
        }
    }
}