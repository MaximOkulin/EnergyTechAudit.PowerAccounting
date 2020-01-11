using EnergyTechAudit.PowerAccounting.Domain.Models.Business;
using System.Data.Entity.ModelConfiguration;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceReaderLinkScheduleItemMapping : EntityTypeConfiguration<DeviceReaderLinkScheduleItem>
    {
        public DeviceReaderLinkScheduleItemMapping()
        {
            HasKey(k => new
            {
                k.DeviceReaderId,
                k.ScheduleItemId
            });

            HasRequired(t => t.DeviceReader)
                .WithMany(t => t.DeviceReaderLinksScheduleItem)
                .HasForeignKey(d => d.DeviceReaderId);

            HasRequired(t => t.ScheduleItem)
                .WithMany(t => t.DeviceReaderLinksScheduleItem)
                .HasForeignKey(d => d.ScheduleItemId);

            ToTable("DeviceReaderLinkScheduleItem", "Business");
        }
    }
}
