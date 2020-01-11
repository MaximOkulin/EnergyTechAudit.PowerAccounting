
using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class MeasurementDeviceMapping : EntityTypeConfiguration<MeasurementDevice>
    {
        public MeasurementDeviceMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Device)
                .WithMany(t => t.MeasurementDevices)
                .HasForeignKey(d => d.DeviceId);

            HasRequired(t => t.ProtocolSubType)
                .WithMany(t => t.MeasurementDevices)
                .HasForeignKey(d => d.ProtocolSubTypeId);

            ToTable("MeasurementDevice", "Business");
        }
    }
}
