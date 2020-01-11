using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceReaderMapping : EntityTypeConfiguration<DeviceReader>
    {
        public DeviceReaderMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.User)
                .WithMany(t => t.DeviceReaders)
                .HasForeignKey(d => d.UserId);

            ToTable("DeviceReader", "Business");
        }
    }
}
