using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ReportSelectorMapping : EntityTypeConfiguration<ReportSelector>
    {
        public ReportSelectorMapping()
        {
            HasKey(t => t.TargetReportId);

            ToTable("ReportSelector", "Core");
        }
    }
}