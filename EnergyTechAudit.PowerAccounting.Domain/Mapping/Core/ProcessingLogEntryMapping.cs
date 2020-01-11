using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class ProcessingLogEntryMapping : EntityTypeConfiguration<ProcessingLogEntry>
    {
        public ProcessingLogEntryMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Processing)
                .WithMany(t => t.ProcessingLogEntries)
                .HasForeignKey(u => u.ProcessingId);

            HasRequired(t => t.ProcessingStatus)
                .WithMany(t => t.ProcessingLogEntries)
                .HasForeignKey(u => u.ProcessingStatusId);

            ToTable("ProcessingLogEntry", "Core");
        }
    }
}
