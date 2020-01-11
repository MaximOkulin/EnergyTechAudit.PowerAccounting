using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class EntityPropertyMapping : EntityTypeConfiguration<EntityProperty>
    {
        public EntityPropertyMapping()
        {
            HasKey(t => t.Id);

            HasRequired(t => t.Entity)
                .WithMany(t => t.EntityProperties)
                .HasForeignKey(u => u.EntityId);

            ToTable("EntityProperty", "Core");
        }
    }
}
