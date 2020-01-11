using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class ArchiveMapping : EntityTypeConfiguration<Archive>
    {
        public ArchiveMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.TimeSignature)
                .WithMany(t => t.Archives)
                .HasForeignKey(d => d.TimeSignatureId);

            HasRequired(t => t.PeriodType)
                .WithMany(t => t.Archives)
                .HasForeignKey(d => d.PeriodTypeId);

            HasRequired(t => t.MeasurementDevice)
                .WithMany(t => t.Archives)
                .HasForeignKey(d => d.MeasurementDeviceId);

            HasRequired(t => t.DeviceParameter)
                .WithMany(t => t.Archives)
                .HasForeignKey(d => d.DeviceParameterId);

            Property(x => x.Value).HasPrecision(19, 7);

            ToTable("Archive", "Business");
        }
    }
}
