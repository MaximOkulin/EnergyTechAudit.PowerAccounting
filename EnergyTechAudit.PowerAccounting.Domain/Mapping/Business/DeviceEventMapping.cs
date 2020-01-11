using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceEventMapping : EntityTypeConfiguration<DeviceEvent>
    {
        public DeviceEventMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.DeviceEventParameter)
                .WithMany(t => t.DeviceEvents)
                .HasForeignKey(d => d.DeviceEventParameterId);

            HasRequired(t => t.MeasurementDevice)
                .WithMany(t => t.Events)
                .HasForeignKey(d => d.MeasurementDeviceId);

            Property(x => x.State).HasPrecision(19, 7);

            ToTable("DeviceEvent", "Business");
        }
    }
}
