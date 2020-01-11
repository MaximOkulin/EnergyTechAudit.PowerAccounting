using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ReportPluginSelectorMapping : EntityTypeConfiguration<ReportPluginSelector>
    {
        public ReportPluginSelectorMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Report)
                .WithMany(t => t.ReportPluginSelectors)
                .HasForeignKey(d => d.ReportId);

            ToTable("ReportPluginSelector", "Core");
        }
    }
}
