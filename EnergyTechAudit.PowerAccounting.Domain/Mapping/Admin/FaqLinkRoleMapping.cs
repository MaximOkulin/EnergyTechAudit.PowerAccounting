using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class FaqLinkRoleMapping : EntityTypeConfiguration<FaqLinkRole>
    {
        public FaqLinkRoleMapping()
        {
            HasKey(k => new
            {
                k.FaqId,
                k.RoleId
            });

            HasRequired(t => t.Faq)
                .WithMany(t => t.FaqLinksRole)
                .HasForeignKey(d => d.FaqId);

            HasRequired(t => t.Role)
                .WithMany(t => t.FaqLinksRole)
                .HasForeignKey(d => d.RoleId);

            ToTable("FaqLinkRole", "Admin");
        }
    }
}