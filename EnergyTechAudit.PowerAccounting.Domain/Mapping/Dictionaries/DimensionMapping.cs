using System.Data.Entity.ModelConfiguration;
using EnergyTechAudit.PowerAccounting.Domain.Models.Dictionaries;

namespace EnergyTechAudit.PowerAccounting.Domain.Mapping.Dictionaries
{
    public class DimensionMapping : EntityTypeConfiguration<Dimension>
    {
        public DimensionMapping()
        {
            HasKey(t => t.Id);

            Property(x => x.Value).HasPrecision(20, 7);

            ToTable("Dimension", "Dictionaries");
        }
    }
}
