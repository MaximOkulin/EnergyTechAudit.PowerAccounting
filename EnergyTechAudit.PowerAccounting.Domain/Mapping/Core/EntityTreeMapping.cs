using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class EntityTreeMapping: EntityTypeConfiguration<EntityTree>
    {
        public EntityTreeMapping()
        {
            HasKey(t => t.Id);

            ToTable("EntityTree", "Core");
        }
    }
}
