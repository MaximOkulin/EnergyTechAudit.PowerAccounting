
using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DeviceMapping : EntityTypeConfiguration<Device>
    {
        public DeviceMapping()
        {
            HasKey(t => t.Id);

            Property(c => c.ChannelsCount)
                .IsRequired();

            ToTable("Device", "Dictionaries");
        }
    }
}
