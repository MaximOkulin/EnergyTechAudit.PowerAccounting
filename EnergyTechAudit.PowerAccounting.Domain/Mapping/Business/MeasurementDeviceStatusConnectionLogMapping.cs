using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class MeasurementDeviceStatusConnectionLogMapping : EntityTypeConfiguration<MeasurementDeviceStatusConnectionLog>
    {
        public MeasurementDeviceStatusConnectionLogMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.MeasurementDevice)
                .WithMany(p => p.MeasurementDeviceStatusConnectionLogs)
                .HasForeignKey(u => u.MeasurementDeviceId);

            HasRequired(p => p.StatusConnection)
                .WithMany(p => p.MeasurementDeviceStatusConnectionLogs)
                .HasForeignKey(u => u.StatusConnectionId);

            ToTable("MeasurementDeviceStatusConnectionLog", "Business");
        }
    }
}
