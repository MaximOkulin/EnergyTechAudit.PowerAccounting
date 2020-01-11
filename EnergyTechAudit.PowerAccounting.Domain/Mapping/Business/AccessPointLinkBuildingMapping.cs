using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class AccessPointLinkBuildingMapping : EntityTypeConfiguration<AccessPointLinkBuilding>
    {
        public AccessPointLinkBuildingMapping()
        {
            HasKey(k => new 
            {
                k.AccessPointId,
                k.BuildingId
            });

            HasRequired(t => t.AccessPoint)
                .WithMany(t => t.AccessPointLinksBuilding)
                .HasForeignKey(d => d.AccessPointId);

            HasRequired(t => t.Building)
                .WithMany(t => t.AccessPointLinksBuilding)
                .HasForeignKey(d => d.BuildingId);

            ToTable("AccessPointLinkBuilding", "Business");
        }
    }
}
