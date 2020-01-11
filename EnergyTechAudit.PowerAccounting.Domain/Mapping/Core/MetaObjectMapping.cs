using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class MetaObjectMapping: EntityTypeConfiguration<MetaObject>
    {
        public MetaObjectMapping()
        {
            HasKey(t => t.Id);
           
            ToTable("MetaObject", "Core");
        }
    }
}
