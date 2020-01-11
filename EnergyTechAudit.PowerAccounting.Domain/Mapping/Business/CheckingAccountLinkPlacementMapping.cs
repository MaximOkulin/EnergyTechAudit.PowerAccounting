using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Business;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Business
{
    public class CheckingAccountLinkPlacementMapping : EntityTypeConfiguration<CheckingAccountLinkPlacement>
    {
        public CheckingAccountLinkPlacementMapping()
        {
            HasKey(k => new
            {
                k.CheckingAccountId,
                k.PlacementId
            });

            HasRequired(t => t.CheckingAccount)
                .WithMany(t => t.CheckingAccountLinksPlacement)
                .HasForeignKey(d => d.CheckingAccountId);

            HasRequired(t => t.Placement)
                .WithMany(t => t.CheckingAccountLinksPlacement)
                .HasForeignKey(d => d.PlacementId);

            ToTable("CheckingAccountLinkPlacement", "Business");
        }
    }
}