using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DeviceParameterMapping : EntityTypeConfiguration<DeviceParameter>
    {
        public DeviceParameterMapping()
        {
            HasKey(t => t.Id);

            HasRequired(p => p.Device)
                .WithMany(p => p.DeviceParameters)
                .HasForeignKey(d => d.DeviceId);

            ToTable("DeviceParameter", "Dictionaries");
        }
    }
}
