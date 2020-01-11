using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class OrganizationTypeMapping : EntityTypeConfiguration<OrganizationType>
    {
        public OrganizationTypeMapping()
        {
            HasKey(t => t.Id);

            ToTable("OrganizationType", "Dictionaries");
        }
    }
}
