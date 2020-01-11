using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class PlacementPurposeMapping : EntityTypeConfiguration<PlacementPurpose>
    {
        public PlacementPurposeMapping()
        {
            HasKey(t => t.Id);
            ToTable("PlacementPurpose", "Dictionaries");
        }
    }
}
