using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class PlacementMapping : EntityTypeConfiguration<Placement>
    {
        public PlacementMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.PlacementPurpose)
                .WithMany(t => t.Placements)
                .HasForeignKey(d => d.PlacementPurposeId);

            HasRequired(t => t.Building)
                .WithMany(t => t.Placements)
                .HasForeignKey(d => d.BuildingId);            

            ToTable("Placement", "Business");
        }
    }
}
