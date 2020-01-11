using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using System.Data.Entity.ModelConfiguration;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class MeasurementDeviceLinkScheduleItemMapping : EntityTypeConfiguration<MeasurementDeviceLinkScheduleItem>
    {
        public MeasurementDeviceLinkScheduleItemMapping()
        {
            HasKey(k => new
            {
                k.MeasurementDeviceId,
                k.ScheduleItemId
            });

            HasRequired(t => t.MeasurementDevice)
                .WithMany(t => t.MeasurementDeviceLinksScheduleItem)
                .HasForeignKey(d => d.MeasurementDeviceId);

            HasRequired(t => t.ScheduleItem)
                .WithMany(t => t.MeasurementDeviceLinksScheduleItem)
                .HasForeignKey(d => d.ScheduleItemId);

            ToTable("MeasurementDeviceLinkScheduleItem", "Business");
        }
    }
}
