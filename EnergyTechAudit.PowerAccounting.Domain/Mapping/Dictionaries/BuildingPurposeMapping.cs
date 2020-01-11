using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class BuildingPurposeMapping : EntityTypeConfiguration<BuildingPurpose>
    {
        public BuildingPurposeMapping()
        {
            HasKey(t => t.Id);
            ToTable("BuildingPurpose", "Dictionaries");
        }
    }
}
