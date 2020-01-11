using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class EntityTreeLinkRoleMapping : EntityTypeConfiguration<EntityTreeLinkRole>
    {
        public EntityTreeLinkRoleMapping()
        {
            HasKey(k => new 
            {
                k.EntityTreeId,
                k.RoleId
            });

            HasRequired(t => t.EntityTree)
                .WithMany(t => t.EntityTreeLinksRole)
                .HasForeignKey(d => d.EntityTreeId);

            HasRequired(t => t.Role)
                .WithMany(t => t.EntityTreeLinksRole)
                .HasForeignKey(d => d.RoleId);

            ToTable("EntityTreeLinkRole", "Core");
        }
    }
}
