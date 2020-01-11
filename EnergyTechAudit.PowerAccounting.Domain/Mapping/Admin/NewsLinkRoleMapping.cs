using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Admin;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Admin
{
    public class NewsLinkRoleMapping : EntityTypeConfiguration<NewsLinkRole>
    {
        public NewsLinkRoleMapping()
        {
            HasKey(k => new
            {
                k.NewsId,
                k.RoleId
            });

            HasRequired(t => t.News)
                .WithMany(t => t.NewsLinksRole)
                .HasForeignKey(d => d.NewsId);

            HasRequired(t => t.Role)
                .WithMany(t => t.NewsLinksRole)
                .HasForeignKey(d => d.RoleId);

            ToTable("NewsLinkRole", "Admin");
        }
    }
}
