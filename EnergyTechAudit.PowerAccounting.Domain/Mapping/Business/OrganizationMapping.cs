using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class OrganizationMapping : EntityTypeConfiguration<Organization>
    {
        public OrganizationMapping()
        {
            HasKey(t => t.Id);

            ToTable("Organization", "Business");
        }
    }
}