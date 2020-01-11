
using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class MeasurementDeviceInfoMapping : EntityTypeConfiguration<MeasurementDevice>
    {
        public MeasurementDeviceInfoMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Device)
                .WithMany(t => t.MeasurementDevices)
                .HasForeignKey(d => d.DeviceId);
           
            
            ToTable("MeasurementDevice", "Business");
        }
    }
}
