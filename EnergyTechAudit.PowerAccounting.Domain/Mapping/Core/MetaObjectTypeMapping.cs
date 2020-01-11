using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MetaObjectTypeMapping: EntityTypeConfiguration<MetaObjectType>
    {
        public MetaObjectTypeMapping()
        {
            HasKey(t => t.Id);
            HasMany(c => c.MetaObjects)
                .WithRequired(c => c.MetaObjectType)
                .WillCascadeOnDelete(false);

            ToTable("MetaObjectType", "Core");
        }
    }
}
