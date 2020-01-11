using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class ResourceSubsystemTypeMapping : EntityTypeConfiguration<ResourceSubsystemType>
    {
        public ResourceSubsystemTypeMapping()
        {
            HasKey(t => t.Id);

            HasRequired(p => p.ResourceSystemType)
                .WithMany(p => p.ResourceSubsystemTypes)
                .HasForeignKey(d => d.ResourceSystemTypeId);

            ToTable("ResourceSubsystemType", "Dictionaries");
        }
    }
}
