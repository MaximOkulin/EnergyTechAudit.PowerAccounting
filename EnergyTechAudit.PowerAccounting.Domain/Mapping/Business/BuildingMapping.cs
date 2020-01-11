using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class BuildingMapping : EntityTypeConfiguration<Building>
    {
        public BuildingMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.BuildingPurpose)
                .WithMany(t => t.Buildings)
                .HasForeignKey(d => d.BuildingPurposeId);

            ToTable("Building", "Business");
        }
    }
}
