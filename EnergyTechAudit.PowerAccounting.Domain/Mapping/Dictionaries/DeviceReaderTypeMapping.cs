using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DeviceReaderTypeMapping : EntityTypeConfiguration<DeviceReaderType>
    {
        public DeviceReaderTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("DeviceReaderType", "Dictionaries");
        }
    }
}