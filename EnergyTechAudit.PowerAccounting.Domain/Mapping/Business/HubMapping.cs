using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class HubMapping : EntityTypeConfiguration<Hub>
    {
        public HubMapping()
        {
            HasKey(t => t.Id);

            Property(c => c.FactoryNumber).IsRequired();

            Property(c => c.Identifier).IsRequired();

            ToTable("Hub", "Business");
        }
    }
}
