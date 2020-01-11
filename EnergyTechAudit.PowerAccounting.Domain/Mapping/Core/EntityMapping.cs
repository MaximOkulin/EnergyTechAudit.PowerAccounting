using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class EntityMapping : EntityTypeConfiguration<Entity>
    {
        public EntityMapping()
        {
            HasKey(p => p.Id);

            ToTable("Entity", "Core");
        }
    }
}
