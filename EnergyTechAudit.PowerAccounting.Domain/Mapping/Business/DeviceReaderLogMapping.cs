using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class DeviceReaderErrorLogMapping : EntityTypeConfiguration<DeviceReaderErrorLog>
    {
        public DeviceReaderErrorLogMapping()
        {
            HasKey(t => t.Id);

            Property(c => c.Time)
                .IsRequired();

            ToTable("DeviceReaderErrorLog", "Business");
        }
    }
}
