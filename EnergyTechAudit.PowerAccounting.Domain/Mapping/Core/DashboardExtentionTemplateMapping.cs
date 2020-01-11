using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class DashboardExtentionTemplateMapping : EntityTypeConfiguration<DashboardExtentionTemplate>
    {
        public DashboardExtentionTemplateMapping()
        {
            HasKey(t => t.Id);
            ToTable("DashboardExtentionTemplate", "Core");
        }
    }
}