using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class CsdModemMapping : EntityTypeConfiguration<CsdModem>
    {
        public CsdModemMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Device)
                .WithMany(t => t.CsdModems)
                .HasForeignKey(u => u.DeviceId);

            ToTable("CsdModem", "Business");
        }
    }
}
