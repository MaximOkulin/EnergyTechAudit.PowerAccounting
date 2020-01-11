using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DeviceEventParameterMapping : EntityTypeConfiguration<DeviceEventParameter>
    {
        public DeviceEventParameterMapping()
        {
            HasKey(c => c.Id);
            ToTable("DeviceEventParameter", "Dictionaries");
        }
    }
}
