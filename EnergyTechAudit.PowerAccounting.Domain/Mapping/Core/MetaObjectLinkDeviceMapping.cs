using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MetaObjectLinkDeviceMapping : EntityTypeConfiguration<MetaObjectLinkDevice>
    {
        public MetaObjectLinkDeviceMapping()
        {
            HasKey(k => new
            {
                k.MetaObjectId,
                k.DeviceId
            });

            HasRequired(t => t.MetaObject)
                .WithMany(t => t.MetaObjectLinksDevice)
                .HasForeignKey(d => d.MetaObjectId);

            HasRequired(t => t.Device)
                .WithMany(t => t.MetaObjectLinksDevice)
                .HasForeignKey(d => d.DeviceId);

            ToTable("MetaObjectLinkDevice", "Core");
        }
    }
}