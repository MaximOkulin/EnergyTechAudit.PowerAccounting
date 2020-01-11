using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ResourceSystemTypeMapping : EntityTypeConfiguration<ResourceSystemType>
    {
        public ResourceSystemTypeMapping()
        {
            HasKey(t => t.Id);
            ToTable("ResourceSystemType", "Dictionaries");
        }
    }
}
