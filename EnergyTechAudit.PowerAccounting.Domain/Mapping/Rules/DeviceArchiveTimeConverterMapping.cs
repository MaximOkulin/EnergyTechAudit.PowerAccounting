using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Rules;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Rules
{
    public class DeviceArchiveTimeConverterMapping : EntityTypeConfiguration<DeviceArchiveTimeConverter>
    {
        public DeviceArchiveTimeConverterMapping()
        {
            HasKey(p => p.Id);

            HasRequired(p => p.Device)
                .WithMany(p => p.DeviceArchiveTimeConverters)
                .HasForeignKey(i => i.DeviceId);

            HasRequired(p => p.PeriodType)
                .WithMany(p => p.DeviceArchiveTimeConverters)
                .HasForeignKey(i => i.PeriodTypeId);

            ToTable("DeviceArchiveTimeConverter", "Rules");
        }
    }
}
