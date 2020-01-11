using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DistrictMapping : EntityTypeConfiguration<District>
    {
        public DistrictMapping()
        {
            HasKey(t => t.Id);
            ToTable("District", "Dictionaries");
        }
    }
}