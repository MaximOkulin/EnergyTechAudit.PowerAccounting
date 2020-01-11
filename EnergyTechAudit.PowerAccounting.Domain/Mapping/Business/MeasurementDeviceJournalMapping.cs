using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class MeasurementDeviceJournalMapping : EntityTypeConfiguration<MeasurementDeviceJournal>
    {
        public MeasurementDeviceJournalMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.MeasurementDevice)
                .WithMany(t => t.MeasurementDeviceJournals)
                .HasForeignKey(p => p.MeasurementDeviceId);

            HasRequired(t => t.InternalDeviceEvent)
                .WithMany(t => t.MeasurementDeviceJournals)
                .HasForeignKey(p => p.InternalDeviceEventId);

            ToTable("MeasurementDeviceJournal", "Business");
        }
    }
}
