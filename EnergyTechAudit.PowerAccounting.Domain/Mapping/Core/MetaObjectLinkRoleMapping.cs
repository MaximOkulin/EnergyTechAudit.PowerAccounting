using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MetaObjectLinkRoleMapping : EntityTypeConfiguration<MetaObjectLinkRole>
    {
        public MetaObjectLinkRoleMapping()
        {
            HasKey(k => new
            {
                k.MetaObjectId,
                k.RoleId
            });

            HasRequired(t => t.MetaObject)
                .WithMany(t => t.MetaObjectLinksRole)
                .HasForeignKey(d => d.MetaObjectId);

            HasRequired(t => t.Role)
                .WithMany(t => t.MetaObjectLinksRole)
                .HasForeignKey(d => d.RoleId);

            ToTable("MetaObjectLinkRole", "Core");
        }
    }
}