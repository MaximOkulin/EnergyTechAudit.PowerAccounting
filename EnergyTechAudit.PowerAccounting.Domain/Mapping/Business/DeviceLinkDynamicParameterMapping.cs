using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceLinkDynamicParameterMapping : EntityTypeConfiguration<DeviceLinkDynamicParameter>
    {
        public DeviceLinkDynamicParameterMapping()
        {
            HasKey(k => new
            {
                k.DeviceId,
                k.DynamicParameterId
            });

            HasRequired(t => t.Device)
                .WithMany(t => t.DeviceLinkDynamicParameter)
                .HasForeignKey(d => d.DeviceId);

            HasRequired(t => t.DynamicParameter)
                .WithMany(t => t.DeviceLinkDynamicParameter)
                .HasForeignKey(d => d.DynamicParameterId);

            ToTable("DeviceLinkDynamicParameter", "Business");
        }
    }
}
