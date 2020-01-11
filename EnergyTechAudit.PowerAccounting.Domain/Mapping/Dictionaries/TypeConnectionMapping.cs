using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class TypeConnectionMapping: EntityTypeConfiguration<TypeConnection>
    {
        public TypeConnectionMapping()
        {
            HasKey(c => c.Id);
            Property(c => c.Code)
                .IsRequired()
                .HasMaxLength(16);
            Property(c => c.Description)
                .HasMaxLength(128);

            ToTable("TypeConnection", "Dictionaries");            
        }
    }
}