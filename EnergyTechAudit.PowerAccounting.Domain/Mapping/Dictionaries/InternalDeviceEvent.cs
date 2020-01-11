using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class InternalDeviceEventMapping : EntityTypeConfiguration<InternalDeviceEvent>
    {
        public InternalDeviceEventMapping()
        {
            HasKey(t => t.Id);

            HasRequired(p => p.Device)
                .WithMany(p => p.InternalDeviceEvents)
                .HasForeignKey(t => t.DeviceId);

            ToTable("InternalDeviceEvent", "Dictionaries");
        }
    }
}
