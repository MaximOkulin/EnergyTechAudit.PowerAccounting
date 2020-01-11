using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Core;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Core
{
    public class PivotMapping: EntityTypeConfiguration<Pivot>
    {
        public PivotMapping()
        {
            HasKey(t => t.Id);
           
            Property(c => c.Code)
                .IsRequired()
                .HasMaxLength(16);

            Property(c => c.Description)
                .HasMaxLength(128);

            ToTable("Pivot", "Core" );
        }
    }
}
